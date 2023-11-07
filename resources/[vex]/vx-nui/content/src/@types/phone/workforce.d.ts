interface Job {
  id: number;
  name: string;
  display_name: string;
  is_party_enabled: boolean;
  is_private: boolean;
  max_member_limit: number;
  parties: { [x: string]: JobParty };
}

interface JobParty {
  partyId: number;
  partyName: string;
  partyOwner: number;
  isInviteOnly: boolean;
  partyMembers: { netId: number; characterId: number }[];
}
