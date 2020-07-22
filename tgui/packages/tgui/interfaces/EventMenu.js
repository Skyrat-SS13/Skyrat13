import { Fragment } from 'inferno';
import { useBackend, useSharedState } from '../backend';
import { Box, Button, Divider, Section } from '../components';
import { Window } from '../layouts';

export const EventMenu = () => {
  return (
    <Window resizable>
      <Window.Content scrollable>
        <EventMenuInfo />
        <EventMenuAdmin />
        <EventMenuPrefs />
      </Window.Content>
    </Window>
  );
};

const EventMenuPrefs = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    participating,
    event_preferences,
  } = data;
  return (
    <Section title="Preferences">
      <Box mb={1} color="label">
        Look for events:
        <Button
          ml={1}
          selected={participating}
          icon={participating ? 'toggle-on' : 'toggle-off'}
          onClick={() => act('toggle')} />
      </Box>
      <Box mb={1} color={participating ? 'good' : 'average'}>
        {participating && (
          `You are shown as interested in being part of a custom event.`
        ) || (
          `You're not looking to be a part of a custom event.`
        )}
      </Box>
      <Divider />
      <Box color="label" mb={1}>
        Preferences / Ideas:
        <Button
          ml={1}
          icon="pen"
          onClick={() => act('set_pref')} />
      </Box>
      <Box italic>
        {event_preferences || '—'}
      </Box>
    </Section>
  );
};

const EventMenuAdmin = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    is_admin,
    participating_observers = [],
  } = data;
  const [show, setShow] = useSharedState(context, 'showAdmin', is_admin);
  if (!is_admin) {
    return null;
  }
  return (
    <Section
      title="Administration"
      buttons={(
        <Button onClick={() => setShow(!show)}>
          {show ? 'Hide' : 'Show'}
        </Button>
      )}>
      {show && (
        <Fragment>
          {participating_observers.length === 0 && (
            <Box color="label">
              No players.
            </Box>
          )}
          {participating_observers.map(user => (
            <Box key={user.ref}>
              <Button
                mr={1}
                icon="user"
                onClick={() => act('show_panel', {
                  ref: user.ref,
                })} />
              {user.ckey} - {user.time_played}
              {!!user.prefs && (
                <Box color="label" italic ml="28px" mb={1}>
                  {user.prefs}
                </Box>
              )}
            </Box>
          ))}
        </Fragment>
      )}
    </Section>
  );
};

const EventMenuInfo = (props, context) => {
  const { act, data } = useBackend(context);
  const { is_admin } = data;
  const [show, setShow] = useSharedState(context, 'showInfo', !is_admin);
  return (
    <Section
      title="Information"
      buttons={(
        <Button
          onClick={() => setShow(!show)}>
          {show && 'Hide' || 'Show'}
        </Button>
      )}>
      {show && (
        <Box color="label">
          <Box mb={1}>
            Admin created events commonly run during rounds; here you can
            toggle if you&apos;d like to be chosen for them while being
            an observer. You can also set your preferences to what sort
            of events you&apos;d like to be a part of.
          </Box>
          <Box mb={1}>
            You can write your own ideas for an event you&apos;d like to
            be part of, this could be as small, or as large as you&apos;d
            like, but smaller events will be much more likely to be chosen.
            Examples of some smaller events might be being a courier for
            current antags in round, giving TC trade items/special requests,
            or any kind of custom role/character that might be fun for you,
            or the crew. This system is for creating interesting, unique
            roleplay experiences, so we are always looking for creative
            ideas.
          </Box>
          <Box>
            Admins can see which current observers are interested in being
            part of a custom event, along with their preferences, and will
            choose from the list.
          </Box>
        </Box>
      )}
    </Section>
  );
};
