import { ColorProps } from "@chakra-ui/react";

interface DevToolsLink {
  name: string;
  link: string;
  color?: ColorProps["color"];
}

export const links: DevToolsLink[] = [
  {
    name: "Clear",
    link: "",
    color: "purple.400",
  },
  {
    name: "Panel",
    link: "panel",
  },
  {
    name: "Phone",
    link: "phone",
  },
  {
    name: "Context Menu",
    link: "context",
  },
  {
    name: "Banking",
    link: "banking",
  },
  {
    name: "Inventory",
    link: "inventory",
  },
  {
    name: "Clothing",
    link: "clothing",
  },
];
