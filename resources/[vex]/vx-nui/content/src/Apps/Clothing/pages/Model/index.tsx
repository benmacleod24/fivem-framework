import { SearchIcon } from "@chakra-ui/icons";
import { Flex, Input, InputGroup, InputLeftElement } from "@chakra-ui/react";
import * as React from "react";
import { useDebounce } from "../../../../lib/hooks/useDebounce";
import ModelCat from "./ModelCat";
import { peds } from "./models";

interface ModelProps {}

const Model: React.FunctionComponent<ModelProps> = ({}) => {
  const [searchTerm, setSearchTerm] = React.useState("");
  const debouncedTerm = useDebounce(searchTerm, 500);

  const buildModelDisplay = (cat: string) => {
    // If term is empty just return all array
    if (!debouncedTerm) return <ModelCat name={cat} values={peds[cat]} />;

    // If the term does not match return nothing
    if (
      !peds[cat].find((s) =>
        s.toLocaleUpperCase().includes(debouncedTerm.toLocaleUpperCase())
      )
    )
      return null;

    // Return what ever the term matches
    return (
      <ModelCat
        name={cat}
        values={peds[cat].filter((s) =>
          s.toLocaleUpperCase().includes(debouncedTerm.toLocaleUpperCase())
        )}
      />
    );
  };

  return (
    <Flex px='4' pt='4' flexDir={"column"} overflow='scroll'>
      <InputGroup variant={"filled"} mb='1.5'>
        <InputLeftElement children={<SearchIcon />} />
        <Input
          placeholder='Model Name'
          _focus={{
            outline: "none",
          }}
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
      </InputGroup>
      {buildModelDisplay("freemode")}
      {buildModelDisplay("male")}
      {buildModelDisplay("female")}
    </Flex>
  );
};

export default Model;
