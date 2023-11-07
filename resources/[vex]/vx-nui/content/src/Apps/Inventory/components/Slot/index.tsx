import { Flex, Text } from "@chakra-ui/react";
import * as React from "react";
import { useDrop } from "react-dnd";
import post from "../../../../lib/post";
import Item from "../Item";

interface SlotProps {
  stack: InventoryStack;
  index: number;
  inventoryId: string;
  inventoryType: string;
}

const Slot: React.FunctionComponent<SlotProps> = ({
  stack,
  index,
  inventoryId,
  inventoryType,
}) => {
  const [_, ref] = useDrop({
    accept: ["ITEM"],
    drop: async (item: any, observer) => {
      const fromInventory = item.inventoryId;
      const fromSlot = item.slotId;

      const toInventory = inventoryId;
      const toSlot = index;

      console.log(
        `Moving to ${toInventory}:${toSlot} from ${fromInventory}:${fromSlot}`
      );

      await post("/inventory/move-item", {
        fromInventory,
        fromSlot,
        toInventory,
        toSlot,
        inventoryType,
      });
    },
  });

  return (
    <Flex
      ref={ref}
      w='full'
      h='36'
      rounded={"md"}
      overflow='hidden'
      bg='#232c3d4a'
      // bg='rgba(28, 27, 27, 0.2)'
      pos='relative'
      border='1px solid'
      borderColor={"whiteAlpha.100"}
    >
      {stack && (
        <Item
          config={stack.config}
          inventoryId={inventoryId}
          item={stack.items[0]}
          index={index}
          count={stack.amount}
        />
      )}
      {index <= 5 && (
        <Text
          userSelect={"none"}
          pos='absolute'
          left='50%'
          top='50%'
          transform={"translate(-50%, -50%)"}
          color='whiteAlpha.100'
          fontWeight={"bold"}
          fontSize='6xl'
        >
          {index}
        </Text>
      )}
    </Flex>
  );
};

export default Slot;
