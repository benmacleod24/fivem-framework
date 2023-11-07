import { Flex, Heading, Icon } from "@chakra-ui/react";
import * as React from "react";
import { FaDumbbell } from "react-icons/fa";

interface HeaderProps {}

const Header: React.FunctionComponent<HeaderProps> = ({}) => {
  return (
    <Flex align={"center"} mt='1'>
      <Icon as={FaDumbbell} mt='0.5' mr='1.5' fontSize='2xl' color='purple.300' />
      <Heading size='md' lineHeight={"none"}>
        Workforce
      </Heading>
    </Flex>
  );
};

export default Header;
