Citizen.CreateThread(function()

    RegisterCommand('+panel', function()
        exports['vx-nui']:OpenApplication('panel')
        exports['vx-nui']:SetUIFocus(true, true)
    end)
    RegisterCommand('-panel', function() end)
    exports['vx-keymapping']:registerKeyMapping("Global", "Panel", "+panel", '-panel', "F1")
end)

RegisterCommand('car', function(src, args)
    local coords = GetEntityCoords(PlayerPedId())
    exports['vx-lib']:CreateClientVehicle(args[1], {
        x = coords.x,
        y = coords.y,
        z = coords.z,
    }, GetEntityHeading(PlayerPedId()), {
        placeInVehicle = true
    })
end)