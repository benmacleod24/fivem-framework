import * as React from 'react';

// This will always return a string no matter what.
// timeout is default 1 second, don't really need more but can change.
export const useDebounce = (value: string, timeout = 1000): string => {
	let [debouncedValue, setDebouncedValue] = React.useState<string>(value);

	React.useEffect(() => {
		let timeoutId = setTimeout(() => {
			setDebouncedValue(value.toString());
		}, timeout);

		return () => {
			clearTimeout(timeoutId);
		};
	}, [value]);

	return debouncedValue;
};
