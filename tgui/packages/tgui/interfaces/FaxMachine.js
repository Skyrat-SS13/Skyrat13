import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const FaxMachine = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section title="Authorization" >
          <LabeledList>
            <LabeledList.Item label="Confirm Identity:">
              <Button
                icon={"eject"}
                onClick={() => act('scan')}
                content={data.scan_name} />
            </LabeledList.Item>
            <LabeledList.Item label="Authorize:">
              <Button
                icon={data.authenticated ? "unlock" : "lock"}
                onClick={() => act('auth')}
                content={data.authenticated ? 'Log Out' : 'Log In'} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Fax Menu" >
          <LabeledList>
            <LabeledList.Item label="Network">
              <Box color="label">
                {data.network}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Currently Sending">
              <Button
                icon={"eject"}
                onClick={() => act('paper')}
                content={data.paper} />
              <Button
                icon={'pencil'}
                onClick={() => act('rename')}
                content={"Rename"}
                disabled={!data.paperinserted}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Sending to">
              <Button
                icon={'print'}
                onClick={() => act('dept')}
                content={data.destination}
                disabled={!data.authenticated} />
            </LabeledList.Item>
            <LabeledList.Item label="Action">
              <Button
                icon={data.cooldown && data.respectcooldown
                  ? 'clock-o'
                  : "envelope-o"}
                onClick={() => act('send')}
                content={data.cooldown && data.respectcooldown
                  ? "Realigning"
                  : "Send"} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
