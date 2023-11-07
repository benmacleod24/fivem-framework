import * as React from "react";
import { Flex } from "@chakra-ui/react";

interface MenuListProps {}

const MenuList: React.FunctionComponent<React.PropsWithChildren<MenuListProps>> = ({
  children,
}) => {
  return (
    <Flex
      w='full'
      flexDir='column'
      bg='grey.800'
      borderRadius='md'
      overflow='hidden'
      h='fit-content'
    >
      {children}
    </Flex>
  );
};

export default MenuList;
