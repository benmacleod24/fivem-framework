-- Creates a new job party
-- Add in check against job max_party_limit
function CreateJobParty(netId, jobName, opts)
    if (not JOBS[jobName]) then return false end

    local newPartyId = #JOBS[jobName].parties + 1
    local newParty = {
        partyId = newPartyId,
        partyName = opts.name or JOBS[jobName].display_name.." Party #"..newPartyId,
        partyOwner = netId,
        isInviteOnly = opts.isInviteOnly,
        partyData = {},
        partyMembers = {
            {
                netId = netId,
                characterId = exports['vx-base']:GetPlayerActiveCharacter(netId).netId
            }
        }
    }


    -- Stored against the partyId
    -- Maybe do an array (prob not)
    JOBS[jobName].parties[tostring(newPartyId)] = newParty
    exports['vx-lib']:addLog(netId, "create", "Player with netId "..netId.." created a job party for job "..jobName, {
        job = jobName,
        isInviteOnly = newParty.isInviteOnly,
        partyName = newParty.partyName
    })
end

-- Disbands a party
-- Broken out for clean up reasons
function DisbandParty(jobName, partyId)
    if (not JOBS[jobName]) then return false end
    if (not JOBS[jobName].parties[tostring(partyId)]) then return false end

    JOBS[jobName].parties[tostring(partyId)] = nil
end

-- Allows a character to join a party
-- Checks against the jos max party member limit
function JoinParty(netId, jobName, partyId)
    if (not JOBS[jobName]) then return false end
    if (not JOBS[jobName].parties[tostring(partyId)]) then return false end
    if (JOBS[jobName].parties[tostring(partyId)].isInviteOnly) then return false end

    if (#JOBS[jobName].parties[tostring(partyId)].partyMembers >= JOBS[jobName].max_member_limit) then
        return false
    end

    for k,v in pairs(JOBS[jobName].parties[tostring(partyId)].partyMembers) do
        if (v.netId == netId) then
            return false
        end
    end

    table.insert(JOBS[jobName].parties[tostring(partyId)].partyMembers, {netId = netId, characterId = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId})
    exports['vx-lib']:addLog(netId, "join", "Player with netId "..netId.." join a job party for job "..jobName, {
        job = jobName,
        partyId = partyId
    })
end

-- Allows a player to leave the party they are in
-- Also manages the party owner if that is the player who leaves
-- Disbands party if last member leaves
function LeaveParty(netId, jobName, partyId)
    if (not JOBS[jobName]) then return false end
    if (not JOBS[jobName].parties[tostring(partyId)]) then return false end
    if (JOBS[jobName].parties[tostring(partyId)].isInviteOnly) then return false end

    if (#JOBS[jobName].parties[tostring(partyId)].partyMembers >= JOBS[jobName].max_member_limit) then
        return false
    end

    for k,v in pairs(JOBS[jobName].parties[tostring(partyId)].partyMembers) do
        if (v.netId == netId) then
            table.remove(JOBS[jobName].parties[tostring(partyId)].partyMembers, k)

            exports['vx-lib']:addLog(netId, "leave", "Player with netId "..netId.." left a job party for job "..jobName, {
                job = jobName,
                partyId = partyId
            })
            
            -- Disband party if no more memebers are left
            if (#JOBS[jobName].parties[tostring(partyId)].partyMembers <= 0) then
                return DisbandParty(jobName, partyId)
            end

            -- If party owner leaves, make next person party owner
            if (JOBS[jobName].parties[tostring(partyId)].partyOwner == v.netId) then
                JOBS[jobName].parties[tostring(partyId)].partyOwner = JOBS[jobName].parties[tostring(partyId)].partyMembers[1].netId

                exports['vx-lib']:addLog(netId, "leave", "Player with netId "..netId.." became owner of a job party for job "..jobName, {
                    job = jobName,
                    partyId = partyId
                })
            end
        end
    end
end

RegisterCommand("newparty", function(src, args)
    CreateJobParty(src, args[1], {isInviteOnly = false})
end)

RegisterCommand("joinparty", function(src, args)
    JoinParty(src, args[1], args[2])
end)

RegisterCommand("leaveparty", function(src, args)
    LeaveParty(src, args[1], args[2])
end)

RegisterCommand("disbandparty", function(src, args)
    DisbandParty(args[1], args[2])
end)

RegisterCommand("jparties", function(src, args)
    print(json.encode(GetPlayersJobParty(src)))
end)

-- Gets players active party
function GetPlayersJobParty(netId)
    for k,v in pairs(JOBS) do

        -- Determine if party or not
        if (v.is_party_enabled) then

            -- This is very ugly
            -- Search all parties
            for pk, pv in pairs(v.parties) do
                if (pv.partyMembers) then

                    -- Search through each party and it's members
                    for km, vm in pairs(pv.partyMembers) do
                        if (vm.netId == netId) then
                            return pv,v.name
                        end
                    end
                end
            end

        end
    end

    return false
end

-- Manipulates the party data
function UpdatePartyData(jobName, partyId, data)
    local job = JOBS[jobName]
    local party = job.parties[tostring(partyId)]
    if (not job or not party) then return false end
    party.partyData = data
    return party.partyData
end

-- RPCs for server-side functions
RPC.Register("jobs:party:getPlayers", function(netId, data)
    return GetPlayersJobParty(netId)
end)

RPC.Register("jobs:party:getData", function(netId, data)
    local party = GetPlayersJobParty(netId)
    if (not party) then return false end
    return party.partyData
end)

RPC.Register("jobs:party:updateData", function(netId, data)
    local party, job = GetPlayersJobParty(netId)
    if (not party) then return false end
    return UpdatePartyData(job, party.partyId, data)
end)

RPC.Register("job:party:new", function(netId, data)
    local jobName = data.jobName
    return CreateJobParty(netId, jobName, data.opts)
end)