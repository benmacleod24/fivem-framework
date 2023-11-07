import * as React from "react";
import { PhoneActions } from "./actions";
import Provider from "./provider";

export interface PhoneState {
  application: number;
  settings: { [k: string]: any };
  phoneNumber: string;
}

const InitState: PhoneState = {
  application: 0,
  settings: {},
  phoneNumber: "3333333333",
};

const PhoneContext = React.createContext<{
  state: PhoneState;
  dispatch: React.Dispatch<PhoneActions>;
}>({
  state: InitState,
  dispatch: () => null,
});

// HOOKS
const usePhoneContext = () => React.useContext(PhoneContext);

export { PhoneContext, usePhoneContext, InitState };
export { default as Provider } from "./provider";
