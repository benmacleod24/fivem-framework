import * as ReactDOM from 'react-dom/client';

import { ChakraProvider } from '@chakra-ui/react';
import themeConfig from './styles/theme';
import './styles/css/index.css';

import App from './app';
import { RootProvider } from './lib/state/root';

const rootElement = document.getElementById('root') as HTMLElement;
ReactDOM.createRoot(rootElement).render(
	<RootProvider>
		<ChakraProvider resetCSS theme={themeConfig}>
			<App />
		</ChakraProvider>
	</RootProvider>
);
