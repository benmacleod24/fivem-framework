import { isEmpty } from 'lodash';
import {
	createRef,
	MutableRefObject,
	useEffect,
	useRef,
	useState,
} from 'react';
import { fetch, isEnvBrowser } from '../helpers';
import EventBus from '../helpers/events';
import { useRootState } from '../state/root';

export interface useAppReturn<T = {}> {
	isOpen: boolean;
	closeApp: () => void;
	openApp: (_appName: string, data?: unknown) => void;
	data?: T;
}

/**
 *	Awesome hook that allows managing apps to be much easier and cleaner in the code. 
 	Closes apps, opens them, and relays data to them.
 * 
 * @param appName Name of the app you are currently working with; 
 	additonal spaces in any app name should be replaced with an underscore.
 * @returns Returns an object of isOpen, closeApp, openApp, and relayed data from another app.
 */
export const useApp = <T>(appName: string): useAppReturn<T> => {
	const { state, dispatch } = useRootState();

	// This will allow for relay data from different apps when opening it.
	const [data, setData] = useState<T | undefined>(undefined);

	// Instance of the event bus for the entire hook.
	const _eventBus = EventBus.getInstance();
	const { current: eventBus }: MutableRefObject<typeof _eventBus> =
		useRef(_eventBus);

	// listen for a data relay here instead of in the actually component.
	// Listening in the actually component will get messy.
	eventBus.register(`${appName}:relay-data:catch`, (data: T) => {
		setData(data);
	});

	// Close current app from inside nui, also wait for lua-side to recieve it.
	const closeApp = async () => {
		!isEnvBrowser() && (await fetch('/nui/close'));
		dispatch({ type: 'SET_APPLICATION', payload: '' });
	};

	const openApp = async (_appName: string, data?: unknown) => {
		// If data exist or isn't null we want to relay the data.
		// Easy way to have cross app data.
		if (data || !isEmpty(data)) {
			eventBus.dispatch(`${_appName}:relay-data:catch`, data);
		}

		// Dispatch the event in the NUI and relay it to the lua-side
		!isEnvBrowser() && (await fetch('/nui/app/open', _appName));
		dispatch({ type: 'SET_APPLICATION', payload: _appName });
	};

	return {
		isOpen: state.application === appName,
		closeApp,
		openApp,
		data,
	};
};
