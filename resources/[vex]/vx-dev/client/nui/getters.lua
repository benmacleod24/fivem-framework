-- Gather Coordinates
-- String Manipulation done in NUI
RegisterUiCallBack('dev/coords/get', function(data, cb)
    cb(exports['vx-lib']:GetPlayerPositionTable())
end)

-- Gets current state of dev entities tool
RegisterUiCallBack('dev/toggles/show-entities/get', function(data, cb)
    cb(SHOW_ENTITIES)
end)

-- Gets current state of dev coords tool
RegisterUiCallBack('dev/toggles/show-coords/get', function(data, cb)
    cb(SHOW_COORDS)
end)

-- Get frozen weather state
-- RegisterUiCallBack('dev/toggles/freeze-weather/get', function(data, cb)
--     cb(RPC.Execute("sync:weather:frozen"))
-- end)

RegisterUiCallBack("dev/kvp/characters", function(data, cb)
    local characters = RPC.Execute('vx-base:characters:active')
    local kvpTable = {}

    for k,v in pairs(characters) do
        table.insert(kvpTable, {label = "["..v.netId.."] "..v.firstName.." "..v.lastName, value = v.netId})
    end

    cb(kvpTable)
end)