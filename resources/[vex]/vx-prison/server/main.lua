-- sentence lenght must be in minuites
-- netId is the netId of the player being jailed
function SendPlayerToPrison(netId, sentenceLenght)

    -- Verify netId is there
    if (not netId) then return false end

    -- Get & Verify Character ID
    local character_id = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId
    if (not character_id) then return false end

    sentenceLenght = tonumber(sentenceLenght) or 1

    local query = [[ INSERT INTO fivem_prisoners (character_id, sentence_length) VALUES(?, ?) ]]
    local res = exports.oxmysql:insertSync(query, {character_id, sentenceLenght})

    TriggerClientEvent("prison:sent", netId, res)
    return true, res
end

-- Should probobly morph IsPlayerInPrison and this into same func
function GetPrisonerTimeLeft(netId)

    -- Get & Verify Character ID
    local character_id = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId
    if (not character_id) then return end

    -- Fetch prisoner information from database
    local query = [[SELECT * FROM fivem_prisoners WHERE character_id = ?]]
    local res = exports.oxmysql:singleSync(query, {character_id})

    if (not res) then return end

    return res.sentence_length - exports['vx-lib']:GetTimeDifferenceInMinutes(os.time(), res.jailedAt)
end

-- Determine if player is still in jail
-- Data gathered from netId of player in question
function IsPlayerInPrison(netId)

    -- Get & Verify Character ID
    local character_id = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId
    if (not character_id) then return end

    -- Fetch prisoner information from database
    local query = [[SELECT * FROM fivem_prisoners WHERE character_id = ?]]
    local res = exports.oxmysql:singleSync(query, {character_id})

    if (not res) then return end

    return exports['vx-lib']:GetTimeDifferenceInMinutes(os.time(), res.jailedAt) <= res.sentence_length
end


RPC.Register("prison:isPlayerInPrison", function(netId)
    return IsPlayerInPrison(netId)
end)

RPC.Register("prison:timeLeftInPrison", function(netId)
    return GetPrisonerTimeLeft(netId)
end)

RegisterNetEvent("prison:character:drop", function()
    local netId = source
    exports['vx-base']:DropCharacter(netId)
end)

exports('SendPlayerToPrison', SendPlayerToPrison)
exports('IsPlayerInPrison', IsPlayerInPrison)