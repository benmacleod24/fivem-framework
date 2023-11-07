import { Flex } from '@chakra-ui/react';
import * as React from 'react';
import MenuButton from './button';
import { FaHatWizard } from 'react-icons/fa';
import { GoShield } from 'react-icons/go';
import { MdOutlineDashboardCustomize } from 'react-icons/md';

const options: Panel.MenuOption[] = [
	{
		label: 'Developer',
		optionId: 'developer',
		icon: <FaHatWizard />,
	},
	{
		label: 'Admins',
		optionId: 'admin',
		icon: <GoShield />,
	},
	{
		label: 'UI Settings',
		optionId: 'hud-settings',
		icon: <MdOutlineDashboardCustomize />,
	},
];

interface PanelMenuProps {
	page: string;
	setPage: (page: string) => void;
}

const PanelMenu: React.FunctionComponent<PanelMenuProps> = ({
	page,
	setPage,
}) => {
	return (
		<Flex
			minW='16'
			maxW='16'
			h='full'
			bg='gray.600'
			flexDir={'column'}
			pos='relative'
			justify={'center'}
			align='center'
		>
			{options.map((o) => (
				<MenuButton
					options={o}
					key={o.optionId + Math.random()}
					setPage={setPage}
					page={page}
				/>
			))}
		</Flex>
	);
};

export default PanelMenu;
