-- Revive Character
-- Connect to Global revive function in lib
RegisterUiCallBack('dev/characters/revive', function(data, cb)
    print(json.encode(data))
    NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), true, true, false)
    
    cb(characters)
end)



-- Spawn Vehicle from Dev Menu
RegisterUiCallBack('dev/spawn/vehicle', function(data, cb)
    local vehicle = data
    local coords = GetEntityCoords(PlayerPedId())
    
    exports['vx-lib']:CreateClientVehicle(vehicle, {
        x = coords.x,
        y = coords.y,
        z = coords.z,
    }, GetEntityHeading(PlayerPedId()), {
        placeInVehicle = true
    })

    cb({})

    exports['vx-nui']:CloseApplication()
end)

-- Dev Set the weather
RegisterUiCallBack('dev/weather/set', function(data, cb)
    TriggerServerEvent('sync:weather:set', data)

    cb({})
end)