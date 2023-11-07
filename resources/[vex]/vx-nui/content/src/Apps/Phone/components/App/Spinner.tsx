import { Box, Flex } from "@chakra-ui/react";
import * as React from "react";

interface SpinnerProps {
  w?: string;
  h?: string;
}

const Spinner: React.FunctionComponent<SpinnerProps> = ({ w, h }) => {
  return (
    <Flex className='spinner' w={w || "34px"} h={h || "34px"}>
      {[...new Array(12)].map((a, i) => (
        <div className={`bar${i + 1}`} />
      ))}
    </Flex>
  );
};

export default Spinner;
