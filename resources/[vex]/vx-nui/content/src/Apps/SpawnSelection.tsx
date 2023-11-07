import { Button, Flex, Grid, Heading, Text } from "@chakra-ui/react";
import * as React from "react";
import useSWR from "swr";
import LoadableContentSafe from "../components/LoadableContent";
import AnimateApp from "../components/Transitions/AnimateApp";
import Scale from "../components/Transitions/Scale";
import { fetcher } from "../lib/swr";

export interface LocationType {
  id: number;
  name: string;
  description: string;
}
interface SpawnSelectionProps {}

const SpawnSelection: React.FunctionComponent<SpawnSelectionProps> = ({}) => {
  const [selected, setSelected] = React.useState<number>(1);
  const [isLoading, setIsLoading] = React.useState<boolean>(false);
  const { data: locations } = useSWR<LocationType[]>("/spawn/locations");

  const SelectLocation = async () => {
    setIsLoading(true);
    await fetcher("spawn/select", { spawnId: selected });
    setIsLoading(false);
  };

  return (
    <AnimateApp
      Transition={Scale}
      appName='spawn'
      transitionProps={{
        w: "full",
        h: "full",
        justifyContent: "center",
        alignItems: "center",
      }}
    >
      <Flex w='2xl' flexDir={"column"}>
        <LoadableContentSafe data={{ locations }} errors={[]}>
          {({ locations }) => {
            return (
              <React.Fragment>
                <Grid templateColumns={"repeat(3, 1fr)"} gap={2} mb='2'>
                  {locations.map((l, i) => (
                    <Flex
                      key={i}
                      borderRadius={"md"}
                      bg={selected === l.id ? "gray.600" : "gray.700"}
                      p='3'
                      flexDir={"column"}
                      userSelect={"none"}
                      onClick={() => setSelected(l.id)}
                    >
                      <Heading size='sm'>{l.name}</Heading>
                      <Text fontSize={"xs"}>{l.description}</Text>
                    </Flex>
                  ))}
                </Grid>
                <Button
                  w='25%'
                  colorScheme={"orange"}
                  onClick={SelectLocation}
                  isLoading={isLoading}
                >
                  Spawn
                </Button>
              </React.Fragment>
            );
          }}
        </LoadableContentSafe>
      </Flex>
    </AnimateApp>
  );
};

export default SpawnSelection;
