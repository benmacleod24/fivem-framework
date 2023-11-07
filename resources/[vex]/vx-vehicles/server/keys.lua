ACTIVE_KEYS = {}

--[[
    :: ACTIVE_KEYS TABLE STRUCT::
    "net_id" = {
        "entity_id" = {
            entity_id = number,
            net_id = number,
            given_at = os.date(),
        }
    }
]]

-- Gives keys to vehicle
-- entity is the vehicles entity id
function GiveKeysToVehicle(net_id, entity)
    if (not net_id) then return end
    if (not entity) then return end

    net_id_keys = ACTIVE_KEYS[tostring(net_id)]
    
    -- If the net_id doesn't have any keys yet, initalize it.
    if (not net_id_keys) then
        ACTIVE_KEYS[tostring(net_id)] = {}
    end

    ACTIVE_KEYS[tostring(net_id)][entity] = {
        entity_id = entity,
        net_id = net_id,
        given_at = os.date()
    }

    TriggerClientEvent("vx-context:notification", net_id, {
        label = "Recived Keys!",
        color = 'green.400',
        timeout = 3.5
    })

    return true, net_id_keys[entity]
end

-- Check if net_id has keys to vehicle
-- Entity is the vehicle entity id
function HasKeysToVehicle(net_id, entity)
    if (not net_id) then return false end
    if (not entity) then return false end

    net_id_keys = ACTIVE_KEYS[tostring(net_id)]
    if (not net_id_keys) then return false end

    vehicle_key = net_id_keys[entity]
    if (not vehicle_key) then return false end

    return vehicle_key
end

RPC.Register("vx-vehicles:keys:give", function(net_id, vehicle, to_player)
    local give_keys_to = net_id

    if (to_player) then
        give_keys_to = to_player
    end

    return GiveKeysToVehicle(give_keys_to, vehicle)
end)

RPC.Register("vx-vehicles:keys:check", function(net_id, vehicle)
    return HasKeysToVehicle(net_id, vehicle)
end)

RPC.Register("vx-vehicles:keys", function()
    return ACTIVE_KEYS
end)