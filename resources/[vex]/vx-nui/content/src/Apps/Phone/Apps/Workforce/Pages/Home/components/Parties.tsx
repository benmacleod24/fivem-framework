import { Flex, Text } from "@chakra-ui/react";
import * as React from "react";
import MenuList from "../../../../../components/App/Menulist";
import AvailableJob from "./AvailableJob";

interface PartiesProps {
  job: Job;
}

const Parties: React.FunctionComponent<PartiesProps> = ({ job }) => {
  return (
    <React.Fragment>
      <Flex
        my='3'
        mb='4'
        bg='grey.800'
        p='2'
        px='3'
        rounded={"md"}
        justify='space-between'
      >
        <Text fontWeight={"medium"} color='purple.100'>
          Job Location
        </Text>
        <Text as='span' color='whiteAlpha.500'>
          {job.display_name}
        </Text>
      </Flex>
      <MenuList>
        {job.parties &&
          Object.values(job.parties)
            .filter((p) => !p.isInviteOnly)
            .map((a) => <AvailableJob job={job} key={a.partyId} party={a} />)}
      </MenuList>
    </React.Fragment>
  );
};

export default Parties;
