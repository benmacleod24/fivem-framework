-- Toggles/Sets the state of entities tools
RegisterUiCallBack('dev/toggles/show-entities/toggle', function(data, cb)
    cb(ToggleShowEntities(not SHOW_ENTITIES))
end)

-- Toggles/Sets the state of coords tools
RegisterUiCallBack('dev/toggles/show-coords/toggle', function(data, cb)
    cb(ToggleShowCoords(not SHOW_COORDS))
end)

RegisterUiCallBack('dev/toggles/freeze-weather/toggle', function(data, cb)
    cb(TriggerServerEvent("sync:weather:freeze:toggle"))
end)