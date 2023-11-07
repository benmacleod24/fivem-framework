import { Flex } from "@chakra-ui/react";
import * as React from "react";
import MenuList from "../../../../components/App/Menulist";
import MenuItem from "../../../../components/App/Menulist/MenuItem";
import Header from "../../components/Header";
import PartyMember from "./components/PartyMember";

interface ActiveJobProps {
  job: Job;
}

const ActiveJob: React.FunctionComponent<ActiveJobProps> = ({ job }) => {
  return (
    <Flex w='full' h='full' flexDir={"column"}>
      <Header />
      <Flex>
        <MenuList>
          {job.parties["1"].partyMembers.map((m) => (
            <PartyMember member={m} partyOwner={job.parties["1"].partyOwner} />
          ))}
        </MenuList>
      </Flex>
    </Flex>
  );
};

export default ActiveJob;
