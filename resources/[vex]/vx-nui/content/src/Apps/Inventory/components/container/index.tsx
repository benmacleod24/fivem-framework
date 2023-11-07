import { Flex, Grid, Text } from "@chakra-ui/react";
import * as React from "react";
import Slot from "../Slot";

interface ContainerProps {
  inventory: Inventory | undefined;
}

const Container: React.FunctionComponent<ContainerProps> = ({ inventory: i }) => {
  // Just tell the user there is nothing to display
  if (!i) {
    return <Text>Waiting for Config</Text>;
  }

  // Combined weight of each stack in the inventory
  const calculateInventoryWeight = Object.values(i.stacks).reduce((rtn, nxt) => {
    return (rtn = rtn + nxt.weight);
  }, 0);

  return (
    <Flex w='2xl' maxH='xl' h='full' m='1'>
      <Grid
        templateColumns={"repeat(5, 1fr)"}
        w='full'
        overflow={"auto"}
        gap={1}
        rounded='md'
      >
        {[...new Array(i.data.slots)].map((_, index) => (
          <Slot
            key={index}
            stack={i.stacks[index + 1]}
            index={index + 1}
            inventoryId={i.data.id}
            inventoryType={i.data.type}
          />
        ))}
      </Grid>
    </Flex>
  );
};

export default Container;
