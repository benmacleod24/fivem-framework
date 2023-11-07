import * as React from "react";

// Icons
import Icon from "../components/Icons/Icon";
import { FaDumbbell } from "react-icons/fa";
import { RiContactsBook2Fill } from "react-icons/ri";
import { SettingsIcon } from "@chakra-ui/icons";

export interface PhoneApp {
  id: number;
  name: string;
  isDefault: boolean;
  isEnabled?: boolean;
  icon: {
    render: () => any;
  };
}

const Apps: { [id: number]: PhoneApp } = {
  0: {
    id: 0,
    name: "home_screen",
    isDefault: true,
    isEnabled: true,
    icon: {
      render: () => null,
    },
  },
  3: {
    id: 3,
    name: "contacts",
    isDefault: true,
    isEnabled: true,
    icon: {
      render: () => <Icon icon={RiContactsBook2Fill} bg='#0394fc' />,
    },
  },
  11: {
    id: 11,
    name: "settings",
    isDefault: true,
    isEnabled: true,
    icon: {
      render: () => <Icon icon={SettingsIcon} bg='#27272a ' />,
    },
  },
  12: {
    id: 12,
    name: "workforce",
    isDefault: true,
    isEnabled: true,
    icon: {
      render: () => <Icon icon={FaDumbbell} bg='coral' hasShadow />,
    },
  },
};

export default Apps;
