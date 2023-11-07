Console = exports['vx-lib']:Console() or {}

-- Active players table, players are stored against their netId (string).
PLAYERS = {}

AddEventHandler("playerJoining", function (oldId)
    local netId = source
    local identities = exports['vx-lib']:GetIdentifier(netId, { "discord", "license" })

    local newPlayer = {
        discord = identities[discord],
        license = identities[license],
        playerId = GetPlayerInfo(netId).id,
        netId = netId,
    }

    PLAYERS[tostring(netId)] = newPlayer
    Console:Log("Adding ["..GetPlayerInfo(netId).id.."] to players table.")
end)

function GetActivePlayer(netId)
    if (not netId) then return USERS end
    return USERS[tostring(netId)]
end

-- Remove player after disconnect
AddEventHandler("playerDropped", function()
    local netId = tostring(source)
    PLAYERS[netId] = nil
    Console:Log("Removing ["..GetPlayerInfo(netId).id.."] from players table.")
end)

exports('GetActivePlayer', GetActivePlayer)