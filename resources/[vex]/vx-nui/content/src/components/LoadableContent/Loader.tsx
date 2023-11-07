import React, { ReactElement } from "react";
import { Spinner as ChakraSpinner } from "@chakra-ui/react";
import { Flex as ChakraFlex } from "@chakra-ui/react";
import { theme } from "@chakra-ui/react";
export const spinnerSizes = {
  xm: "xs",
  sm: "sm",
  md: "md",
  lg: "lg",
  xl: "xl",
};

type SpinnerSizes = keyof typeof spinnerSizes;

const Loader = ({
  size = "lg",
  height = "25vh",
}: {
  size?: SpinnerSizes;
  height?: string | number;
}): ReactElement<typeof ChakraSpinner> => (
  <ChakraFlex justify='center' align='center'>
    <ChakraSpinner thickness='4px' size={size} color={theme.colors.orange[400]} />
  </ChakraFlex>
);

export default Loader;
