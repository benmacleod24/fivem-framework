import { Flex } from "@chakra-ui/react";
import * as React from "react";
import App from "..";
import { usePhoneContext } from "../../../../../context/phone";
import Apps from "../../../config/apps";
import Spinner from "../Spinner";

interface LauncherScreenProps {
  appId?: number;
}

const LauncherScreen: React.FunctionComponent<LauncherScreenProps> = ({ appId }) => {
  const { state } = usePhoneContext();

  return (
    <Flex
      w='full'
      h='full'
      bg='grey.900'
      justify={"center"}
      align='center'
      flexDir={"column"}
      fontSize='sm'
    >
      <Flex w='12' overflow={"hidden"} rounded='md' h='12' mb='3'>
        {Apps[state.application].icon.render()}
      </Flex>
      <Spinner />
    </Flex>
  );
};

export default LauncherScreen;
