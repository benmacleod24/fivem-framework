import { Flex } from "@chakra-ui/react";
import { accessories as data } from "./accessories";
import * as React from "react";
import AccessoryWrapper from "./AccessoryWrapper";

interface AccessoriesProps {}

const Accessories: React.FunctionComponent<AccessoriesProps> = ({}) => {
  return (
    <Flex flexDir={"column"} gap={1.5} px='4' pt='4' overflow={"scroll"}>
      {data.map((v) => (
        <AccessoryWrapper key={v.id + v.componentId} data={v} />
      ))}
    </Flex>
  );
};

export default Accessories;
