import { AnimationProps } from "framer-motion";
import * as React from "react";
import TransitionBase, { MotionFlexProps } from "./TransitionBase";

interface SlideProps extends MotionFlexProps {
  speed?: number;
}

const Slide: React.FunctionComponent<React.PropsWithChildren<SlideProps>> = ({
  children,
  speed,
  ...rest
}) => {
  const animation: AnimationProps["variants"] = {
    hidden: {
      x: "150%",
      opacity: 1.0,
      transition: {
        duration: speed || 0.3,
      },
    },
    visible: {
      x: "0%",
      opacity: 1.0,
      transition: {
        duration: speed || 0.2,
      },
    },
    exit: {
      x: "150%",
      opacity: 1.0,
      transition: {
        duration: speed || 0.2,
      },
    },
  };

  return (
    <TransitionBase
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

export default Slide;
