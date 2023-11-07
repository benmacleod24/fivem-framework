import { Flex, Grid, Heading } from "@chakra-ui/react";
import * as React from "react";
import Input from "../../../components/Input";
import Switch from "../../../components/Switch";
import { DeveloperOption, options as OpsConfig } from "../config";

interface OptionsProps {}

const Options: React.FunctionComponent<OptionsProps> = ({}) => {
  // Split into the different interface types
  const data = OpsConfig.reduce((srt: { [x: string]: DeveloperOption[] }, nxt) => {
    if (!srt[nxt.interface.type]) srt[nxt.interface.type] = [nxt];
    if (srt[nxt.interface.type].includes(nxt)) return srt;
    if (srt[nxt.interface.type]) srt[nxt.interface.type].push(nxt);
    return srt;
  }, {});

  return (
    <Flex flexDir={"column"} w='full'>
      <Flex alignItems={"center"} w='full' justifyContent={"space-between"} mb='2'>
        <Heading lineHeight={"none"} size='sm' color='blue.200'>
          Developer Options
        </Heading>
      </Flex>

      <Grid w='full' templateColumns={"repeat(3, 1fr)"} gap={3} mb='5'>
        {data["SWITCH"].map((o) => (
          <Switch
            key={o.id + o.name}
            name={o.name}
            endpoint={o.interface.endpoint}
          />
        ))}
      </Grid>

      <Grid w='full' templateColumns={"repeat(3, 1fr)"} gap={3} mb='5'>
        {data["INPUT"].map((o) => (
          <Input key={o.id + o.name} option={o} />
        ))}
      </Grid>
    </Flex>
  );
};

export default Options;
