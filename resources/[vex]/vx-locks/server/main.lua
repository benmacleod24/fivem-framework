RegisterNetEvent("vx-locks:cache:initalize:__s__", function()
    local netId = source
    TriggerClientEvent("vx-locks:cache:initalize", netId, Config.Doors)
end)

RegisterNetEvent("vx-locks:door:toggle", function(doorId, toggleValue)
    local netId = source
    local playerCurrentJob = exports['vx-jobs']:GetPlayersActiveJob(netId)

    -- Verify the player can actually open the door
    if (Config.Doors[doorId].auth) then
        if (not playerCurrentJob) then return end
        
        for k,v in pairs(Config.Doors[doorId].auth) do
            if (v == playerCurrentJob) then
                Config.Doors[doorId].isLocked = toggleValue
                TriggerClientEvent("vx-locks:cache:refresh-door", -1, doorId, Config.Doors[doorId])
            end
        end
    else
        Config.Doors[doorId].isLocked = toggleValue
        TriggerClientEvent("vx-locks:cache:refresh-door", -1, doorId, Config.Doors[doorId])
    end
end)

RegisterNetEvent("vx-locks:keyfob:auth", function(zoneName, lockState)
    local netId = source
    local doorId = Config.Funcs.GetDoorByZone(zoneName)

    if (not doorId) then return end

        -- Verify the player can actually open the door
        if (Config.Doors[doorId].auth) then
            if (not playerCurrentJob) then return end
            
            for k,v in pairs(Config.Doors[doorId].auth) do
                if (v == playerCurrentJob) then
                    Config.Doors[doorId].isLocked = lockState
                    TriggerClientEvent("vx-locks:cache:refresh-door", -1, doorId, Config.Doors[doorId])
                end
            end
        else
            Config.Doors[doorId].isLocked = lockState
            TriggerClientEvent("vx-locks:cache:refresh-door", -1, doorId, Config.Doors[doorId])
        end
end)

-- Simple Event to trigger dev tools print
RegisterNetEvent("vx-locks:dev_tools:print", function(data)
    print("_________Door Info__________")
    print("Position: "..data.position)
    print("Hash Key: "..data.hash)
    print("Model: "..data.model)
    print("___________________")
end)