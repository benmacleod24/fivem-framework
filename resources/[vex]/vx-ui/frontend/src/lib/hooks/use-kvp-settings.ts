import { isEmpty } from '@chakra-ui/utils';
import { useEffect, useState } from 'react';
import { useRootState } from '../state/root';

// Local Storage hook that helps store NUI settings.
// Stored agains the characterId so that the settings character specific.
export const useKvpSettings = <T>(key: string, initalValue?: unknown) => {
	const { getItem, setItem } = window.localStorage;
	const { state } = useRootState();
	const { id } = state.character;

	// Decoded data so that it can be updated on the NUI when the setting updates.
	const [data, setData] = useState(initalValue || {});

	// Get the settings json from localStorage and parse it.
	const getCharacterSettings = (): { [x: string]: T } => {
		const settings: string | null = getItem('nui-settings');

		// If the settings item doesn't exist initalize it.
		if (!settings) {
			setItem('nui-settings', JSON.stringify({}));
			return {};
		}

		const settingsParsed: { [x: string]: { [x: string]: T } } =
			JSON.parse(settings);
		if (!settingsParsed) return {};

		// Return the parsed settings for our character
		return settingsParsed[String(id)];
	};

	// On hook mount lets get the settings
	useEffect(() => {
		const characterSettings = getCharacterSettings()[key];

		// Determine if the settings exist.
		// If not then empty object or set settings.
		if (isEmpty(characterSettings)) {
			setData({});
		} else {
			setData(characterSettings);
		}
	}, []);
};
