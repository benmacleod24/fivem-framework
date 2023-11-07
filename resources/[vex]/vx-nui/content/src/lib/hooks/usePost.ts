import React from "react";
import post from "../post";

export interface usePostResponse<T> {
  data: T | undefined;
  refetch: () => void;
}

// Simple hook that allows me to use post wrapper with state so I don't have to repeat shit
export const usePost = <T>(uri: string, body: unknown): usePostResponse<T> => {
  const [res, setRes] = React.useState<T>();

  // Allows to be async and passed as a refetch
  const fetchData = async () => {
    const _res = await post<T>(uri, body);
    setRes(_res);
  };

  // Fetch the data immeditaly on mount
  React.useEffect(() => {
    fetchData();
  }, []);

  return {
    data: res,
    refetch: fetchData,
  };
};
