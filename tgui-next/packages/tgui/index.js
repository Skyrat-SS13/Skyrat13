<<<<<<< HEAD:tgui-next/packages/tgui/index.js
=======
/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

// Polyfills
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/index.js
import 'core-js/es';
import 'core-js/web/immediate';
import 'core-js/web/queue-microtask';
import 'core-js/web/timers';
import 'regenerator-runtime/runtime';
<<<<<<< HEAD:tgui-next/packages/tgui/index.js
import './polyfills';
=======
import './polyfills/html5shiv';
import './polyfills/ie8';
import './polyfills/dom4';
import './polyfills/css-om';
import './polyfills/inferno';

// Themes
import './styles/main.scss';
import './styles/themes/abductor.scss';
import './styles/themes/cardtable.scss';
import './styles/themes/hackerman.scss';
import './styles/themes/malfunction.scss';
import './styles/themes/ntos.scss';
import './styles/themes/paper.scss';
import './styles/themes/retro.scss';
import './styles/themes/syndicate.scss';
import './styles/themes/clockcult.scss';
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/index.js

import { perf } from 'common/perf';
import { render } from 'inferno';
import { setupHotReloading } from 'tgui-dev-server/link/client';
<<<<<<< HEAD:tgui-next/packages/tgui/index.js
import { backendUpdate } from './backend';
import { tridentVersion } from './byond';
=======
import { backendUpdate, backendSuspendSuccess, selectBackend, sendMessage } from './backend';
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/index.js
import { setupDrag } from './drag';
import { createLogger } from './logging';
import { getRoute } from './routes';
import { createStore } from './store';

<<<<<<< HEAD:tgui-next/packages/tgui/index.js
const logger = createLogger();
=======
perf.mark('inception', window.__inception__);
perf.mark('init');

>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/index.js
const store = createStore();
const reactRoot = document.getElementById('react-root');

let initialRender = true;
let handedOverToOldTgui = false;

const renderLayout = () => {
<<<<<<< HEAD:tgui-next/packages/tgui/index.js
  // Short-circuit the renderer
  if (handedOverToOldTgui) {
    return;
  }
  // Mark the beginning of the render
  let startedAt;
  if (process.env.NODE_ENV !== 'production') {
    startedAt = Date.now();
  }
  try {
    const state = store.getState();
    // Initial render setup
    if (initialRender) {
      logger.log('initial render', state);

      // ----- Old TGUI chain-loader: begin -----
      const route = getRoute(state);
      // Route was not found, load old TGUI
      if (!route) {
        logger.info('loading old tgui');
        // Short-circuit the renderer
        handedOverToOldTgui = true;
        // Unsubscribe from updates
        window.update = window.initialize = () => {};
        // IE8: Use a redirection method
        if (tridentVersion <= 4) {
          setTimeout(() => {
            location.href = 'tgui-fallback.html?ref=' + window.__ref__;
          }, 10);
          return;
        }
        // Inject current state into the data holder
        const holder = document.getElementById('data');
        holder.textContent = JSON.stringify(state);
        // Load old TGUI by injecting new scripts
        loadCSS('v4shim.css');
        loadCSS('tgui.css');
        const head = document.getElementsByTagName('head')[0];
        const script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = 'tgui.js';
        head.appendChild(script);
        // Bail
        return;
      }
      // ----- Old TGUI chain-loader: end -----

      // Setup dragging
      setupDrag(state);
    }
    // Start rendering
    const { Layout } = require('./layout');
    const element = <Layout state={state} dispatch={store.dispatch} />;
    render(element, reactRoot);
  }
  catch (err) {
    logger.error('rendering error', err);
=======
  perf.mark('render/start');
  const state = store.getState();
  const { suspended, assets } = selectBackend(state);
  // Initial render setup
  if (initialRender) {
    logger.log('initial render', state);
    // Setup dragging
    if (initialRender !== 'recycled') {
      setupDrag();
    }
  }
  // Start rendering
  const { getRoutedComponent } = require('./routes');
  const Component = getRoutedComponent(state);
  const element = (
    <StoreProvider store={store}>
      <Component />
    </StoreProvider>
  );
  if (!reactRoot) {
    reactRoot = document.getElementById('react-root');
  }
  render(element, reactRoot);
  if (suspended) {
    return;
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/index.js
  }
  perf.mark('render/finish');
  // Report rendering time
  if (process.env.NODE_ENV !== 'production') {
<<<<<<< HEAD:tgui-next/packages/tgui/index.js
    const finishedAt = Date.now();
    const diff = finishedAt - startedAt;
    const diffFrames = (diff / 16.6667).toFixed(2);
    logger.debug(`rendered in ${diff}ms (${diffFrames} frames)`);
    if (initialRender) {
      const diff = finishedAt - window.__inception__;
      const diffFrames = (diff / 16.6667).toFixed(2);
      logger.log(`fully loaded in ${diff}ms (${diffFrames} frames)`);
=======
    if (initialRender === 'recycled') {
      logger.log('rendered in',
        perf.measure('render/start', 'render/finish'));
    }
    else if (initialRender) {
      logger.debug('serving from:', location.href);
      logger.debug('bundle entered in',
        perf.measure('inception', 'init'));
      logger.debug('initialized in',
        perf.measure('init', 'render/start'));
      logger.log('rendered in',
        perf.measure('render/start', 'render/finish'));
      logger.log('fully loaded in',
        perf.measure('inception', 'render/finish'));
    }
    else {
      logger.debug('rendered in',
        perf.measure('render/start', 'render/finish'));
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/index.js
    }
  }
  if (initialRender) {
    initialRender = false;
  }
};

// Parse JSON and report all abnormal JSON strings coming from BYOND
const parseStateJson = json => {
  let reviver = (key, value) => {
    if (typeof value === 'object' && value !== null) {
      if (value.__number__) {
        return parseFloat(value.__number__);
      }
    }
    return value;
  };
  // IE8: No reviver for you!
  // See: https://stackoverflow.com/questions/1288962
<<<<<<< HEAD:tgui-next/packages/tgui/index.js
  if (tridentVersion <= 4) {
=======
  if (Byond.IS_LTE_IE8) {
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/index.js
    reviver = undefined;
  }
  try {
    return JSON.parse(json, reviver);
  }
  catch (err) {
    logger.log(err);
    logger.log('What we got:', json);
    const msg = err && err.message;
    throw new Error('JSON parsing error: ' + msg);
  }
};

const setupApp = () => {
  // Subscribe for redux state updates
  store.subscribe(() => {
    renderLayout();
  });

  // Subscribe for bankend updates
<<<<<<< HEAD:tgui-next/packages/tgui/index.js
  window.update = window.initialize = stateJson => {
    const state = parseStateJson(stateJson);
    // Backend update dispatches a store action
    store.dispatch(backendUpdate(state));
=======
  window.update = messageJson => {
    const { suspended } = selectBackend(store.getState());
    // NOTE: messageJson can be an object only if called manually from console.
    // This is useful for debugging tgui in external browsers, like Chrome.
    const message = typeof messageJson === 'string'
      ? parseStateJson(messageJson)
      : messageJson;
    logger.debug(`received message '${message?.type}'`);
    const { type, payload } = message;
    if (type === 'update') {
      if (suspended) {
        logger.log('resuming');
        initialRender = 'recycled';
      }
      // Backend update dispatches a store action
      store.dispatch(backendUpdate(payload));
      return;
    }
    if (type === 'suspend') {
      store.dispatch(backendSuspendSuccess());
      return;
    }
    if (type === 'ping') {
      sendMessage({
        type: 'pingReply',
      });
      return;
    }
    // Pass the message directly to the store
    store.dispatch(message);
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/index.js
  };

  // Enable hot module reloading
  if (module.hot) {
    setupHotReloading();
    module.hot.accept(['./layout', './routes'], () => {
      renderLayout();
    });
  }

  // Process the early update queue
  while (true) {
    let stateJson = window.__updateQueue__.shift();
    if (!stateJson) {
      break;
    }
    window.update(stateJson);
  }
};

// Setup a fatal error reporter
window.__logger__ = {
  fatal: (error, stack) => {
    // Get last state for debugging purposes
    const backendState = selectBackend(store.getState());
    const reportedState = {
      config: backendState.config,
      suspended: backendState.suspended,
      suspending: backendState.suspending,
    };
    // Send to development server
    logger.log('FatalError:', error || stack);
    logger.log('State:', reportedState);
    // Append this data to the stack
    stack += '\nState: ' + JSON.stringify(reportedState);
    // Return an updated stack
    return stack;
  },
};

// IE8: Wait for DOM to properly load
if (tridentVersion <= 4 && document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', setupApp);
}
else {
  setupApp();
}
