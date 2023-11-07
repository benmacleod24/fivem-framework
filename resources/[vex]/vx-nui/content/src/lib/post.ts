export const safeJSONParse = async <T>(res: Response | any): Promise<T> => {
  if (res.ok) {
    const json = await res.json();
    return json;
  } else {
    throw new Error("Invalid Response (Failed to gather json)");
  }
};

const post = async <T>(
  url?: string | null,
  body?: unknown
): Promise<T | undefined> => {
  if (url === null || !url) return undefined;

  const res = await fetch(`https://vx-nui${url}`, {
    body: JSON.stringify(body || {}),
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
  });

  const parsedJSON = await safeJSONParse<T>(res);
  return parsedJSON;
};

export default post;
