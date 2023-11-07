import * as React from "react";
import { DndProvider } from "react-dnd";
import AnimateApp from "../../components/Transitions/AnimateApp";
import { TouchBackend } from "react-dnd-touch-backend";
import { useMessage } from "../../lib/hooks/useMessage";
import Container from "./components/container";
import { Flex } from "@chakra-ui/react";
// import { LeftInventory } from "../../lib/data/inventory";

interface InventoryProps {}

const Inventory: React.FunctionComponent<InventoryProps> = ({}) => {
  // Entry point for all inventory data
  const { data: LeftInventory } = useMessage<Inventory>("nui:inventory:left");
  const { data: RightInventory } = useMessage<Inventory>("nui:inventory:right");

  return (
    <AnimateApp
      appName='inventory'
      transitionProps={{
        w: "full",
        h: "full",
      }}
    >
      <DndProvider backend={TouchBackend} options={{ enableMouseEvents: true }}>
        <Flex w='full' h='full' justify={"center"} align='center'>
          <Container inventory={LeftInventory} />
          {/* <Container inventory={LeftInventory} /> */}
        </Flex>
      </DndProvider>
    </AnimateApp>
  );
};

export default Inventory;
