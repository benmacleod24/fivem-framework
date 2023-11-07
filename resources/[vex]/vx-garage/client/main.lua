CurrentZone, ZoneData, ZoneCenter = false, nil, nil

function OpenGarage()
    if (not CurrentZone) then return end
    if (not PARKING_SPOTS[CurrentZone]) then return end
    local playerPosition = GetEntityCoords(PlayerPedId())

    -- Check if close to parking spots
    for _,coords in pairs(PARKING_SPOTS[CurrentZone]) do
        if (Vdist(playerPosition, coords) <= 1.5) then
            
            -- Checking if garage is shared
            -- Will contain different checks than just jobs
            if (ZoneData and ZoneData.isShared) then

                -- Based off active job, not what they have
                if (ZoneData.jobs) then
                    for _,v in ipairs(ZoneData.jobs) do
                        if (RPC.Execute('jobs:player:active_job') == v) then
                            return OpenSharedGarageOptions()
                        end
                    end 
                end
            end

           return OpenPersonalGarage()
        end
    end
end

function OpenPersonalGarage()
    local menu = {{ id = 1, title = ZoneData.displayName }}
    garageVehicles = RPC.Execute("vx-garage:get:vehicles", {garageName = CurrentZone})

    -- Builds the correct menu displaying the correct vehicles
    menu = VehicleMenuFactory(menu, garageVehicles)
    exports['vx-context']:OpenContextMenu(menu)
end

-- Only opens the options for personal garage
-- personal cars, shared cars
function OpenSharedGarageOptions()
    local menu = {
        [1] = { id = 1, title = ZoneData.displayName },
        [2] = CONFIG.shared_options[1],
        [3] = CONFIG.shared_options[2],
    }

    exports['vx-context']:OpenContextMenu(menu)
end

-- Opens personal garage
RegisterNetEvent("garage:open:shared")
AddEventHandler("garage:open:shared", function()
    local menu = {[1] = CONFIG.shared_garage}
    garageVehicles = RPC.Execute("vx-garage:get:vehicles", {garageName = CurrentZone.."_shared"})

    -- Builds the correct menu displaying the correct vehicles
    menu = VehicleMenuFactory(menu, garageVehicles)
    exports['vx-context']:OpenContextMenu(menu)
end)

-- Opens personal from shared garage, different from OpenPersonalGarage func
RegisterNetEvent("garage:open:shared:personal")
AddEventHandler("garage:open:shared:personal", function()
    local menu = {[1] = CONFIG.shared_garage}
    garageVehicles = RPC.Execute("vx-garage:get:vehicles", {garageName = CurrentZone})

    -- Builds the correct menu displaying the correct vehicles
    menu = VehicleMenuFactory(menu, garageVehicles)
    exports['vx-context']:OpenContextMenu(menu)
end)

RegisterNetEvent("garage:open")
AddEventHandler("garage:open", OpenGarage)

-- -- Spawn Vehicle No Matter Garage Type
RegisterNetEvent('garage:spawn-vehicle')
AddEventHandler('garage:spawn-vehicle', function (data)
    local playerCoords = GetEntityCoords(PlayerPedId())

    -- Check for closest parking spot
    for k,v in pairs(PARKING_SPOTS[CurrentZone]) do

        -- Spawn Car in the parking spot
        if (Vdist(playerCoords, v) <= 1.5) then
            
            -- Return Server Side Car
            -- Need to handle setting vehicles settings on spawn
            exports["vx-lib"]:CreateServerVehicle(data.vehicleModel, v, {
                plate = data.vehiclePlate, 
                placeInVehicle = true,
                heading = 90.0
            })

        end
    end
end)

RegisterNetEvent("garage:store")
AddEventHandler("garage:store", function(data)
    if (not CurrentZone) then return end

    garageName = CurrentZone
    if (data.isShared) then
        garageName = garageName.."_shared"
    end

    print(garageName)
end)

-- Managing zones events
AddEventHandler('vx-zones:enter', function(name, data, center)
    CurrentZone = name
    ZoneData = data
    ZoneCenter = center
end)

AddEventHandler('vx-zones:exit', function(name, data)
    CurrentZone = false
    ZoneData = nil
    ZoneCenter = nil
end)

-- Initalize Zones
Citizen.CreateThread(function()
    exports['vx-zones']:AddBoxZone('mrpd_garage', vector3(435.79, -986.66, 25.7), 25.6, 26.4, {
        name="mrpd_garage",
        heading = 90,
        data = {
            jobs = { 'leo' },
            displayName = 'MRPD Garage',
            isShared = true
        }
    })

    exports['vx-interact']:AddPeekEntryByEntityType(2, {
        id = "garage:store:personal",
        label = "Store Vehicle (Personal)",
        icon = 'fa-solid fa-warehouse',
        event = "garage:store",
    }, {
        isEnabled = function(ctx) return CurrentZone and isEntityInParkingSpot(ctx.entity, CurrentZone) end
    })

    exports['vx-interact']:AddPeekEntryByEntityType(2, {
        id = "garage:store:shared",
        label = "Store Vehicle (Shared)",
        icon = 'fa-solid fa-warehouse',
        event = "garage:store",
        isShared = true
    }, {
        cb = function() print(CurrentZone) end,
        isEnabled = function(ctx)
            if (not CurrentZone) then
                return false
            else
                return CurrentZone and ZoneData.isShared and isEntityInParkingSpot(ctx.entity, CurrentZone) and hasSharedAccesss(ZoneData.jobs) or false
            end
        end
    })
end)

-- TESTING SHITS
RegisterCommand('garage', function()
    OpenGarage()
end)