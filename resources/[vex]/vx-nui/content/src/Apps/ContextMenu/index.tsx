import { Flex } from "@chakra-ui/react";
import * as React from "react";
import AnimateApp from "../../components/Transitions/AnimateApp";
// import { options } from "../../lib/data/context";
import { useMessage } from "../../lib/hooks/useMessage";
import OptionCard from "./components/OptionCard";

interface ContextMenuProps {}

const ContextMenu: React.FunctionComponent<ContextMenuProps> = ({}) => {
  const { data: options } = useMessage<ContextMenuOption[]>(`nui:context:set_menu`);

  if (!options) return null;

  return (
    <AnimateApp
      appName='context'
      transitionProps={{
        w: "fit-content",
        h: "fit-content",
        pos: "absolute",
        left: "60%",
        top: "25%",
        userSelect: "none",
        speed: 0.2,
      }}
    >
      <Flex flexDir={"column"}>
        {options.map((o) => (
          <OptionCard key={o.id} option={o} />
        ))}
      </Flex>
    </AnimateApp>
  );
};

export default ContextMenu;
