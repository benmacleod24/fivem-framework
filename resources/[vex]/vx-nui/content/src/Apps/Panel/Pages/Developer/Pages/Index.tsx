import * as React from "react";
import Options from "../components/Options";
import States from "../components/States";

interface MainProps {
  setPage: (v: string) => void;
}

const Main: React.FunctionComponent<MainProps> = ({ setPage }) => {
  return (
    <React.Fragment>
      <States setPage={setPage} />
      <Options />
    </React.Fragment>
  );
};

export default Main;
