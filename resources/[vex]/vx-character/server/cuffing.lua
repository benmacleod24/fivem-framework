CUFFED_PLAYERS = {}

-- Root endpoint to authenticate cuffing a player
RPC.Register("character:cuff", function(netId, targetNetId)
    local cuffType = "PLAYER"

    print(netId, targetNetId)

    -- Need to make sure the netId are present
    if (not netId or not targetNetId) then
         return false
    end

    -- We want to set the type for uncuffing auth
    -- Will be other cuff types in future
    if (exports['vx-jobs']:GetPlayersActiveJob(netId) == "leo") then
        cuffType = "LEO"
    end

    -- Store players cuffed info against their netId
    -- Have the value of this key be the cuff type (cop, player, etc..)
    CUFFED_PLAYERS[tostring(targetNetId)] = cuffType

    -- Letting the client know they have been cuffed and who cuffed them
    TriggerClientEvent("character:cuffed", targetNetId, netId, targetNetId)

    return true
end)