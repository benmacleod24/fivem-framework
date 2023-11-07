import { Box, Flex, HTMLChakraProps, useOutsideClick } from "@chakra-ui/react";
import { AnimatePresence, HTMLMotionProps, motion } from "framer-motion";
import * as React from "react";

export type Merge<P, T> = Omit<P, keyof T> & T;
type MotionBoxProps = Merge<HTMLChakraProps<"div">, HTMLMotionProps<"div">>;
export const MotionFlex: React.FC<MotionBoxProps> = motion(Flex);

interface PhoneModalProps {
  isOpen: boolean;
  onClose: () => void;
  h?: string;
  containerProps?: typeof MotionFlex;
}

const PhoneModal: React.FunctionComponent<
  React.PropsWithChildren<PhoneModalProps>
> = ({ onClose, isOpen, children, h = "fit-content" }) => {
  const modalRef: any = React.createRef();

  // useOutsideClick({
  //   ref: modalRef,
  //   handler: onClose,
  // });

  const animateModalContainer = {
    hidden: {
      bottom: "-400px",
      transition: {
        duration: 0.4,
      },
    },
    visible: {
      bottom: "0px",
      transition: {
        duration: 0.4,
      },
    },
    exit: {
      bottom: "-400px",
      transition: {
        duration: 0.4,
      },
    },
  };

  const animateModalBackdrop = {
    hidden: {
      opacity: 0,
      transition: {
        duration: 0.4,
      },
    },
    visible: {
      opacity: 1.0,
      transition: {
        duration: 0.4,
      },
    },
    exit: {
      opacity: 0,
      transition: {
        duration: 0.4,
      },
    },
  };

  return (
    <AnimatePresence initial={false} exitBeforeEnter>
      {isOpen && (
        <React.Fragment>
          <MotionFlex
            w='full'
            h='full'
            bg='rgba(0,0,0,0.4)'
            pos='absolute'
            top='0'
            left='0'
            borderRadius={"3rem"}
            backdropFilter='blur(0.5px)'
            variants={animateModalBackdrop}
            initial='hidden'
            exit='exit'
            animate='visible'
            onClick={onClose}
          ></MotionFlex>
          <MotionFlex
            pos='absolute'
            // bottom='0'
            // left='0'
            w='full'
            h={h}
            variants={animateModalContainer}
            initial='hidden'
            exit='exit'
            animate='visible'
            maxH='55%'
            bg='grey.800'
            borderTopRadius={"2.5rem"}
            overflow='hidden'
          >
            <Flex
              w='12'
              onClick={onClose}
              borderRadius={"full"}
              top='2'
              h='1'
              transition='0.2s ease-in-out'
              bg='white'
              pos='absolute'
              left='50%'
              cursor={"pointer"}
              _hover={{
                w: "16",
              }}
              transform={"translateX(-50%)"}
            />
            {children}
          </MotionFlex>
        </React.Fragment>
      )}
    </AnimatePresence>
  );
};

export default PhoneModal;
