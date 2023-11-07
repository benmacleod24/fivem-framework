import { Flex } from "@chakra-ui/react";
import * as React from "react";
import AnimateApp from "../../components/Transitions/AnimateApp";
import Scale from "../../components/Transitions/Scale";
import Menu from "./components/Menu";
import Developer from "./Pages/Developer";
import HudSettings from "./Pages/Hud";

interface PanelProps {}

const Panel: React.FunctionComponent<PanelProps> = ({}) => {
  const [page, setPage] = React.useState<string>("dev");

  return (
    <AnimateApp appName='panel' Transition={Scale} transitionProps={{ speed: 0.3 }}>
      <Flex
        w='4xl'
        h='xl'
        bg='gray.700'
        pos='absolute'
        rounded='md'
        overflow='hidden'
      >
        <Menu page={page} setPage={setPage} />
        {page === "dev" && <Developer />}
        {page === "hud" && <HudSettings />}
      </Flex>
    </AnimateApp>
  );
};

export default Panel;
