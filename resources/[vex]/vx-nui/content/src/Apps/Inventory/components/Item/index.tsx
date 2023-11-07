import { Flex, Image, Text, Tooltip } from "@chakra-ui/react";
import * as React from "react";
import { useDrag } from "react-dnd";
import ItemTooltip from "./Tooltip";

interface ItemProps {
  config: StackConfig;
  item: InventoryItem;
  count: number;
  inventoryId: string;
  index: number;
}

const Item: React.FunctionComponent<ItemProps> = ({
  config,
  item,
  count,
  inventoryId,
  index,
}) => {
  const [{ points, dragging }, drag] = useDrag({
    type: "ITEM",
    item: {
      inventoryId,
      slotId: index,
    },
    collect: (moniter) => ({
      points: moniter.getClientOffset(),
      dragging: moniter.isDragging(),
    }),
  });

  return (
    <Tooltip
      bg='gray.600'
      rounded={"md"}
      label={<ItemTooltip config={config} item={item} count={count} />}
      p='0'
      placement='auto'
      openDelay={750}
    >
      <Flex
        w='full'
        h='full'
        pos='relative'
        zIndex={99}
        userSelect='none'
        ref={drag}
      >
        <Flex
          w='1.5'
          bg='blackAlpha.300'
          minW='1.5'
          maxW='1.5'
          h='full'
          pos='relative'
        >
          <Flex
            w='full'
            h={`${item.durability}%`}
            bg='#4299e1'
            pos='absolute'
            bottom={"0"}
            roundedTop='full'
          />
        </Flex>
        <Flex
          h='full'
          flexGrow={1}
          justify={"center"}
          align='center'
          pos='relative'
          flexDir={"column"}
        >
          <Flex flexGrow={1} justify='center' align={"center"}>
            <Image
              pointerEvents={"none"}
              src='https://i.imgur.com/nKFYPfZ.png'
              h='24'
              w='24'
            />
          </Flex>
          <Flex bg='blackAlpha.50' w='full' justify={"center"} py='1'>
            <Text
              fontSize={"sm"}
              lineHeight='none'
              fontWeight='semibold'
              noOfLines={1}
              maxW='85%'
              w='fit-content'
              textTransform={"capitalize"}
            >
              {config.name}
            </Text>
          </Flex>
        </Flex>
      </Flex>
    </Tooltip>
  );
};

export default Item;
