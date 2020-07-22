import { Section, Button } from '../components';
import { Fragment } from 'inferno';
import { useBackend } from '../backend';

// GAZE AT TRIGG'S INCREDIBLY HORRIBLE JS SKILLS

export const TeamPanel = props => {
  const { act, data } = useBackend(props);
  const { teams } = data;

  // aka "Trigg's shitty parser from byond stuff to
  // tgui stuff because tgui sanitizes input data too well"
  // ...but that name would be a bit too long.
  const parseInfo = info => {
    return (info.map(entry => {
      // if (!entry || !entry[0]) { return; }
      switch (entry[0]) {
        case ("text"): {
          let result = entry[1];
          let formatting = entry[2];
          // You never know what cool stuff people can do with pretty text.
          if (formatting) {
            if (formatting.bold) {
              result = <b>{result}</b>;
            }
            if (formatting.italic) {
              result = <i>{result}</i>;
            }

            result = (
              <font
                color={formatting.color?formatting.color:null}
                size={formatting.size?formatting.size:null}>
                {result}
              </font>
            );
          }

          return result;
        }

        case ("button"): {
          const props = entry[1];
          return (
            <Button
              mx={props.mx}
              mr={props.mr}
              ml={props.ml}
              content={props.content}
              color={props.color}
              icon={props.icon}
              iconRotation={props.iconRotation||0}
              iconSpin={props.iconSpin}
              title={props.title}
              onClick={props.action && (
                () => act(props.action, props.params))}
            />
          );
        }
        case ("br"): return <br />;
          // more?
      }
    }));
  };

  const makeTeam = team => {
    return (
      <Section
        title={
          <Fragment>
            <Button mr={1} icon="pencil-alt"
              title="Rename Team"
              onClick={() => act('rename', { team: team.ref })} />
            {team.name}
            <Button ml={1} icon="volume-up"
              title="Communicate"
              onClick={() => act('communicate', { team: team.ref })} />
            <Button icon="trash-alt"
              title="Delete"
              onClick={() => act('delete', { team: team.ref })} />
          </Fragment>
        }>

        <Section title="Members">
          {team.members.map(parseInfo)}
        </Section>

        <Section title="Objectives">

          {team.objectives.map(objective => {
            return (
              <Fragment key={objective.index}>

                {`${objective.index}. ${objective.explanation_text} `}

                <Button icon="pencil-alt"
                  title="Edit Objective"
                  onClick={() => act('edit_objective',
                    { team: team.ref, target: objective.ref })} />

                <Button icon="trash-alt"
                  title="Remove Objective"
                  onClick={() => act('remove_objective',
                    { team: team.ref, target: objective.ref })} />

                <Button icon="check" color={objective.completed?"good":null}
                  title={"Click to check current completion. "
                  +"Shift-click to toggle current completion."}
                  onClick={e => {
                    if (e.shiftKey) { act('toggle_completion',
                      { team: team.ref, target: objective.ref });
                    }
                    else { act('check_completion',
                      { team: team.ref, target: objective.ref });
                    }
                  }} />

                <br />
              </Fragment>
            ); })}

          <Button icon="plus"
            title="Add Objective"
            onClick={() => act('add_objective', { team: team.ref })} />

        </Section>

        {team.extrainfo && (
          <Section title="Additional Information">
            {parseInfo(team.extrainfo)}
          </Section>
        )}

      </Section>
    ); };
  return (
    teams.length
      ?teams.map(makeTeam)
      :"Oh, looks like there are no teams at the moment. What a shame."
  );
};
