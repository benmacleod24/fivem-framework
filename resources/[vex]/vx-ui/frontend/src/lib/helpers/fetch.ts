import { isEnvBrowser } from "./misc";

/**
 * Simple wrapper around fetch API tailored for CEF/NUI use. This abstraction
 * can be extended to include AbortController if needed or if the response isn't
 * JSON. Tailor it to your needs.
 *
 * @param eventName - The endpoint eventname to target
 * @param data - Data you wish to send in the NUI Callback
 * @param mockData - Mock data to be returned if in the browser
 *
 * @return returnData - A promise for the data sent back by the NuiCallbacks CB argument
 */

const safeJSONParse = async <T>(resp: Response): Promise<T> => {
	if (resp.ok) {
		const json = await resp.json();
		return json;
	} else {
		throw new Error("Invalid Response (Failed to gather json)");
	}
};

export async function fetch<T = any>(
	eventName: string,
	data?: any,
	mockData?: T
): Promise<T> {
	if (isEnvBrowser() && mockData) return mockData;

	const nuiResp = await fetch(`https://vex-nui${eventName}`, {
		method: "post",
		headers: {
			"Content-Type": "application/json; charset=UTF-8",
		},
		body: JSON.stringify(data),
	});

	const parsedResp = await safeJSONParse<T>(nuiResp);
	return parsedResp;
}
