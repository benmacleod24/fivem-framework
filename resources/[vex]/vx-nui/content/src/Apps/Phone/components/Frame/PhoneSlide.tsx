import { Box, HTMLChakraProps } from "@chakra-ui/react";
import { AnimatePresence, HTMLMotionProps, motion } from "framer-motion";
import * as React from "react";
import { useRootContext } from "../../../../context/root";

export type Merge<P, T> = Omit<P, keyof T> & T;
type MotionBoxProps = Merge<HTMLChakraProps<"div">, HTMLMotionProps<"div">>;
export const MotionBox: React.FC<MotionBoxProps> = motion(Box);

interface PhoneSlideProps {}

const PhoneSlide: React.FunctionComponent<
  React.PropsWithChildren<PhoneSlideProps>
> = ({ children }) => {
  const { state } = useRootContext();

  const animOpen = {
    hidden: {
      bottom: "-700px",
      transition: {
        duration: 0.7,
      },
    },
    visible: {
      bottom: "15px",
      transition: {
        duration: 0.7,
      },
    },
    exit: {
      bottom: "-700px",
      transition: {
        duration: 0.7,
      },
    },
  };

  const animNotify = {
    hidden: {
      bottom: "-700px",
      transition: {
        duration: 0.7,
      },
    },
    visible: {
      bottom: "-470px",
      transition: {
        duration: 0.7,
      },
    },
    exit: {
      bottom: "-700px",
      transition: {
        duration: 0.7,
      },
    },
  };

  return (
    <AnimatePresence>
      {state.application === "phone" && (
        <MotionBox
          w='330px'
          h='634px'
          borderRadius='2rem'
          pos='absolute'
          right='15px'
          overflow='hidden'
          variants={animOpen}
          initial='hidden'
          exit='exit'
          animate='visible'
        >
          {children}
        </MotionBox>
      )}
    </AnimatePresence>
  );
};

export default PhoneSlide;
