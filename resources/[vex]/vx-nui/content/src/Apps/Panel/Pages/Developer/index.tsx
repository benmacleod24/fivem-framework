import { Flex } from "@chakra-ui/react";
import * as React from "react";
import Options from "./components/Options";
import States from "./components/States";
import Main from "./Pages/Index";
import MoreStates from "./Pages/MoreStates";

interface DeveloperProps {}

const Developer: React.FunctionComponent<DeveloperProps> = ({}) => {
  const [page, setPage] = React.useState<string>("");

  return (
    <Flex flexGrow={1} h='full' p='4' flexDir={"column"}>
      {page === "" && <Main setPage={setPage} />}
      {page === "more-states" && <MoreStates setPage={setPage} />}
    </Flex>
  );
};

export default Developer;
