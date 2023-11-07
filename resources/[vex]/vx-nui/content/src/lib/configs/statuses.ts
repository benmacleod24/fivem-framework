import { Search2Icon } from "@chakra-ui/icons";
import { FaClock, FaHeartbeat, FaShieldAlt, FaVest } from "react-icons/fa";
import { GiTacos } from "react-icons/gi";
import { MdLocalDrink } from "react-icons/md";

export interface StatusCfg {
  color: string;
  icon: any;
}

export const statuses: { [x: string]: StatusCfg } = {
  health: {
    color: "#498949 ",
    icon: FaHeartbeat,
  },
  armor: {
    color: "#1063b9",
    icon: FaShieldAlt,
  },
  hunger: {
    color: "#e67013",
    icon: GiTacos,
  },
  thirst: {
    color: "#1797d8",
    icon: MdLocalDrink,
  },
  stopwatch: {
    color: "#475569 ",
    icon: FaClock,
  },
};
