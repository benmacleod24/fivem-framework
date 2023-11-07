import * as React from "react";
import {
  BackgroundProps,
  ComponentWithAs,
  Flex,
  IconButton,
  IconProps,
  Text,
  TypographyProps,
} from "@chakra-ui/react";
import Icon from "../../Icons/Icon";
import { IconType } from "react-icons";

interface MenuItemProps {
  icon?: IconType | ComponentWithAs<"svg", IconProps>;
  iconColor?: BackgroundProps["bg"];
  iconSize?: TypographyProps["fontSize"];
  description?: string;
  rightButton?: any;
}

const MenuItem: React.FunctionComponent<React.PropsWithChildren<MenuItemProps>> = ({
  children,
  icon,
  iconSize,
  iconColor,
  description,
  rightButton: Button,
}) => {
  return (
    <Flex
      w='full'
      alignItems={"center"}
      p='2.5'
      cursor={"pointer"}
      transition='0.2s ease-in-out'
      _hover={{
        bg: "whiteAlpha.200",
      }}
    >
      {icon && (
        <Flex
          w='8'
          h='8'
          borderRadius={"md"}
          justifyContent='center'
          alignItems={"center"}
          overflow='hidden'
          fontSize={"lg"}
          mr='3'
        >
          <Icon icon={icon} bg={iconColor || "grey"} fontSize={iconSize || "2xl"} />
        </Flex>
      )}
      <Flex flexGrow={1} flexDir='column' lineHeight={"none"}>
        <Text
          fontWeight={description ? "medium" : "normal"}
          fontSize={description ? "sm" : "md"}
          textTransform='capitalize'
        >
          {children}
        </Text>
        {description && (
          <Text fontSize={"xs"} mt='1' color='whiteAlpha.500'>
            {description}
          </Text>
        )}
      </Flex>
      {Button && Button}
    </Flex>
  );
};

export default MenuItem;
