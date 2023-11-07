import { Button, Flex, Grid, Heading } from "@chakra-ui/react";
import * as React from "react";
import { BiRightArrow, BiRightArrowAlt } from "react-icons/bi";
import { FaArrowRight } from "react-icons/fa";
import { usePhoneContext } from "../../../../../context/phone";
import { useRootContext } from "../../../../../context/root";
import JSONBox from "../../../components/JSONBox";

interface StatesProps {
  setPage: (v: string) => void;
}

const States: React.FunctionComponent<StatesProps> = ({ setPage }) => {
  const { state: rootState } = useRootContext();
  const { state: phoneState } = usePhoneContext();

  return (
    <Flex flexDir={"column"} w='full' mb='5'>
      <Flex alignItems={"center"} w='full' justifyContent={"space-between"} mb='1'>
        <Heading lineHeight={"none"} size='sm' color='blue.200'>
          Game States
        </Heading>
        <Button
          onClick={() => setPage("more-states")}
          size='xs'
          colorScheme={"gray"}
          color='whiteAlpha.600'
          variant={"ghost"}
          rightIcon={<FaArrowRight />}
        >
          View More
        </Button>
      </Flex>
      <Grid templateColumns={"repeat(3, 1fr)"} w='full' gap={3}>
        <JSONBox data={rootState} />
        <JSONBox data={phoneState} />
        <JSONBox endpoint='/dev/table/characters' />
      </Grid>
    </Flex>
  );
};

export default States;
