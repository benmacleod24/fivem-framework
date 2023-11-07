import { Flex, Text } from "@chakra-ui/react";
import * as React from "react";
import { usePhoneContext } from "../../../../../context/phone";
import { useRootContext } from "../../../../../context/root";
import { formatPhoneNumber } from "../../../../../lib";

interface MyCardProps {}

const MyCard: React.FunctionComponent<MyCardProps> = ({}) => {
  const { state: phoneState } = usePhoneContext();
  const { state: rootState } = useRootContext();

  return (
    <Flex w='full' alignItems={"center"} my='1.5' mx='3'>
      <Flex
        rounded={"full"}
        bg='grey.700'
        alignItems={"center"}
        justifyContent='center'
        fontSize={"lg"}
        fontWeight='medium'
        w='12'
        h='12'
        textTransform={"uppercase"}
      >
        {rootState.character.firstName[0]}
        {rootState.character.lastName[0]}
      </Flex>
      <Flex ml='3' flexDir={"column"} justifyContent='center' gap={1}>
        <Text lineHeight={"none"} fontWeight='medium' fontSize={"md"}>
          {rootState.character.firstName} {rootState.character.lastName}
        </Text>
        <Text lineHeight={"none"} fontSize='xs' color='whiteAlpha.500'>
          {formatPhoneNumber(phoneState.phoneNumber)}
        </Text>
      </Flex>
    </Flex>
  );
};

export default MyCard;
