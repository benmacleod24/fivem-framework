import {
  BackgroundProps,
  ComponentWithAs,
  Flex,
  Icon as IconWrapper,
  TypographyProps,
  IconProps as ICProps,
} from "@chakra-ui/react";
import * as React from "react";
import { IconType } from "react-icons/lib";

interface IconProps {
  icon: IconType | ComponentWithAs<"svg", ICProps>;
  bg: BackgroundProps["bg"];
  fontSize?: TypographyProps["fontSize"];
  hasShadow?: boolean;
}

const Icon: React.FunctionComponent<IconProps> = ({
  icon,
  bg,
  fontSize,
  hasShadow,
}) => {
  return (
    <Flex
      w='full'
      h='full'
      justifyContent={"center"}
      alignItems='center'
      bg={bg}
      color='white'
      cursor={"pointer"}
    >
      <IconWrapper
        as={icon}
        color='white'
        textShadow='1px 10px 1px black'
        fontSize={fontSize || "3xl"}
        filter={hasShadow ? "drop-shadow( 0px 2.5px 0px rgba(0, 0, 0, 0.2))" : ""}
      />
    </Flex>
  );
};

export default Icon;
