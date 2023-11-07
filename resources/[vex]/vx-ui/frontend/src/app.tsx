import React from 'react';

import { Flex } from '@chakra-ui/react';
import { Tools } from './components';
import { isEnvBrowser } from './lib/helpers';

// App Imports
import Panel from './apps/panel';
import Characters from './apps/characters';

const App: React.FC = () => {
	return (
		<Flex w='100vw' h='100vh' bg='#9c9c9c' overflow='hidden' p='10'>
			<Panel />
			<Characters />
			{isEnvBrowser() && <Tools />}
		</Flex>
	);
};

export default App;
