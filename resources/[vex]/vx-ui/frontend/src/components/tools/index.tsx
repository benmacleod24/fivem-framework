import {
	Button,
	Flex,
	Menu,
	MenuButton,
	MenuItem,
	MenuList,
} from '@chakra-ui/react';
import React from 'react';
import { useRootState } from '../../lib/state/root';

const apps: string[] = ['', 'panel'];

interface ToolsProps {}

const Tools: React.FC<ToolsProps> = ({}) => {
	const { dispatch, state } = useRootState();

	return (
		<Flex pos={'absolute'} top='2' left='2'>
			<Menu closeOnSelect={false}>
				<MenuButton
					as={Button}
					variant='solid'
					bg='gray.700'
					_hover={{ bg: 'gray.700' }}
					_active={{ bg: 'gray.700' }}
					color='white'
					px='5'
				>
					Browser Tools
				</MenuButton>
				<MenuList border={'none'} boxShadow='none'>
					{apps.map((s) => (
						<MenuItem
							transition={'0.2s ease-out'}
							onClick={() =>
								dispatch({
									type: 'SET_APPLICATION',
									payload: s,
								})
							}
							textTransform='capitalize'
							color={
								s === state.application
									? 'blue.200'
									: 'gray.300'
							}
						>
							{!s ? 'Clear' : s.split('_').join(' ')}
						</MenuItem>
					))}
				</MenuList>
			</Menu>
		</Flex>
	);
};
export default Tools;
