-- Returns boolean
-- Entity (mainly vehicle)
-- CurrentZone is needed
function isEntityInParkingSpot(entity, CurrentZone)
    if (not CurrentZone) then return false end
    if (not PARKING_SPOTS[CurrentZone]) then return false end
    local playerPosition = GetEntityCoords(entity)

    -- Check if close to parking spots
    for _,coords in pairs(PARKING_SPOTS[CurrentZone]) do
        if (Vdist(playerPosition, coords) <= 1.0) then
            return true
        end
    end

    return false
end

-- ZoneData Required
-- Might break out into reuseable (Idk yet)
function hasSharedAccesss(jobs)
    if (not jobs) then return false end

    for _,v in ipairs(jobs) do
        if (RPC.Execute('jobs:player:active_job') == v) then
            return true
        end
    end

    return false
end

-- Bullds the layout of menu
-- defaultMenu allows for headers and a present tables
-- Adds vehicles to end of table
function VehicleMenuFactory(defaultMenu, vehicles)
    local menu = {}
    
    if (defaultMenu) then
        menu = defaultMenu
    end

    for k,v in pairs(vehicles) do
        table.insert(menu, {
            id = #menu + 1,
            title = v.vehicleName,
            description = "Plate: "..v.vehiclePlate,
            data = {
                event = "garage:spawn-vehicle",
                vehicleModel = v.vehicleModel,
                vehiclePlate = v.vehiclePlate,
                vehicleId = v.vehiclesId,
            }
        })
    end

    return menu
end

exports("isEntityInParkingSpot", isEntityInParkingSpot)
exports("hasSharedAccesss", hasSharedAccesss)