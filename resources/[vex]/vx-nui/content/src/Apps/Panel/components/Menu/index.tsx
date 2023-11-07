import { Flex, IconButton, Tooltip } from "@chakra-ui/react";
import * as React from "react";
import { FaMagic, FaUniversity, FaUserShield } from "react-icons/fa";
import { HiOutlineMicrophone } from "react-icons/hi";
import { MdOutlineDashboardCustomize } from "react-icons/md";

interface MenuProps {
  page: string;
  setPage: (v: string) => void;
}

const Menu: React.FunctionComponent<MenuProps> = ({ page, setPage }) => {
  return (
    <Flex
      w='16'
      minW='16'
      maxW='16'
      h='full'
      bg='gray.600'
      flexDir={"column"}
      justifyContent='center'
      alignItems={"center"}
    >
      <Tooltip
        label='Dev Menu'
        placement='right'
        color='white'
        background='gray.800'
      >
        <IconButton
          onClick={() => setPage("dev")}
          my='1'
          colorScheme={page === "dev" ? "blue" : "gray"}
          aria-label='dev-menu'
          icon={<FaMagic />}
        />
      </Tooltip>
      <Tooltip
        label='Admin Menu'
        placement='right'
        color='white'
        background='gray.800'
      >
        <IconButton
          onClick={() => setPage("admin")}
          my='1'
          colorScheme={page === "admin" ? "blue" : "gray"}
          aria-label='admin-menu'
          icon={<FaUserShield />}
        />
      </Tooltip>
      <Tooltip
        label='Hud Menu'
        placement='right'
        color='white'
        background='gray.800'
      >
        <IconButton
          onClick={() => setPage("hud")}
          my='1'
          colorScheme={page === "hud" ? "blue" : "gray"}
          aria-label='hud-menu'
          icon={<MdOutlineDashboardCustomize />}
        />
      </Tooltip>
    </Flex>
  );
};

export default Menu;
