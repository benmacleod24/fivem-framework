import { useEffect, useState } from 'react';
import { fetch } from '../helpers';

interface useFetchReturn<T> {
	data: T | undefined;
	refetch: (v: unknown) => Promise<T | undefined>;
}

/**
 *
 * @param url {string} The url is the endpoint which you want to hit on the lua-side.
 * @param body Body is a set of data that you want the endpoint to recieve.
 * @param initalData allows for inital data in the state if you have some you want.
 * @param developmentData Just a developer param that allows mock data while developing in the browser.
 * @returns An object with the data and a function to refetch the data which a new body can be passed in.
 */
export const useFetch = <T>(
	url: string,
	body?: unknown,
	initalData?: T,
	developmentData?: T
): useFetchReturn<T> => {
	const [data, setData] = useState<T | undefined>(initalData || undefined);

	// Allow the fetch method to awaitable for the data
	const fetchData = async (_body: unknown) => {
		const response = await fetch<T>(url, _body, developmentData);

		// If the response wasn't successfully lets return undefined data.
		if (!response) return undefined;

		// Set data and return incase function wants to use it.
		setData(response);
		return response;
	};

	// Fetch the data on hook mount
	// No need for an unmount callback
	useEffect(() => {
		fetchData(body);
	}, []);

	return {
		data,
		refetch: fetchData,
	};
};
