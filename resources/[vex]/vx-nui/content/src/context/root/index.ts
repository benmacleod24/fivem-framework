import * as React from "react";
import { RootActions } from "./actions";
import Provider from "./provider";

export interface RootState {
  application: string;
  isAppReady: boolean;
  isAppDev: boolean;
  netId: number;
  character: Character;
}

const InitState: RootState = {
  application: "",
  isAppDev: process.env.NODE_ENV === "development" ? true : false,
  isAppReady: process.env.NODE_ENV === "development" ? true : false,
  netId: 1,
  character: {
    characterId: 0,
    dateOfBirth: "NULL_DOB",
    firstName: "Greg",
    lastName: "Smith",
    characterOwner: 0,
    netId: 0,
  },
};

const RootContext = React.createContext<{
  state: RootState;
  dispatch: React.Dispatch<RootActions>;
}>({
  state: InitState,
  dispatch: () => null,
});

// HOOKS
const useRootContext = () => React.useContext(RootContext);

export { RootContext, useRootContext, InitState };
export { default as Provider } from "./provider";
