import {
  Flex,
  InputGroup,
  Input as InputComp,
  useOutsideClick,
} from "@chakra-ui/react";
import * as React from "react";
import { string } from "yup";
import post from "../../../lib/post";
import { fetcher } from "../../../lib/swr";
import { DeveloperOption, options } from "../Pages/Developer/config";

interface InputProps {
  option: DeveloperOption;
}

const Input: React.FunctionComponent<InputProps> = ({ option }) => {
  const [value, setValue] = React.useState<string>("");
  const [showOptions, setShowOptions] = React.useState<boolean>(false);
  const [data, setData] = React.useState<{ label: string; value: any }[] | null>(
    null
  );
  const inputRef: React.LegacyRef<HTMLDivElement> = React.createRef();

  React.useEffect(() => {
    getAutoCompleteData();
  }, []);

  const getAutoCompleteData = async () => {
    let data: null | { label: string; value: any }[] = null;
    if (option.interface.type !== "INPUT") return;

    if (Array.isArray(option.interface.options)) {
      data = option.interface.options;
    }

    if (typeof option.interface.options === "string") {
      const res: any = await post(option.interface.options);
      data = res || null;
    }

    setData(data);
  };

  const onSubmitValue = async (v: any) => {
    await fetcher(option.interface.endpoint, v);
  };

  useOutsideClick({
    ref: inputRef,
    handler: () => setShowOptions(false),
  });

  if (option.interface.type !== "INPUT") return null;

  return (
    <Flex pos='relative' ref={inputRef}>
      <InputGroup variant={"filled"}>
        <InputComp
          placeholder={option.interface.placeholder || option.name}
          _focus={{ outline: "none" }}
          value={value}
          onChange={(e) => {
            setValue(e.target.value as string);
            if (e.target.value.length === 0) return setShowOptions(false);
            return setShowOptions(true);
          }}
          onFocus={() => {
            if (
              value ||
              value.length > 1 ||
              (option.interface.type === "INPUT" &&
                option.interface.showOptionsOnClick)
            ) {
              setShowOptions(true);
            }
          }}
          onKeyUp={async (e) => {
            if (
              e.key === "Enter" &&
              option.interface.type === "INPUT" &&
              option.interface.onSubmit
            ) {
              await post(option.interface.endpoint, value);
            }
          }}
        />
      </InputGroup>
      {data && showOptions && (
        <Flex
          pos='absolute'
          left='0'
          top='115%'
          bg='gray.600'
          w='full'
          rounded='md'
          flexDir={"column"}
          overflow='auto'
          maxH='52'
        >
          {data
            .filter((d) =>
              d.label.toLocaleLowerCase().includes(value.toLocaleLowerCase())
            )
            .map((d) => (
              <Flex
                p='2'
                key={d.label + d.value}
                onClick={() => {
                  post(option.interface.endpoint, d.value);
                }}
                px='3'
                transition={"0.2s ease-in-out"}
                cursor='pointer'
                textTransform={"capitalize"}
                _hover={{ bg: "gray.500" }}
              >
                {d.label}
              </Flex>
            ))}
        </Flex>
      )}
    </Flex>
  );
};

export default Input;
