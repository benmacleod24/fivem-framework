import * as React from 'react';
import { useApp } from '../../lib/hooks';
import { Flex } from '@chakra-ui/react';
import AnimateApp from '../../components/transitions/animate-app';
import { scaleOffsetConfig } from '../../components/transitions';
import Scale from '../../components/transitions/scale';
import PanelMenu from './components/menu';

interface PanelProps {}

const Panel: React.FunctionComponent<PanelProps> = ({}) => {
	const [page, setPage] = React.useState<string>('developer');
	const { isOpen } = useApp('panel');

	return (
		<AnimateApp
			isOpen={isOpen}
			Transition={Scale}
			transitionProps={{ ...scaleOffsetConfig }}
		>
			<Flex
				w='4xl'
				h='xl'
				bg='gray.700'
				transform={'translate(-50%, -50%)'}
				rounded='md'
				overflow={'hidden'}
				boxShadow={'md'}
				{...scaleOffsetConfig}
			>
				<PanelMenu page={page} setPage={setPage} />
			</Flex>
		</AnimateApp>
	);
};

export default Panel;
