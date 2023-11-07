import { useToast } from "@chakra-ui/react";
import React, { ReactElement, useEffect } from "react";
import Loader from "./Loader";

export const LoadableContent = ({
  isLoading = false,
  error,
  behaviour = "error",
  homeUrl = "/",
  errorMessage = "Sorry, there was a problem loading this content. Please try reloading your browser, or contact us for help.",
  loaderHeight,
  loader,
  children,
}: {
  isLoading?: boolean;
  error?: Error;
  behaviour?: "ignore" | "warning" | "error" | "redirect";
  homeUrl?: string;
  errorMessage?: string;
  loaderHeight?: string | number;
  loader?: ReactElement | null;
  children: ReactElement | null;
}): ReactElement | null => {
  const toast = useToast();

  useEffect(() => {
    if (error && behaviour !== "ignore") {
      if (behaviour === "error") {
        throw error;
      } else {
        toast({
          description: errorMessage,
          duration: 5000,
          status: "error",
          isClosable: true,
        });
      }
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [error, errorMessage, homeUrl]);

  if (error && behaviour !== "ignore") return null;
  return isLoading ? (
    loader ? (
      loader
    ) : (
      <Loader
        height={loaderHeight}
        size={loaderHeight === "auto" ? "sm" : undefined}
      />
    )
  ) : (
    children
  );
};

interface Props {}
type MakeRequired<Type> = { [key in keyof Type]-?: NonNullable<Type[key]> };
const isLoaded = <T extends Props>(data: T): data is MakeRequired<T> => {
  return Object.values(data).every((v) => v !== undefined && v !== null);
};

export const LoadableContentSafe = <T extends Props>({
  data,
  homeUrl = "/",
  errorMessage = "Sorry, there was a problem loading this content. Please try reloading your browser, or contact us for help.",
  children,
  loaderHeight = "25vh",
  behaviour = "bubble",
  errors = [],
  loader = <Loader height={loaderHeight} />,
}: {
  data: T;
  isError?: boolean;
  isCritical?: boolean;
  homeUrl?: string;
  errorMessage?: string;
  errors: Array<Error | undefined>;
  behaviour?: "catch" | "bubble";
  children: (data: MakeRequired<T>) => ReactElement;
  loaderHeight?: string | number;
  loader?: ReactElement;
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
      throw firstError;
    }
  }, [errors, homeUrl, errorMessage, setToast, behaviour]);

  if (isLoaded(data) && errors.filter(Boolean).length === 0) {
    return children(data);
  }
  return loader;
};

export default LoadableContentSafe;
