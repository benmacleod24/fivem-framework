import { Flex, Switch, Text } from "@chakra-ui/react";
import * as React from "react";
import { usePhoneContext } from "../../../../../context/phone";
import { useKvpSettings } from "../../../../../lib/hooks/useKvpSettings";

interface GeneralProps {
  category: string;
  options: {
    [k: string]: {
      key: string;
      value: number | string | boolean;
    };
  };
}

const General: React.FunctionComponent<GeneralProps> = ({ options, category }) => {
  const { state, dispatch } = usePhoneContext();
  const { settings, updateSettings: setSettings } =
    useKvpSettings<any>("phoneSettings");

  return (
    <Flex
      w='full'
      mt='5'
      bg='grey.800'
      h='fit-content'
      borderRadius={"md"}
      flexDir='column'
    >
      {Object.values(options).map((o) => {
        if (typeof o.value === "boolean") {
          return (
            <Flex
              key={o.key}
              alignItems={"center"}
              justifyContent='space-between'
              h='fit-content'
              w={"full"}
              p='2'
            >
              <Text textTransform={"capitalize"}>{o.key.replaceAll("_", " ")}</Text>
              <Switch
                colorScheme={"green"}
                isChecked={state.settings[o.key]}
                onChange={(e) => {
                  dispatch({
                    type: "UPDATE_SETTING",
                    payload: {
                      setting: {
                        key: o.key,
                        value: !state.settings[o.key],
                      },
                    },
                  });

                  setSettings({
                    ...state.settings,
                    [o.key]: !state.settings[o.key],
                  });
                }}
              />
            </Flex>
          );
        }
      })}
    </Flex>
  );
};

export default General;
