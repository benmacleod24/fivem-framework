import { extendTheme } from '@chakra-ui/react';

// Theme Imports
import { config } from './config';
import { colors } from './config/colors';
import { styles } from './config/global-styles';

const theme = extendTheme({ config, colors, styles });

// Expor theme as default
export default theme;
