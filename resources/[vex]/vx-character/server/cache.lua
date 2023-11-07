CACHE = {}

RegisterNetEvent('vx-character:vitals:sync', function(type, value)
    local netId = source

    -- Create cache if not exist
    if (not CACHE[tostring(netId)]) then
        CACHE[tostring(netId)] = {}
    end

    -- Set Cache value of netId
    CACHE[tostring(netId)][type:upper()] = value
    TriggerClientEvent('vx-character:vitals:sync:__c__', netId, type:lower(), value)
end)

RegisterCommand('cache', function()
    print(json.encode(CACHE))
end)