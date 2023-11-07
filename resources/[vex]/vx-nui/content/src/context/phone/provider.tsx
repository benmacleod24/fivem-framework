import * as React from "react";
import { PhoneContext, InitState } from ".";
import PhoneReducer from "./reducer";

interface PhoneProviderProps {
  children: any;
}

const PhoneProvider: React.FunctionComponent<PhoneProviderProps> = ({
  children,
}) => {
  const [state, dispatch] = React.useReducer(PhoneReducer, InitState);

  return (
    <PhoneContext.Provider value={{ state, dispatch }}>
      {children}
    </PhoneContext.Provider>
  );
};

export default PhoneProvider;
