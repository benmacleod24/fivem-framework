function GetMyCoords(netId)
    local player = GetPlayerPed(netId)
    local coords = GetEntityCoords(player)
    return coords
end

RegisterCommand("xyz", function(netId, args)
    local coords = GetMyCoords(netId)
    local heading = GetEntityHeading(GetPlayerPed(netId))
    local printTbl = "{ x = "..coords.x..", y = "..coords.y..", z = "..coords.z..", h = "..heading.." }"
    local printTblVector = "vector3("..coords.x..", "..coords.y..", "..coords.z.." )"
    print(printTbl)
    print(printTblVector)
end)