import {
  Button,
  Flex,
  Menu,
  MenuButton,
  MenuItem,
  MenuList,
} from "@chakra-ui/react";
import * as React from "react";
import { useRootContext } from "../../context/root";
import { links } from "./config";

interface ToolsProps {}

const Tools: React.FunctionComponent<ToolsProps> = ({}) => {
  const { dispatch } = useRootContext();

  return (
    <Flex pos='absolute' top='0' left='0'>
      <Menu>
        <MenuButton
          as={Button}
          variant='solid'
          bg='gray.700'
          _hover={{ bg: "gray.700" }}
          _active={{ bg: "gray.600" }}
          color='white'
          borderRadius={"sm"}
          m='2'
        >
          Tools
        </MenuButton>
        <MenuList
          boxShadow={"none"}
          _hover={{ boxShadow: "none" }}
          borderRadius={"md"}
        >
          {" "}
          {links.map((l, i) => (
            <MenuItem
              color={l.color}
              key={i}
              onClick={() =>
                dispatch({
                  type: "SET_APPLICATION",
                  payload: {
                    name: l.link,
                  },
                })
              }
            >
              {l.name}
            </MenuItem>
          ))}
        </MenuList>
      </Menu>
    </Flex>
  );
};

export default Tools;
