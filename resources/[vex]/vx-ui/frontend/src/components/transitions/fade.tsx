import { transition } from '@chakra-ui/react';
import * as React from 'react';
import TransitionBase, {
	MotionFlexProps,
	Transitions,
} from './transition-base';

const fadeAnimationConfg = (speed?: number): Transitions.Variant => ({
	hidden: {
		opacity: 0.0,
		transition: {
			ease: 'easeInOut',
			duration: speed || 0.5,
		},
	},
	enter: {
		opacity: 1.0,
		transition: {
			ease: 'easeInOut',
			duration: speed || 0.5,
		},
	},
	exit: {
		opacity: 0.0,
		transition: {
			ease: 'easeInOut',
			duration: speed || 0.5,
		},
	},
});

export interface FadeProps extends MotionFlexProps {
	speed?: number;
}

const Fade: React.FunctionComponent<React.PropsWithChildren<FadeProps>> = ({
	children,
	speed,
	...rest
}) => {
	return (
		<TransitionBase
			w='fit-content'
			h='fit-content'
			variants={fadeAnimationConfg(speed)}
			initial='hidden'
			animate='enter'
			exit='exit'
			{...rest}
		>
			{children}
		</TransitionBase>
	);
};

export default Fade;
