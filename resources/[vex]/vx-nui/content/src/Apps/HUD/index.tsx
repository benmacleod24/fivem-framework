import { Flex } from "@chakra-ui/react";
import isEmpty from "is-empty";
import * as React from "react";
import { useKvpSettings } from "../../lib/hooks/useKvpSettings";
import Cash from "./components/Cash";
import MiniMap from "./components/Minimap";
import Status from "./components/Status";

/**
 * HUD Component
 * Houses any dumb or smart component the involves the hud
 * i.e. cash, circles, minimap
 */

interface HUDProps {}

const HUD: React.FunctionComponent<HUDProps> = ({}) => {
  const { settings, updateSettings } = useKvpSettings("hud-status");

  React.useEffect(() => {
    if (isEmpty(settings)) {
      updateSettings({
        armor: 45,
        hunger: 80,
        thirst: 80,
        health: 100,
      });
    }
  }, []);

  return (
    <Flex pos='relative' pointerEvents={"none"} w='full' h='full'>
      <Cash />
      <MiniMap />
      <Status />
    </Flex>
  );
};

export default HUD;
