IsNearPDM = false
CurrentZone = nil


-- Decorators
DecorRegister('isPDM', 2)
DecorRegister('showroomPosition', 1)

function GenerateVehicles()
    local vehicles = RPC.Execute('vx-pdm:showroom:vehicles')
    for k,v in pairs(vehicles) do
        SpawnVehicleAtPosition(v, k)
    end
end

function SpawnVehicleAtPosition(vehicleModel, positionId)
    local coords = CONFIG.locations[positionId]
    local vehicle = exports['vx-lib']:CreateClientVehicle(vehicleModel, coords, coords.h)

    DecorSetBool(vehicle, 'isPDM', true)
    DecorSetInt(vehicle, 'showroomPosition', positionId)

    SetVehicleNumberPlateText(vehicle, "PDM "..math.random(100, 999))
    SetVehicleUndriveable(vehicle, true)
    SetVehicleDirtLevel(vehicle, 0.0)
end

RegisterCommand('pdmv', function()
    GenerateVehicles()
end)

-- Zone Handling
AddEventHandler('vx-zones:enter', function(name)
    CurrentZone = name
end)

AddEventHandler('vx-zones:exit', function(name)
    CurrentZone = nil
end)

Citizen.CreateThread(function()

    -- Zone Entries
    exports['vx-zones']:AddBoxZone("pdm_generate_zone", vector3(-63.75, -1100.06, 51.34), 100, 100, {
        name="pdm_generate_zone",
        heading=70,
        --debugPoly=true
    })

    exports['vx-zones']:AddBoxZone('pdm_main_zone', vector3(-42.41, -1094.81, 26.42), 24.2, 35.8, {
        name="pdm_main_zone",
        heading=338,
    })
end)