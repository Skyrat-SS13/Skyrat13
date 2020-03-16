import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';

export const Crayon = props => {
  const { act, data } = useBackend(props);
  const drawables = data.drawables || [];
  return (
    <Fragment>
      {!!capOrChanges && (
        <Section title="Basic">
          <Button
            content="Select New Color"
            onClick={() => act('select_colour')} />
        </Section>
      )}
      <Section title="Stencil">
        <LabeledList>
          {drawables.map(drawable => {
            const items = drawable.items || [];
            return (
              <LabeledList.Item
                key={drawable.name}
                label={drawable.name}>
                {items.map(item => (
                  <Button
                    key={item.item}
                    content={item.item}
                    selected={item.item === data.selected_stencil}
                    onClick={() => act('select_stencil', {
                      item: item.item,
                    })} />
                ))}
              </LabeledList.Item>
            );
          })}
        </LabeledList>
		<Box width="108px">
              {previews.map(preview => (
                <Button
                  key={preview.dir}
                  title={preview.dir_name}
                  selected={preview.selected}
                  style={{
                    width: '48px',
                    height: '48px',
                    padding: 0,
                  }}
                  onClick={() => act('set_dir', {
                    dir: preview.dir,
                  })}>
                  <Box
                    className={classes([
                      'pipes32x32',
                      preview.dir + '-' + preview.icon_state,
                    ])}
                    style={{
                      transform: 'scale(1.5) translate(17%, 17%)',
                    }} />
                </Button>
              ))}
            </Box>
      </Section>
      <Section title="Text">
        <LabeledList>
          <LabeledList.Item label="Current Buffer">
            {data.text_buffer}
          </LabeledList.Item>
        </LabeledList>
        <Button
          content="New Text"
          onClick={() => act('enter_text')} />
      </Section>
    </Fragment>
  );
};
