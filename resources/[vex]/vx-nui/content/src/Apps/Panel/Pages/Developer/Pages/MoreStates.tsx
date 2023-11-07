import { Button, Flex, Grid, Heading } from "@chakra-ui/react";
import * as React from "react";
import { FaArrowLeft } from "react-icons/fa";
import { usePhoneContext } from "../../../../../context/phone";
import { useRootContext } from "../../../../../context/root";
import JSONBox from "../../../components/JSONBox";

interface MoreStatesProps {
  setPage: (v: string) => void;
}

const MoreStates: React.FunctionComponent<MoreStatesProps> = ({ setPage }) => {
  const { state: rootState } = useRootContext();
  const { state: phoneState } = usePhoneContext();

  return (
    <Flex flexDir={"column"} w='full' mb='5'>
      <Flex alignItems={"center"} w='full' justifyContent={"space-between"} mb='1'>
        <Heading lineHeight={"none"} size='sm' color='blue.200'>
          Game States
        </Heading>
        <Button
          onClick={() => setPage("")}
          size='xs'
          colorScheme={"gray"}
          color='whiteAlpha.600'
          variant={"ghost"}
          leftIcon={<FaArrowLeft />}
        >
          Go Back
        </Button>
      </Flex>
      <Grid templateColumns={"repeat(3, 1fr)"} w='full' gap={3}>
        <JSONBox data={rootState} />
        <JSONBox data={phoneState} />
        <JSONBox data={process.env} />
        <JSONBox endpoint='/dev/table/characters' />
        <JSONBox endpoint='/dev/table/jobs' />
        <JSONBox endpoint='/dev/table/hotels' />
        <JSONBox endpoint='/dev/table/interiors' />
        <JSONBox endpoint='/dev/table/vehicle-keys' />
      </Grid>
    </Flex>
  );
};

export default MoreStates;
