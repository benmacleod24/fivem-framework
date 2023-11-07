import * as React from "react";

export const useDebounce = (value: string, timeout = 1000) => {
  let [debouncedValue, setDebouncedValue] = React.useState(value);

  React.useEffect(() => {
    let timeoutId = setTimeout(() => {
      setDebouncedValue(value);
    }, timeout);

    return () => {
      clearTimeout(timeoutId);
    };
  }, [value]);

  return debouncedValue;
};
