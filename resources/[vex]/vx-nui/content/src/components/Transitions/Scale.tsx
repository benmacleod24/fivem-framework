import { LayoutProps } from "@chakra-ui/react";
import { AnimationProps } from "framer-motion";
import * as React from "react";
import TransitionBase, { MotionFlexProps } from "./TransitionBase";

export interface ScaleProps extends MotionFlexProps {
  speed?: number;
  w?: LayoutProps["w"];
  h?: LayoutProps["h"];
}

const Scale: React.FunctionComponent<React.PropsWithChildren<ScaleProps>> = ({
  children,
  speed,
  w,
  h,
  ...rest
}) => {
  const animation: AnimationProps["variants"] = {
    hidden: {
      scale: "0%",
      opacity: 1.0,
      transition: {
        duration: speed || 0.3,
      },
    },
    visible: {
      scale: "100%",
      opacity: 1.0,
      transition: {
        duration: speed || 0.2,
      },
    },
    exit: {
      scale: "0%",
      opacity: 1.0,
      transition: {
        duration: speed || 0.2,
      },
    },
  };

  return (
    <TransitionBase
      w={"full"}
      h={"full"}
      pos={(rest.pos && rest.pos) || "absolute"}
      justifyContent='center'
      alignItems={"center"}
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

export default Scale;
