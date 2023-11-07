
-- Get keys to vehicle by entity
-- Entity will normally be the vehicle entity ID
function GetKeysByEntity(entity)
    if (not entity or entity == 0) then return end

    local check = RPC.Execute("vx-vehicles:keys:check", entity)
    if (not check) then return false end

    return check
end

-- Give players keys to vehicle
-- The vehicle entity id is required to do so
function GivePlayerKeys(entity, to_player)
    if (not entity or entity == 0) then return end
    
    local success = RPC.Execute("vx-vehicles:keys:give", entity, to_player)
    if (success) then
        print("Successfully gave keys to vehicle.")
    end
end

-- Give keys to cloest player
-- Vehicle needs to be passed in to work
function GiveKeysToCloesetPlayer(vehicle)

    -- Just return if vehicle doesn't exist
    if (not vehicle or not DoesEntityExist(vehicle)) then return end

    -- Make sure they are close enough to the vehicle
    if (Vdist(GetEntityCoords(vehicle), GetEntityCoords(PlayerPedId())) > 5) then
        return
    end

    -- Make sure they have keys
    -- If not notify the player
    if (not GetKeysByEntity(vehicle)) then
        return exports['vx-context']:SendNotification({ label = "You Don't have keys", color = "orange.400", timeout = 3.5 })
    end

    local closest_player, distance_between = exports['vx-lib']:GetClosestPlayer()
    local my_net_id = GetPlayerServerId(PlayerPedId())

    -- Make sure their is a close player
    if (not cloest_player or closest_player == -1 or distance_between >= 5 or my_net_id ~= closest_player) then
        return exports['vx-context']:SendNotification({ label = "Ain't Got No Friends.", color = "orange.400", timeout = 3.5 })
    end

    GivePlayerKeys(vehicle, closest_player)

end

-- Called when a player enters a vehicle
-- Root of vehicle management
AddEventHandler("baseevents:enteredVehicle", function(vehicle, seat)
    if (not vehicle) then return end

    -- Don't need to do anything if they aren't driving
    local is_driver = seat == -1
    if (not is_driver) then return end

    local has_keys = GetKeysByEntity(vehicle)

    -- Run Logic for not having keys
    if (not has_keys) then
        SetVehicleEngineState(vehicle, false)
        return
    end

    -- Run logic for having keys
    -- ::REMOVE:: later once toggling on and off is in
    SetVehicleEngineState(vehicle, true)
end)

RegisterCommand("givekeys", function(net_id)
    GivePlayerKeys(GetVehiclePedIsIn(PlayerPedId(), false))
end)

RegisterCommand("von", function(net_id)
    if (GetKeysByEntity(GetVehiclePedIsIn(PlayerPedId()))) then
        SetVehicleEngineState(GetVehiclePedIsIn(PlayerPedId()), true)
    end
end)