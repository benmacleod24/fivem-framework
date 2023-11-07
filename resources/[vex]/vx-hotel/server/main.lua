-- { x = 266.37362670898, y = -642.50109863281, z = -37.664428710938, h = 76.535430908203 }
HOTELS = {}

-- Generate New hotel (Key is netId)
-- no need to set certain amount of hotels, everyone gets one
function GenerateNewHotel(netId)
    if (not netId) then return end
    if (HOTELS[tostring(netId)]) then return end

    local hotelId = #HOTELS + 1
    local characterId = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId
    newHotel = {
        id = hotelId,
        netId = netId,
        characterId = characterId,
        locked = true
    }

    HOTELS[tostring(netId)] = newHotel
    return HOTELS[tostring(netId)]
end

-- Simply grabs their hotel
function GetPlayersHotel(netId)
    if (not HOTELS[tostring(netId)]) then return false end
    return HOTELS[tostring(netId)]
end

-- Want to listen for character select and assign hotel
-- Does not build interior simply places them in a tale
RegisterNetEvent('base:character:selected', function (character)
    if (not character) then return end
    GenerateNewHotel(character.netId)
end)

RegisterNetEvent("base:character:dropped", function(netId)
    HOTELS[tostring(netId)] = nil
end)

-- RPCS
RPC.Register("hotel:get", function(netId)
    return GetPlayersHotel(netId)
end)

RPC.Register("hotel:character:drop", function(netId)
    return exports['vx-base']:DropCharacter(netId)
end)

RPC.Register("hotels:table", function()
    return HOTELS
end)