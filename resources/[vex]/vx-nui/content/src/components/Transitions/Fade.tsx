import * as React from "react";
import TransitionBase, { MotionFlexProps } from "./TransitionBase";

export interface FadeProps extends MotionFlexProps {
  speed?: number;
}

const Fade: React.FunctionComponent<React.PropsWithChildren<FadeProps>> = ({
  children,
  speed,
  ...rest
}) => {
  const animation = {
    hidden: {
      opacity: 0.1,
      transition: {
        duration: speed || 0.5,
      },
    },
    visible: {
      opacity: 1.0,
      transition: {
        duration: speed || 0.5,
      },
    },
    exit: {
      opacity: 0.1,
      transition: {
        duration: speed || 0.5,
      },
    },
  };

  return (
    <TransitionBase
      w='fit-content'
      h='fit-content'
      pos={(rest.pos && rest.pos) || "absolute"}
      variants={animation}
      initial='hidden'
      exit='exit'
      animate='visible'
      {...rest}
    >
      {children}
    </TransitionBase>
  );
};

export default Fade;
