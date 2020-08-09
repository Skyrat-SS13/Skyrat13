import { useBackend } from '../backend';
import { Section, LabeledList, ProgressBar, Button, BlockQuote, Grid, Box } from '../components';

<<<<<<< HEAD:tgui-next/packages/tgui/interfaces/SlimeBodySwapper.js
export const BodyEntry = props => {
  const { body, swapFunc } = props;

  const statusMap = {
    Dead: "bad",
    Unconscious: "average",
    Conscious: "good",
  };
=======
const statusMap = {
  Dead: "bad",
  Unconscious: "average",
  Conscious: "good",
};
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/interfaces/SlimeBodySwapper.js

const occupiedMap = {
  owner: "You Are Here",
  stranger: "Occupied",
  available: "Swap",
};

export const BodyEntry = (props, context) => {
  const { body, swapFunc } = props;
  return (
    <Section
      title={(
        <Box inline color={body.htmlcolor}>
          {body.name}
        </Box>
      )}
      level={2}
      buttons={(
        <Button
          content={occupiedMap[body.occupied]}
          selected={body.occupied === 'owner'}
          color={(body.occupied === 'stranger') && 'bad'}
          onClick={() => swapFunc()}
        />
      )}>
      <LabeledList>
        <LabeledList.Item
          label="Status"
          bold
          color={statusMap[body.status]}>
          {body.status}
        </LabeledList.Item>
        <LabeledList.Item label="Jelly">
          {body.exoticblood}
        </LabeledList.Item>
        <LabeledList.Item label="Location">
          {body.area}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

<<<<<<< HEAD:tgui-next/packages/tgui/interfaces/SlimeBodySwapper.js
export const SlimeBodySwapper = props => {
  const { act, data } = useBackend(props);

=======
export const SlimeBodySwapper = (props, context) => {
  const { act, data } = useBackend(context);
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/interfaces/SlimeBodySwapper.js
  const {
    bodies = [],
  } = data;
  return (
<<<<<<< HEAD:tgui-next/packages/tgui/interfaces/SlimeBodySwapper.js
    <Section>
      {bodies.map(body => (
        <BodyEntry
          key={body.name}
          body={body}
          swapFunc={() => act('swap', { ref: body.ref })} />
      ))}
    </Section>
=======
    <Window
      width={400}
      height={400}>
      <Window.Content scrollable>
        <Section>
          {bodies.map(body => (
            <BodyEntry
              key={body.name}
              body={body}
              swapFunc={() => act('swap', { ref: body.ref })} />
          ))}
        </Section>
      </Window.Content>
    </Window>
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/interfaces/SlimeBodySwapper.js
  );
};
