import { Button, Flex, Heading, IconButton } from "@chakra-ui/react";
import { AnimatePresence } from "framer-motion";
import * as React from "react";
import { BsArrowLeft } from "react-icons/bs";
import { FiChevronLeft } from "react-icons/fi";
import TransitionBase from "../../../../../components/Transitions/TransitionBase";
import AppWrapper from "..";

interface SidePageProps {
  isActive: boolean;
  onClose: () => void;
  title: string;
  direction?: "left" | "up";
}

const SidePage: React.FunctionComponent<React.PropsWithChildren<SidePageProps>> = ({
  children,
  isActive,
  onClose,
  title,
  direction = "left",
}) => {
  const animateSideSlideLeft = {
    hidden: {
      right: "-300px",
      transition: {
        duration: 0.4,
      },
    },
    visible: {
      right: 0,
      transition: {
        duration: 0.4,
      },
    },
    exit: {
      right: "-300px",
      transition: {
        duration: 0.4,
      },
    },
  };

  const animateSideSlideUp = {
    hidden: {
      bottom: "-650px",
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
      bottom: "-650px",
      transition: {
        duration: 0.4,
      },
    },
  };

  return (
    <AnimatePresence initial={false} exitBeforeEnter>
      {isActive && (
        <TransitionBase
          w='full'
          h='full'
          pos='absolute'
          // right='0'
          // top='0'
          bg='grey.900'
          variants={
            (direction === "left" && animateSideSlideLeft) || animateSideSlideUp
          }
          initial='hidden'
          exit='exit'
          animate='visible'
          flexDir={"column"}
        >
          <Flex w='3' h='full' onClick={onClose} pos='absolute' zIndex={0} />
          <Flex
            mt='3'
            justifyContent={"center"}
            alignItems='center'
            h='fit-content'
            w='full'
            pos='relative'
          >
            <IconButton
              aria-label='go-back'
              icon={<FiChevronLeft />}
              onClick={onClose}
              colorScheme='blue'
              variant={"ghost"}
              size='sm'
              borderRadius='full'
              pos='absolute'
              left={(direction === "left" && "2") || "unset"}
              right={(direction === "up" && "2") || "unset"}
              top='50%'
              transform={`translateY(-50%) rotate(${
                (direction === "left" && "0") || -90
              }deg)`}
            />
            <Heading textTransform={"capitalize"} size='sm'>
              {title}
            </Heading>
          </Flex>
          <Flex w='full' flexGrow={1} overflow='auto' px='3'>
            {children}
          </Flex>
        </TransitionBase>
      )}
    </AnimatePresence>
  );
};

export default SidePage;
