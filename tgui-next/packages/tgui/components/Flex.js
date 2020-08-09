import { classes, pureComponentHooks } from 'common/react';
<<<<<<< HEAD:tgui-next/packages/tgui/components/Flex.js
import { Box } from './Box';
=======
import { Box, unit } from './Box';
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/components/Flex.js

export const computeFlexProps = props => {
  const {
    className,
    direction,
    wrap,
    align,
    justify,
    spacing = 0,
    ...rest
  } = props;
  return {
    className: classes([
      'Flex',
<<<<<<< HEAD:tgui-next/packages/tgui/components/Flex.js
=======
      Byond.IS_LTE_IE10 && (
        direction === 'column'
          ? 'Flex--iefix--column'
          : 'Flex--iefix'
      ),
      inline && 'Flex--inline',
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/components/Flex.js
      spacing > 0 && 'Flex--spacing--' + spacing,
      className,
    ]),
    style: {
      ...rest.style,
      'flex-direction': direction,
      'flex-wrap': wrap,
      'align-items': align,
      'justify-content': justify,
    },
    ...rest,
  };
};

export const Flex = props => (
  <Box {...computeFlexProps(props)} />
);

Flex.defaultHooks = pureComponentHooks;

export const computeFlexItemProps = props => {
  const {
    className,
    grow,
    order,
    align,
    ...rest
  } = props;
  return {
    className: classes([
      'Flex__item',
<<<<<<< HEAD:tgui-next/packages/tgui/components/Flex.js
=======
      Byond.IS_LTE_IE10 && 'Flex__item--iefix',
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4:tgui/packages/tgui/components/Flex.js
      className,
    ]),
    style: {
      ...rest.style,
      'flex-grow': grow,
      'order': order,
      'align-self': align,
    },
    ...rest,
  };
};

export const FlexItem = props => (
  <Box {...computeFlexItemProps(props)} />
);

FlexItem.defaultHooks = pureComponentHooks;

Flex.Item = FlexItem;
