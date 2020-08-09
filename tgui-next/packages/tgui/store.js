/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { flow } from 'common/fp';
<<<<<<< HEAD:tgui-next/packages/tgui/store.js
import { applyMiddleware, createStore as createReduxStore } from 'common/redux';
import { backendReducer } from './backend';
import { hotKeyMiddleware, hotKeyReducer } from './hotkeys';
import { createLogger } from './logging';

const logger = createLogger('store');

// const loggingMiddleware = store => next => action => {
//   const { type, payload } = action;
//   logger.log('dispatching', type);
//   next(action);
// };
=======
import { applyMiddleware, combineReducers, createStore as createReduxStore } from 'common/redux';
import { Component } from 'inferno';
import { backendMiddleware, backendReducer } from './backend';
import { debugReducer } from './debug';
import { hotKeyMiddleware } from './hotkeys';
import { createLogger } from './logging';
import { assetMiddleware } from './assets';

const logger = createLogger('store');
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/store.js

export const createStore = () => {
  const reducer = flow([
    // State initializer
    (state = {}, action) => state,
    combineReducers({
      debug: debugReducer,
      backend: backendReducer,
    }),
  ]);
  const middleware = [
    process.env.NODE_ENV !== 'production' && loggingMiddleware,
    assetMiddleware,
    hotKeyMiddleware,
    backendMiddleware,
  ];
  return createReduxStore(reducer,
    applyMiddleware(...middleware.filter(Boolean)));
};

const loggingMiddleware = store => next => action => {
  const { type, payload } = action;
  if (type === 'backend/update') {
    logger.debug('action', { type });
  }
  else {
    logger.debug('action', action);
  }
  return next(action);
};
