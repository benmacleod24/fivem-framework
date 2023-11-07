import { Box, Flex, Text } from "@chakra-ui/react";
import * as React from "react";
import useSWR from "swr";
import { useSWRWrapper } from "../../../lib/swr";

interface JSONBoxProps {
  data?: any;
  endpoint?: string;
}

const JSONBox: React.FunctionComponent<JSONBoxProps> = ({ data, endpoint }) => {
  const { data: endpointData, error } = useSWR(endpoint || null);

  return (
    <Box
      borderRadius='md'
      w='full'
      h='full'
      p='2'
      background='gray.800'
      maxH='40'
      overflow='auto'
    >
      <pre>
        <Text fontSize='xs'>
          {JSON.stringify(endpointData || data || {}, null, 2)}
          {JSON.stringify(error)}
        </Text>
      </pre>
    </Box>
  );
};

export default JSONBox;
