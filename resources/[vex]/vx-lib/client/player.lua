
-- Return player position in table structure
function GetPlayerPositionTable()
    local playerCoordinates = GetEntityCoords(PlayerPedId())
    local playerHeading = GetEntityHeading(PlayerPedId())

    local position = {
        x = playerCoordinates.x,
        y = playerCoordinates.y,
        z = playerCoordinates.z,
        h = playerHeading
    }

    return position
end

-- Get Closest/Close
function GetClosestPlayer()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPlayerServerId = -1
   local playerId = PlayerPedId()
    local playerCoords = GetEntityCoords(playerId, 0)
    
    for _, value in ipairs(GetActivePlayers()) do
        local nextPlayer = GetPlayerPed(value)

        if (nextPlayer ~= playerId) then
            local nextPlayerCoords = GetEntityCoords(nextPlayer, 0)
            local distance = Vdist(nextPlayerCoords, playerCoords)

            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayerId = value
                closestDistance = distance
                closestPlayerServerId = GetPlayerServerId(value)
            end
        end
    end
    return closestPlayerServerId, distance
end

exports('GetPlayerPositionTable', GetPlayerPositionTable)
exports('GetClosestPlayer', GetClosestPlayer)