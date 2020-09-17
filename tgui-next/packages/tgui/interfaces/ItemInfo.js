import { useBackend } from '../backend';
import { Box, Section, LabeledList, Button, ProgressBar, Flex, AnimatedNumber } from '../components';
import { Fragment } from 'inferno';

export const ItemInfo = props => {
  const { act, data } = useBackend(props);
  // Extract `health` and `color` variables from the `data` object.
  const {
    name,
    integrity,
    max_integrity,
    force,
    force_unwielded,
    force_wielded,
    sharpness,
    armor_penetration,
    armor = [],
  } = data;
  const armorTypes = [
    {
      label: 'Melee',
      type: 'melee',
    },
    {
      label: 'Bullet',
      type: 'bullet',
    },
    {
      label: 'Laser',
      type: 'laser',
    },
    {
      label: 'Energy',
      type: 'energy',
    },
    {
      label: 'Bomb',
      type: 'bomb',
    },
    {
      label: 'Biological',
      type: 'bio',
    },
    {
      label: 'Radiation',
      type: 'rad',
    },
    {
      label: 'Fire',
      type: 'fire',
    },
    {
      label: 'Acid',
      type: 'acid',
    },
    {
      label: 'Magic',
      type: 'magic',
    },
    {
      label: 'Wound',
      type: 'wound',
    },
  ];
  return (
    <Fragment>
      <Section
        title={name + ' Specifications'}
        minWidth="210px">
        <LabeledList>
          <LabeledList.Item
            label="Integrity">
            <ProgressBar
              value={integrity}
              minValue={0}
              maxValue={max_integrity}
              color={integrity >= max_integrity/2 ? 'good' : 'bad'} />
          </LabeledList.Item>
          <LabeledList.Item
            label="Force">
            <ProgressBar
              value={force}
              minValue={0}
              maxValue={100}
              color="good">
              {force}
            </ProgressBar>
          </LabeledList.Item>
          <LabeledList.Item
            label="Unwielded Force">
            <ProgressBar
              value={force_unwielded}
              minValue={0}
              maxValue={100}
              color="good">
              {force_unwielded}
            </ProgressBar>
          </LabeledList.Item>
          <LabeledList.Item
            label="Wielded Force">
            <ProgressBar
              value={force_wielded}
              minValue={0}
              maxValue={100}
              color="good">
              {force_wielded}
            </ProgressBar>
          </LabeledList.Item>
          <LabeledList.Item
            label="Armor Penetration">
            <ProgressBar
              value={armor_penetration}
              minValue={0}
              maxValue={100}
              color="good">
              {armor_penetration}
            </ProgressBar>
          </LabeledList.Item>
          <LabeledList.Item
            label="Sharpness">
            <ProgressBar
              value={sharpness === 'Blunt' ? 0 : 1}
              minValue={0}
              maxValue={1}
              color="good">
              {sharpness}
            </ProgressBar>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section
        title={name + ' Armor'}
        minWidth="210px">
        <LabeledList>
          {armorTypes.map(resist => (
            <LabeledList.Item
              key={resist.type}
              label={resist.label}>
              <ProgressBar
                value={armor[resist.type]}
                minValue={0}
                maxValue={100}>
                {armor[resist.type]}
              </ProgressBar>
            </LabeledList.Item>
          ))}
        </LabeledList>
      </Section>
    </Fragment>
  );
};
