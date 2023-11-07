import * as React from 'react';
import TransitionBase, {
	MotionFlexProps,
	Transitions,
} from './transition-base';

const scaleAnimationConfg = (speed?: number): Transitions.Variant => ({
	hidden: {
		scale: 0,
		transition: {
			ease: 'easeInOut',
			duration: speed || 0.5,
		},
	},
	enter: {
		scale: '100%',
		transition: {
			ease: 'easeInOut',
			duration: speed || 0.5,
		},
	},
	exit: {
		scale: 0,
		transition: {
			ease: 'easeInOut',
			duration: speed || 0.5,
		},
	},
});

export interface ScaleProps extends MotionFlexProps {
	speed?: number;
}

const Scale: React.FunctionComponent<React.PropsWithChildren<ScaleProps>> = ({
	children,
	speed,
	...rest
}) => {
	return (
		<TransitionBase
			variants={scaleAnimationConfg(speed)}
			initial='hidden'
			animate='enter'
			exit='exit'
			{...rest}
		>
			{children}
		</TransitionBase>
	);
};

export default Scale;
