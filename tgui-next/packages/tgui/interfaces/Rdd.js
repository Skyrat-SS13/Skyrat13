import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';

export const Rdd = props => {
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
	  </Section>
	  <Section title="Direction">
		<div>
		  <Box width="108px">
			{previews.map(preview => (
			<div>
				<Button
					key={preview.dir}
					title={preview.dir_name}
					selected={preview.selected}
					style={{
						width: '48px',
						height: '48px',
						padding: 0,
					}}
					 onClick={() => act('dir_n', {
						dir: NORTH,
					})}>
					<Box>
						className={classes([
						  'pipes32x32',
						  preview.dir + '-' + preview.icon_state,
						])}
						style={{
						  transform: 'scale(1.5) translate(17%, 17%)',
						}}
					 </Box>
				<Button
					  key={preview.dir}
					  title={preview.dir_name}
					  selected={preview.selected}
					  style={{
						width: '48px',
						height: '48px',
						padding: 0,
					  }}
					  onClick={() => act('dir_s', {
						dir: SOUTH,
					})}>
					<Box>
						className={classes([
						  'pipes32x32',
						  preview.dir + '-' + preview.icon_state,
						])}
						style={{
						  transform: 'scale(1.5) translate(17%, 17%)',
						}}
					</Box>
				<Button
					  key={preview.dir}
					  title={preview.dir_name}
					  selected={preview.selected}
					  style={{
						width: '48px',
						height: '48px',
						padding: 0,
					  }}
					  onClick={() => act('dir_e', {
						dir: EAST,
					})}>
					<Box>
						className={classes([
						  'pipes32x32',
						  preview.dir + '-' + preview.icon_state,
						])}
						style={{
						  transform: 'scale(1.5) translate(17%, 17%)',
						}}
					</Box>
				<Button
					  key={preview.dir}
					  title={preview.dir_name}
					  selected={preview.selected}
					  style={{
						width: '48px',
						height: '48px',
						padding: 0,
					  }}
					  onClick={() => act('dir_w', {
						dir: WEST,
					})}>
					<Box>
						className={classes([
						  'pipes32x32',
						  preview.dir + '-' + preview.icon_state,
						])}
						style={{
						  transform: 'scale(1.5) translate(17%, 17%)',
						}}
					</Box>
				  ))}
				</Button>
				</Button>
				</Button>
				</Button>
			</div>
		  </Box>
		</div>
      </Section>
    </Fragment>
  );
};
