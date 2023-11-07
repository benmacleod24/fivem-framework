function GetConfig()
    local spawnableLocations = {}

    for k,v in pairs(LOCATIONS) do
        if (v.jobs) then
            for _, name in ipairs(v.jobs) do
                if (RPC.Execute('jobs:player:has_job', { name = name })) then
                    table.insert(spawnableLocations, LOCATIONS[k])
                end
            end
        else
            table.insert(spawnableLocations, LOCATIONS[k])
        end
    end

    return spawnableLocations
end

function GetLocationById(id)
    for k,v in pairs(LOCATIONS) do
        if (v.id == id) then
            return LOCATIONS[k]
        end
    end
end

function SpawnUser(locationId)
    local location = GetLocationById(locationId)
    local ped = PlayerPedId()

    -- Teardown NUI
    exports['vx-nui']:OpenApplication('')
    exports['vx-nui']:SetUIFocus(false, false)

    DoScreenFadeOut(300)
    Wait(300)
    exports['vx-base']:StopSelectCam()

    if (location and location.event) then
        TriggerServerEvent(location.event, location)
        TriggerEvent(location.event, location)
    else
        SetEntityCoords(ped, location.coords.x, location.coords.y, location.coords.z)
    end

    
    
    -- Restore Player Ped State
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true)
    FreezeEntityPosition(ped, false)

    -- Will be added back too lazy to deal with heading.
    -- SetEntityHeading(ped, location.coords.h)

    Wait(300)
    DoScreenFadeIn(300)
end

RegisterUiCallBack("spawn/locations", function(_, cb)
    cb(GetConfig())
end)

RegisterUiCallBack("spawn/select", function(data, cb)
    SpawnUser(data.spawnId)
    cb({})
end)

exports('GetConfig', GetConfig)
exports('SpawnUser', SpawnUser)