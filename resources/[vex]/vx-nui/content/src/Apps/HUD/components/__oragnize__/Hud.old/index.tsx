import { Box, Flex } from "@chakra-ui/layout";
import * as React from "react";
import HudCircle from "./HudCircle";
import {
  FaHeart,
  FaShieldAlt,
  FaDrumstickBite,
  FaTint,
  FaBrain,
} from "react-icons/fa";
import { RiLungsFill } from "react-icons/ri";
import { useMessage } from "../../../../../lib/hooks/useMessage";
import Stopwatch from "./Stopwatch";

interface HudProps {}

const Hud: React.FunctionComponent<HudProps> = ({}) => {
  const [health, setHealth] = React.useState(95);
  const [armour, setArmour] = React.useState(100);
  const [food, setFood] = React.useState(100);
  const [drink, setDrink] = React.useState(100);
  const [stress, setStress] = React.useState(0);
  const [oxygen, setOxygen] = React.useState(0);

  return (
    <Flex
      w='50%'
      alignItems='center'
      justifyContent='flex-start'
      pos='absolute'
      left='1'
      bottom='0'
    >
      <HudCircle hideValue={false} color='#4CAF50' value={health} icon={FaHeart} />
      <HudCircle
        hideValue={false}
        color='#2563EB'
        value={armour}
        icon={FaShieldAlt}
      />
      <HudCircle
        hideValue={false}
        color='#F97316'
        value={food}
        icon={FaDrumstickBite}
      />
      <HudCircle hideValue={false} color='#0284C7' value={drink} icon={FaTint} />
      <HudCircle hideValue={false} color='#EF4444' value={stress} icon={FaBrain} />
      <HudCircle
        hideValue={false}
        color='#64748B'
        value={oxygen}
        icon={RiLungsFill}
      />
      <Stopwatch />
    </Flex>
  );
};

export default Hud;
