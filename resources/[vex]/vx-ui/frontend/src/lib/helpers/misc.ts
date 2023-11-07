// Returns a size that is persistant on all resolutions
export const uiSize = (size: number) => `${(size / 1080) * 100}vh`;

// Converts Hex 2 RGB
export const colorH2A = (hex: string): [r: number, g: number, b: number] => {
	return [
		parseInt(hex, 16) >> 16,
		(parseInt(hex, 16) >> 8) & 0xff,
		parseInt(hex, 16) & 0xff,
	];
};

// Get's the hash for a piece of text; it is the same logic that fivem uses..
export const getHashKey = (text: string): number => {
	const keyLowered = text.toLowerCase();
	const keyLength = text.length;

	let hash, i;

	for (hash = i = 0; i < keyLength; i++) {
		hash += keyLowered.charCodeAt(i);
		hash += hash << 10;
		hash ^= hash >>> 6;
	}

	hash += hash << 3;
	hash ^= hash >>> 11;
	hash += hash << 15;

	return hash;
};

// Will return whether the current environment is in a regular browser
// and not CEF
export const isEnvBrowser = (): boolean => !(window as any).invokeNative;

// Basic no operation function
export const noop = () => {};
