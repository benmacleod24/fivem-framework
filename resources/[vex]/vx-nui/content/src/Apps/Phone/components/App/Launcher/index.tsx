import { useToast } from "@chakra-ui/react";
import React, { ReactElement, useEffect } from "react";
import LauncherScreen from "./Screen";

interface Props {}
type MakeRequired<Type> = { [key in keyof Type]-?: NonNullable<Type[key]> };
const isLoaded = <T extends Props>(data: T): data is MakeRequired<T> => {
  return Object.values(data).every((v) => v !== undefined && v !== null);
};

const AppLauncher = <T extends Props>({
  data,
  errorMessage = "Sorry, there was a problem loading this content. Please try reloading your browser, or contact us for help.",
  children,
  behaviour = "bubble",
  errors = [],
  loader = <LauncherScreen />,
}: {
  data: T;
  isError?: boolean;
  isCritical?: boolean;
  homeUrl?: string;
  errorMessage?: string;
  errors: Array<Error | undefined>;
  behaviour?: "catch" | "bubble";
  children: (data: MakeRequired<T>) => ReactElement;
  loader?: any;
}): ReactElement => {
  const setToast = useToast();

  useEffect(() => {
    if (errors.filter(Boolean).length > 0) {
      setToast({
        description: errorMessage,
        duration: 5000,
        status: "error",
        isClosable: true,
      });
      const [firstError, ...rest] = errors.filter(Boolean);
      if (behaviour === "catch") {
        if (!["production"].includes(process.env?.APP_ENV ?? "")) {
          [firstError, ...rest].forEach((e) => console.error(e));
        }
        return;
      }

      // Log any errors that may have occurred after the first

      if (!["production"].includes(process.env.APP_ENV ?? "")) {
        rest.forEach((e) => {
          console.error(e);
          console.error(e?.message);
        });
      }

      // Throw the first error we received, so we have a nice stack trace
      console.log(firstError);
    }
  }, [errors, errorMessage, setToast, behaviour]);

  if (isLoaded(data) && errors.filter(Boolean).length === 0) {
    return children(data);
  }
  return loader;
};

export default AppLauncher;
