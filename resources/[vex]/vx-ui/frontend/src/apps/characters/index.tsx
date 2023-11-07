import {
	Flex,
	IconButton,
	Menu,
	MenuButton,
	MenuItem,
	MenuList,
	Text,
} from '@chakra-ui/react';
import * as React from 'react';
import { scaleOffsetConfig } from '../../components/transitions';
import AnimateApp from '../../components/transitions/animate-app';
import { useRootState } from '../../lib/state/root';
import { BsThreeDotsVertical } from 'react-icons/bs';
import { MdDelete } from 'react-icons/md';
import { DeleteIcon, StarIcon } from '@chakra-ui/icons';

interface CharactersProps {}

const Characters: React.FunctionComponent<CharactersProps> = ({}) => {
	const { state } = useRootState();

	return (
		<AnimateApp isOpen={true}>
			<Flex transform={'translate(-50%, -50%)'} {...scaleOffsetConfig}>
				{/* Character Card */}
				<Flex
					userSelect={'none'}
					cursor='pointer'
					px='4'
					py='2.5'
					bg='gray.700'
					rounded={'md'}
					w='80'
					pos='relative'
					flexDir={'column'}
				>
					<Text fontWeight={'medium'} fontSize='lg'>
						Harvey Specter
					</Text>
					<Text fontSize={'sm'} color='gray.200' opacity={0.5}>
						Stop being such white trash and get a job!
					</Text>
					<Flex></Flex>
					<Menu placement='bottom-start'>
						<MenuButton
							as={IconButton}
							aria-label='Options'
							icon={<BsThreeDotsVertical />}
							variant='ghost'
							rounded={'full'}
							size='sm'
							fontSize={'lg'}
							pos='absolute'
							right='2'
							top='2'
						></MenuButton>
						<MenuList>
							<MenuItem icon={<StarIcon color='yellow.400' />}>
								Select
							</MenuItem>
							<MenuItem icon={<DeleteIcon color='red.400' />}>
								Delete
							</MenuItem>
						</MenuList>
					</Menu>
				</Flex>
			</Flex>
		</AnimateApp>
	);
};

export default Characters;
