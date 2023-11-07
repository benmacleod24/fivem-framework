import { Flex } from "@chakra-ui/react";
import { values } from "lodash";
import * as React from "react";
import { useRootContext } from "../../../../context/root";
import { useMessage } from "../../../../lib/hooks/useMessage";
import Circle from "./components/Circle";
import Stopwatch from "./components/Stopwatch";

interface StatusProps {}

const Status: React.FunctionComponent<StatusProps> = ({}) => {
  const { state } = useRootContext();
  const [values, setValues] = React.useState<{ [x: string]: number }>({
    health: 100,
    hunger: 100,
    thirst: 100,
    armor: 100,
  });

  // Listen for an update on a value
  // Can insert any values isn't restricted
  useMessage(
    "nui:hud:status:set",
    ({ key, value }: { key: string; value: number }) => {
      setValues({
        ...values,
        [key]: value,
      });
    },
    [values]
  );

  // Listen to remove a status value
  useMessage(
    "nui:hud:status:remove",
    (key: string) => {
      const new_values = { ...values };
      delete values[key];
      setValues({ ...new_values });
    },
    [values]
  );

  if (state.application === "inventory") return null;

  return (
    <Flex
      w='50%'
      alignItems='center'
      justifyContent='flex-start'
      pos='absolute'
      left='1'
      bottom='0.5'
    >
      <Circle _key={"health"} value={values["health"]} />
      <Circle _key={"armor"} value={values["armor"]} />
      <Circle _key={"hunger"} value={values["hunger"]} />
      <Circle _key={"thirst"} value={values["thirst"]} />
      <Stopwatch />
    </Flex>
  );
};

export default Status;
