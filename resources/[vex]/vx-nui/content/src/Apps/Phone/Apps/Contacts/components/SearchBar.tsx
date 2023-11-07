import { AddIcon, SearchIcon } from "@chakra-ui/icons";
import {
  Flex,
  IconButton,
  Input,
  InputGroup,
  InputLeftElement,
} from "@chakra-ui/react";
import * as React from "react";

interface SearchBarProps {
  value: string;
  onChange: (v: string) => void;
  onClick?: () => void;
  hasAddButton?: boolean;
}

const SearchBar: React.FunctionComponent<SearchBarProps> = ({
  onChange,
  value,
  hasAddButton,
  onClick,
}) => {
  return (
    <Flex my='2' mx='3'>
      <InputGroup variant={"filled"} size='sm'>
        <InputLeftElement children={<SearchIcon />} zIndex={0} />
        <Input
          _focus={{ outline: "none" }}
          borderRadius={"lg"}
          placeholder='Search'
          value={value}
          onChange={(e) => onChange(e.target.value)}
        />
      </InputGroup>
      <IconButton
        aria-label='add-contact'
        icon={<AddIcon />}
        size='sm'
        variant={"ghost"}
        rounded='full'
        onClick={onClick}
        ml='2'
        colorScheme={"blue"}
      />
    </Flex>
  );
};

export default SearchBar;
