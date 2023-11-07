import { AnimatePresence } from 'framer-motion';
import * as React from 'react';
import Fade, { FadeProps } from './fade';
import { ScaleProps } from './scale';

interface AnimateAppProps {
	isOpen: boolean;
	Transition?: any;
	transitionProps?: FadeProps | ScaleProps;
}

const AnimateApp: React.FunctionComponent<
	React.PropsWithChildren<AnimateAppProps>
> = ({ children, isOpen, Transition = Fade, transitionProps }) => {
	return (
		<AnimatePresence exitBeforeEnter initial={false}>
			{isOpen && (
				<Transition {...transitionProps}>{children}</Transition>
			)}
		</AnimatePresence>
	);
};

export default AnimateApp;
