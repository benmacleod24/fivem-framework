import { Flex, Text } from "@chakra-ui/react";
import * as React from "react";
import { fetcher } from "../../../lib/swr";

interface OptionCardProps {
  option: ContextMenuOption;
}

const OptionCard: React.FunctionComponent<OptionCardProps> = ({ option: o }) => {
  return (
    <Flex
      bg='gray.700'
      rounded='md'
      p='3'
      minW='32'
      w='72'
      my='1.5'
      cursor={"pointer"}
      transition='0.15s ease-in-out'
      borderStyle='solid'
      borderWidth='1px'
      borderColor='gray.600'
      flexDir={"column"}
      onClick={async () => await fetcher(`/context/menu/select`, { ...o })}
      _hover={{
        bg: "gray.600",
      }}
    >
      <Flex align={"center"}>
        {o.icon && (
          <i
            className={o.icon}
            style={{
              color: "#CBD5E0",
              fontSize: "1rem",
              marginRight: "2%",
            }}
          ></i>
        )}
        <Text fontWeight={"semibold"} color='gray.200'>
          {o.title}
        </Text>
      </Flex>
      {o.description && (
        <Text fontSize={"sm"} color='gray.200' opacity={0.7} maxW='100%' isTruncated>
          {o.description}
        </Text>
      )}
    </Flex>
  );
};

export default OptionCard;
