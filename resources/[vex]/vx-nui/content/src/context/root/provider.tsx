import * as React from "react";
import { RootContext, InitState } from ".";
import RootReducer from "./reducer";

interface RootProviderProps {
  children: any;
}

const RootProvider: React.FunctionComponent<RootProviderProps> = ({ children }) => {
  const [state, dispatch] = React.useReducer(RootReducer, InitState);

  return (
    <RootContext.Provider value={{ state, dispatch }}>
      {children}
    </RootContext.Provider>
  );
};

export default RootProvider;
