import { Flex } from "@chakra-ui/react";
import { Clothes as data } from "./clothes";
import * as React from "react";
import ClothingWrapper from "./ClothingWrapper";

interface ClothesProps {}

const Clothes: React.FunctionComponent<ClothesProps> = ({}) => {
  return (
    <Flex flexDir={"column"} gap={1.5} px='4' pt='4' overflow={"scroll"}>
      {data.map((v) => (
        <ClothingWrapper key={v.id + v.componentId} data={v} />
      ))}
    </Flex>
  );
};

export default Clothes;
