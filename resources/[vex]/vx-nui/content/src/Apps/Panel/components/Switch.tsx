import { Flex, Switch as SwitchCH, Text } from "@chakra-ui/react";
import * as React from "react";
import useSWR from "swr";
import post from "../../../lib/post";
import { fetcher, useSWRWrapper } from "../../../lib/swr";

interface SwitchProps {
  name: string;
  endpoint: string;
}

const Switch: React.FunctionComponent<SwitchProps> = ({ endpoint, name }) => {
  const { data: value, mutate } = useSWR<boolean>(`/dev/toggles/${endpoint}/get`);

  const handleOnClick = async () => {
    await post(`/dev/toggles/${endpoint}/toggle`);
    mutate();
  };

  return (
    <Flex
      p='2'
      alignItems={"center"}
      justifyContent='space-between'
      bg='gray.600'
      gap={3}
      borderRadius='md'
      onClick={handleOnClick}
    >
      <Text>{name}</Text>
      <SwitchCH isChecked={value || false} onChange={handleOnClick} />
    </Flex>
  );
};

export default Switch;
