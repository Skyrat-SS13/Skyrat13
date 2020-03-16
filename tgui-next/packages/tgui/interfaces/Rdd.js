import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';

export const Rdd = props => {
  const { act, data } = useBackend(props);
  const drawables = data.drawables || [];
  const directions = data.directions || [];
  return (
    <Fragment>
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
		<LabaledList>
		  {directions.map(direction => {
			const items = direction.items || [];
			return (
			  <LabeledList.Item
				key={direction}
				label={irection.name}>
				{items.map(item => (
				  <Button
					key={item.item}
					content={item.item}
					selected={item.item === data.selected_dir}
					onClick={() => act('setdir', {
					  dir: direction,
					})} />
				))}
			  </LabaledList.Item>
			);
		  })}
		</LabaledList>
	  </Section>
    </Fragment>
  );
};
