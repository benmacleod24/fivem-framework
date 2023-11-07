import "focus-visible/dist/focus-visible";
import React from "react";
import ReactDOM from "react-dom/client";
import "./styles/index.css";
import App from "./App";
import { ChakraProvider } from "@chakra-ui/react";
import theme from "./styles/theme";
import RootProvider from "./context/root/provider";
import PhoneProvider from "./context/phone/provider";
import "focus-visible/dist/focus-visible";
import { SWRConfig } from "swr";

const root = ReactDOM.createRoot(document.getElementById("root") as HTMLElement);
root.render(
  <SWRConfig
    value={{
      fetcher: (resource, init) =>
        fetch(`https://vx-nui${resource}`, init).then((res) => res.json()),
    }}
  >
    <RootProvider>
      <PhoneProvider>
        <ChakraProvider resetCSS theme={theme}>
          <App />
        </ChakraProvider>
      </PhoneProvider>
    </RootProvider>
  </SWRConfig>
);
