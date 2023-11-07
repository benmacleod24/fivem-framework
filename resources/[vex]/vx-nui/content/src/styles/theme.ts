// 1. import `extendTheme` function
import {
  extendTheme,
  ThemeConfig,
  Theme,
  ColorModeScript,
  Colors,
} from "@chakra-ui/react";

// 2. Add your color mode config
const config: ThemeConfig = {
  initialColorMode: "dark",
  useSystemColorMode: false,
};

const styles = {
  global: {
    body: {
      bg: "transparent",
    },
  },
};

const colors = {
  gray: {
    900: "#10151d", // +10
    800: "#1a202d", // +5
    700: "#232c3d", // 0
    600: "#2e3747", // -5
    500: "#394150", // -10
    400: "#444c5a", // -15
    300: "#4f5664", // -20
  },
  grey: {
    900: "#171717",
    800: "#262626",
    700: "#404040",
    600: "#525252",
  },
};

// 3. extend the theme
const theme = extendTheme({ config, styles, colors });

export default theme;
