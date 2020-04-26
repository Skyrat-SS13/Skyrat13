import { useBackend } from '../backend';
import { Box, Section, LabeledList, Button, ProgressBar, Flex, AnimatedNumber } from '../components';
import { Fragment } from 'inferno';

export const Sleeper = props => {
  const { act, data } = useBackend(props);

  const {
    occupied,
    open,
    occupant = [],
  } = data;

  const preSortChems = data.chems || [];
  const chems = preSortChems.sort((a, b) => {
    const descA = a.name.toLowerCase();
    const descB = b.name.toLowerCase();
    if (descA < descB) {
      return -1;
    }
    if (descA > descB) {
      return 1;
    }
    return 0;
  });
  const preSortSynth = data.synthchems || [];
  const synthchems = preSortSynth.sort((a, b) => {
    const descA = a.name.toLowerCase();
    const descB = b.name.toLowerCase();
    if (descA < descB) {
      return -1;
    }
    if (descA > descB) {
      return 1;
    }
    return 0;
  });

  const damageTypes = [
    {
      label: 'Brute',
      type: 'bruteLoss',
    },
    {
      label: 'Burn',
      type: 'fireLoss',
    },
    {
      label: 'Toxin',
      type: 'toxLoss',
    },
    {
      label: 'Oxygen',
      type: 'oxyLoss',
    },
    {
      label: 'Cellular',
      type: 'cloneLoss',
    },
  ];

  return (
    <Fragment>
      <Section
        title={occupant.name ? occupant.name : 'No Occupant'}
        minHeight="210px"
        buttons={!!occupant.stat && (
          <Box
            inline
            bold
            color={occupant.statstate}>
            {occupant.stat}
          </Box>
        )}>
        {!!occupied && (
          <Fragment>
            <ProgressBar
              value={occupant.health}
              minValue={occupant.minHealth}
              maxValue={occupant.maxHealth}
              ranges={{
                good: [50, Infinity],
                average: [0, 50],
                bad: [-Infinity, 0],
              }} />
            <Box mt={1} />
            <LabeledList>
              {damageTypes.map(type => (
                <LabeledList.Item
                  key={type.type}
                  label={type.label}>
                  <ProgressBar
                    value={occupant[type.type]}
                    minValue={0}
                    maxValue={occupant.maxHealth}
                    color="bad" />
                </LabeledList.Item>
              ))}
              <LabeledList.Item
                label={'Blood'}>
                <ProgressBar
                  value={data.blood_levels/100}
                  color="bad">
                  <AnimatedNumber value={data.blood_levels} />
                </ProgressBar>
                {data.blood_status}
              </LabeledList.Item>
              <Section title="Internal Organs" width="140px">
                {data.occupant.internal_organs.map(organ => (
                  <LabeledList.Item label={organ.name} key={organ.name}>
                    <ProgressBar
                      value={organ.healthpercentage}
                      minValue={0}
                      maxValue={100}
                      ranges={{
                        good: [75, Infinity],
                        average: [50, 74],
                        bad: [-Infinity, 49],
                      }}
                      width = "120px",
                      minHeight = "260px">
                      <AnimatedNumber value={organ.healthpercentage} />
                    </ProgressBar>
                  </LabeledList.Item>
                ),
                )}
              </Section>
            </LabeledList>
          </Fragment>
        )}
      </Section>
      <Section title="Chemical Analysis">
        <LabeledList.Item label="Chemical Contents">
          {data.chemical_list.map(specificChem => (
            <Box
              key={specificChem.id}
              color="good" >
              {specificChem.volume} units of {specificChem.name}
            </Box>
          ),
          )}
        </LabeledList.Item>
      </Section>
      <Section
        title="Inject Chemicals"
        minHeight="105px"
        buttons={(
          <Button
            icon={open ? 'door-open' : 'door-closed'}
            content={open ? 'Open' : 'Closed'}
            onClick={() => act('door')} />
        )}>
        {chems.map(chem => (
          <Button
            key={chem.name}
            icon="flask"
            content={chem.name}
            disabled={!(occupied && chem.allowed)}
            width="140px"
            onClick={() => act('inject', {
              chem: chem.id,
            })}
          />
        ))}
      </Section>
      <Section
        title="Synthesize Chemicals">
        {synthchems.map(chem => (
          <Button
            key={chem.name}
            content={chem.name}
            width="140px"
            onClick={() => act('synth', {
              chem: chem.id,
            })}
          />
        ))}
      </Section>
      <Section
        title="Purge Chemicals">
        {chems.map(chem => (
          <Button
            key={chem.name}
            content={chem.name}
            disabled={!(chem.allowed)}
            width="140px"
            onClick={() => act('purge', {
              chem: chem.id,
            })}
          />
        ))}
      </Section>
    </Fragment>
  );
};
