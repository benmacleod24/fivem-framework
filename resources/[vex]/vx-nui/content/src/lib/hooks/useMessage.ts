import * as React from "react";

export const useMessage = <T>(
  messageName: string,
  callBack?: (v: T) => void,
  depends?: React.DependencyList[] | any[] | undefined
) => {
  const [data, setData] = React.useState<T | undefined>(undefined);

  const handleMessage = (event: MessageEvent<any>) => {
    if (!event.data.type || event.data.type !== messageName) return;
    setData(event.data.payload);
    callBack && callBack(event.data.payload);
  };

  React.useEffect(() => {
    window.addEventListener("message", handleMessage);

    return () => {
      window.removeEventListener("message", handleMessage);
    };
  }, depends || []);

  return { data };
};
