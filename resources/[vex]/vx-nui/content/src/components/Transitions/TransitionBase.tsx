import { Flex, HTMLChakraProps } from "@chakra-ui/react";
import { HTMLMotionProps, motion } from "framer-motion";
import * as React from "react";

export type Merge<P, T> = Omit<P, keyof T> & T;
export type MotionFlexProps = Merge<HTMLChakraProps<"div">, HTMLMotionProps<"div">>;
export const MotionFlex: React.FC<MotionFlexProps> = motion(Flex);

interface TransitionBaseProps extends MotionFlexProps {}

const TransitionBase: React.FunctionComponent<
  React.PropsWithChildren<TransitionBaseProps>
> = ({ children, ...rest }) => {
  return <MotionFlex {...rest}>{children}</MotionFlex>;
};

export default TransitionBase;
