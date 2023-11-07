import useSWR, { SWRResponse } from "swr";

export const headers = {
  method: "POST",
  headers: {
    "Content-Type": "application/json; charset=UTF-8",
  },
};

export interface DataWrapper<T> {
  success: boolean;
  data: T;
  message?: string;
}

export const safeJSONParse = async <T>(
  res: Response | any
): Promise<DataWrapper<T>> => {
  if (res.ok) {
    const json = await res.json();
    return json;
  } else {
    throw new Error("Invalid Response (Failed to gather json)");
  }
};

export const fetcher = async <T>(uri: string, body?: unknown): Promise<T> => {
  const response = await fetch(`https://vx-nui/${uri}`, {
    ...headers,
    body: JSON.stringify(body),
  });

  const parsedBody = await safeJSONParse<T>(response);

  if (!parsedBody.success) {
    throw new Error(parsedBody.message);
  }

  return parsedBody.data;
};

export const useSWRWrapper = <T>(
  uri: string | null,
  extraOptions?: Record<string, any>
) => {
  return useSWR<T>(uri, fetcher, {
    ...extraOptions,
  }) as SWRResponse<T, any>;
};
