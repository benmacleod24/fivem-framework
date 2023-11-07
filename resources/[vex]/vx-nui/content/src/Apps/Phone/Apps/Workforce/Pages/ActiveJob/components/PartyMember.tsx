import { CloseIcon } from "@chakra-ui/icons";
import { IconButton, Tooltip } from "@chakra-ui/react";
import * as React from "react";
import { BsPerson } from "react-icons/bs";
import useSWR from "swr";
import { useRootContext } from "../../../../../../../context/root";
import { usePost } from "../../../../../../../lib/hooks/usePost";
import MenuItem from "../../../../../components/App/Menulist/MenuItem";

interface PartyMemberProps {
  partyOwner: number;
  member: JobParty["partyMembers"][1];
}

const PartyMember: React.FunctionComponent<PartyMemberProps> = ({
  partyOwner,
  member,
}) => {
  const { state } = useRootContext();
  const { data } = usePost<{ firstName: string; lastName: string }>(
    `/character/get`,
    { character_id: member.characterId }
  );

  return (
    <MenuItem
      icon={BsPerson}
      iconColor={"purple.300"}
      rightButton={
        state.netId === partyOwner ? (
          <Tooltip
            label='Remove Member'
            textTransform='capitalize'
            maxW='32'
            bg='grey.800'
            fontSize='xs'
            textAlign='center'
            placement='right'
            color='white'
          >
            <IconButton
              aria-label='kick-member'
              icon={<CloseIcon />}
              size='xs'
              variant={"ghost"}
              rounded='full'
            />
          </Tooltip>
        ) : null
      }
    >
      {!data && member.characterId}
      {data && `${data.firstName} ${data.lastName}`}
    </MenuItem>
  );
};

export default PartyMember;
