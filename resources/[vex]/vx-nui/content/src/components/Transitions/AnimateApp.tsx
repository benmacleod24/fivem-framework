import { AnimatePresence } from "framer-motion";
import * as React from "react";
import { useRootContext } from "../../context/root";
import Fade, { FadeProps } from "./Fade";
import { ScaleProps } from "./Scale";

interface AnimateAppProps {
  appName: string;
  Transition?: any;
  transitionProps?: FadeProps | ScaleProps;
}

const AnimateApp: React.FunctionComponent<
  React.PropsWithChildren<AnimateAppProps>
> = ({ appName, children, Transition = Fade, transitionProps }) => {
  const { state } = useRootContext();

  if (!state.isAppReady) return null;

  return (
    <AnimatePresence exitBeforeEnter initial={false}>
      {state.application === appName && (
        <Transition {...transitionProps}>{children}</Transition>
      )}
    </AnimatePresence>
  );
};

export default AnimateApp;
