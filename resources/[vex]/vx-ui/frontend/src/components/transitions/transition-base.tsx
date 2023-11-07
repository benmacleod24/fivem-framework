import { Flex, HTMLChakraProps } from '@chakra-ui/react';
import {
	AnimationProps,
	HTMLMotionProps,
	motion,
	TargetAndTransition,
} from 'framer-motion';
import * as React from 'react';

interface TransitionBaseProps extends MotionFlexProps {}

export type Merge<P, T> = Omit<P, keyof T> & T;
export type MotionFlexProps = Merge<
	HTMLChakraProps<'div'>,
	HTMLMotionProps<'div'>
>;

export declare namespace Transitions {
	type Variant = AnimationProps['variants'];
}

export const MotionFlex: React.FC<MotionFlexProps> = motion(Flex);

const TransitionBase: React.FunctionComponent<
	React.PropsWithChildren<TransitionBaseProps>
> = ({ children, ...rest }) => {
	return <MotionFlex {...rest}>{children}</MotionFlex>;
};

export default TransitionBase;
