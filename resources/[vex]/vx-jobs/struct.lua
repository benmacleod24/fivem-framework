JOBS = {
    ['towing'] = {
        id = 1,
        name = "towing",
        pay = 13,
        is_party_enabled = true,
        is_private = false,
        max_member_limit = 4,
        parties = {
            {
                partyId = 1,
                partyName = "Towing Party #1",
                partyOwner = 45, -- netId
                isInviteOnly = true,
                partyMembers = {
                    {
                        netId = 1,
                        characterId = 1
                    }
                }
            }
        },
    },
    ['leo'] = {
        id = 2,
        name = "leo",
        pay = 25,
        is_party_enabled = false,
        is_private = true,
        employees = {
            {
                characterId = 1,
                jobId = 1,
                jobLevel = 5
            }
        },
    }
}