import { Flex, IconButton, Tooltip } from '@chakra-ui/react';
import * as React from 'react';

interface MenuButtonProps {
	options: Panel.MenuOption;
	page: string;
	setPage: (page: string) => void;
}

const MenuButton: React.FunctionComponent<MenuButtonProps> = ({
	options,
	page,
	setPage,
}) => {
	return (
		<Tooltip
			label={options.label}
			placement='right'
			color='white'
			background='gray.800'
		>
			<Flex>
				<IconButton
					aria-label='set-menu-option'
					icon={options.icon}
					fontSize='2xl'
					my='1'
					variant={page === options.optionId ? 'solid' : 'solid'}
					colorScheme={page === options.optionId ? 'blue' : 'gray'}
					onClick={() => setPage(options.optionId)}
				/>
			</Flex>
		</Tooltip>
	);
};

export default MenuButton;
