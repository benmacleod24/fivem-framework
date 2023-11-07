import { Flex, Text } from "@chakra-ui/react";
import * as React from "react";

interface ItemTooltipProps {
  config: StackConfig;
  item: InventoryItem;
  count: number;
}

const ItemTooltip: React.FunctionComponent<ItemTooltipProps> = ({
  config,
  item,
  count,
}) => {
  return (
    <Flex color='white' minW='' p='4' flexDir={"column"}>
      <Flex flexDir={"column"} pb='1.5'>
        <Text textTransform={"capitalize"} fontSize='lg'>
          {config.name}
        </Text>
        <Text fontWeight={"normal"} lineHeight='none'>
          {config.description}
        </Text>
      </Flex>
      <Flex gap={3} borderTop='1px solid' borderTopColor={"whiteAlpha.200"} pt='1.5'>
        <Text>
          Weight Per:{" "}
          <Text as='span' fontWeight={"normal"} color='gray.200' opacity={0.9}>
            {config.weight} lb
          </Text>
        </Text>
        <Text>
          Count:{" "}
          <Text as='span' fontWeight={"normal"} color='gray.200' opacity={0.9}>
            {count}
          </Text>
        </Text>
        <Text>
          Quality:{" "}
          <Text as='span' fontWeight={"normal"} color='gray.200' opacity={0.9}>
            {item.durability}
          </Text>
        </Text>
      </Flex>
    </Flex>
  );
};

export default ItemTooltip;
