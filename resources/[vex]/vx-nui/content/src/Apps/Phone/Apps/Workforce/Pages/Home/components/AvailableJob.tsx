import { IconButton, Tooltip } from "@chakra-ui/react";
import * as React from "react";
import { MdGroup, MdGroupAdd } from "react-icons/md";
import post from "../../../../../../../lib/post";
import MenuItem from "../../../../../components/App/Menulist/MenuItem";

interface AvailableJobProps {
  party: JobParty;
  job: Job;
}

const AvailableJob: React.FunctionComponent<AvailableJobProps> = ({
  party,
  job,
}) => {
  const onJoinJob = async () => {
    const res = await post("/phone/workforce/party/join", {
      job_id: job.id,
      party_id: party.partyId,
    });

    if (res !== party.partyId) return;

    // Here we need to update nui to be apart of party
  };

  return (
    <MenuItem
      description={`${party.partyMembers.length}/${job.max_member_limit} Members`}
      icon={MdGroup}
      iconColor='purple.300'
      rightButton={
        <Tooltip
          label='Join Party'
          textTransform='capitalize'
          maxW='32'
          bg='grey.800'
          fontSize='xs'
          textAlign='center'
          placement='right'
          color='white'
        >
          <IconButton
            aria-label='join-job-party'
            icon={<MdGroupAdd />}
            rounded='full'
            size='sm'
            fontSize={"lg"}
            variant='ghost'
            name='Join Party'
          />
        </Tooltip>
      }
    >
      {party.partyName}
    </MenuItem>
  );
};

export default AvailableJob;
