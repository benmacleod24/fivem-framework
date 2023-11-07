INTERIORS = {}

-- Just for management sake
function PlayerEnteredInterior(netId, interiorId)
    -- They cannot be in more than one interior at a time
    if (not netId or not interiorId) then return false end
    if (not INTERIORS[interiorId]) then return false end

    INTERIORS[interiorId].playersInside[tostring(netId)] = netId
    return true
end

function PlayerExitedInterior(netId, interiorId)
    if (not netId or not interiorId) then return false end
    if (not INTERIORS[interiorId]) then return false end

    -- Want to make sure the server and client are on the same page
    local interiorPlayersIn = GetInteriorPlayersIn(netId)
    if (interiorId ~= interiorPlayersIn) then return false end

    local interior = INTERIORS[interiorPlayersIn]

    -- Remove player from interior
    interior.playersInside[tostring(netId)] = nil

    if (#interior.playersInside <= 0) then
        INTERIORS[interiorPlayersIn] = nil
    end

    return interior
end

-- Grabs what interior the player is in, if any
function GetInteriorPlayersIn(netId)

    -- Searches through the INTERIORS object
    for k,v in pairs(INTERIORS) do
        -- Searches through all the player inside and returns the interiorId
        for _, p in pairs(v.playersInside) do
            if (p == netId) then
                return k
            end
        end
    end

end

RPC.Register("interiors:enter", function(netId, data)
    return PlayerEnteredInterior(netId, data.interiorId)
end)

RPC.Register("interiors:exit", function(netId, data)
    return PlayerExitedInterior(netId, data.interiorId)
end)

RPC.Register("interiors:create", function(netId, data)

    local interiorId = #INTERIORS+1
    INTERIORS[interiorId] = {
        id = interiorId,
        creator = netId,
        entity_id = data.entity,
        position = data.position,
        createdAt = os.date(),
        playersInside = {}
    }

    return INTERIORS[interiorId]
end)

RPC.Register("interiors:table", function(netId)
    return INTERIORS
end)

RegisterNetEvent("base:character:dropped", function(netId)
    PlayerExitedInterior(netId, GetInteriorPlayersIn(netId))
end)

RegisterCommand("intc", function()
    print(json.encode(INTERIORS))
end)