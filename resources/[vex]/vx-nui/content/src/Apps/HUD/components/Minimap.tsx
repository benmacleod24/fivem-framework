import { Flex } from "@chakra-ui/layout";
import * as React from "react";
import { useRootContext } from "../../../context/root";

interface MiniMapProps {}

const MiniMap: React.FunctionComponent<MiniMapProps> = ({}) => {
  const { state } = useRootContext();

  if (state.isAppDev || state.application === "inventory") return null;

  return (
    <Flex
      pos='absolute'
      left='0.6%'
      bottom='6%'
      w='13.7%'
      h='20%'
      border='5px solid #D4D4D4'
      borderRadius='100%'
      zIndex={99}
      userSelect='none'
    />
  );
};

export default MiniMap;
