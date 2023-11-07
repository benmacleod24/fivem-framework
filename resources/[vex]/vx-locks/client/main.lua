DOOR_CACHE = {}
CurrentZone = nil
CurrentDoor = {
    position = vector3(0, 0, 0),
    id = nil,
    lockState = false,
    notifyId = nil,
    watching = false
}

-- Returns the registed door with the specific entity handler
-- If one is not found returns nil
function GetDoorFromEntity(entity)
    local registeredDoors = DoorSystemGetActive()

    for _, registeredDoor in pairs(registeredDoors) do
        if (registeredDoor[2] and registeredDoor[2] == entity) then
            return registeredDoor[1]
        end
    end
end

function GetDoorByZone(zone)
    for k,v in pairs(DOOR_CACHE) do
        if (v.zone and v.zone == zone) then
            return k
        end
    end
end

function AttachLoopToDoor()
    CurrentDoor.watching = true

    -- Don't want  this loop to run if it's a keyfob door
    if (DOOR_CACHE[CurrentDoor.id].zone) then return end 

    local function GetDoorDistance()
        rtn = 1.2
        
        if (not DOOR_CACHE or not DOOR_CACHE[CurrentDoor.id] or not DOOR_CACHE[CurrentDoor.id].automatic or not DOOR_CACHE[CurrentDoor.id].automatic.distance ) then
            return rtn
        end

        rtn = DOOR_CACHE[CurrentDoor.id].automatic.distance
        return rtn
    end

    function LoadAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do
            RequestAnimDict(dict)
            Wait(0)
        end
    end

    function TaskAnimTimedNoCancel(animDict, animName, typeAnim, speed, duration)
        if (DoesEntityExist(PlayerPedId())) then
            LoadAnimDict(animDict)
            TaskPlayAnim(PlayerPedId(), animDict, animName, speed, 2.0, duration, typeAnim, 0, 0, 0, 0)
            RemoveAnimDict(animDict)
        end
    end

    Citizen.CreateThread(function ()
        local newLockState = nil

        while (CurrentDoor.watching) do
            local idle = 15
        
            if (CurrentDoor.lockState ~= newLockState) then

                if (#(GetOffsetFromEntityGivenWorldCoords(PlayerPedId(), CurrentDoor.position)) <= GetDoorDistance()) then
                    newLockState = CurrentDoor.lockState
    
                    if (CurrentDoor.notifyId) then
                        exports['vx-context']:UpdateNotification(CurrentDoor.notifyId, {
                            label = string.format("[Interact] %s", (newLockState and "Locked" or "Unlocked")), 
                            isStatic = true, 
                            color = newLockState and "red.400" or "green.400"
                        })
                    else 
                       local id = exports['vx-context']:SendNotification({
                            label = string.format("[Interact] %s", (CurrentDoor.lockState and "Locked" or "Unlocked")), 
                            isStatic = true, 
                            color = CurrentDoor.lockState and "red.400" or "green.400"
                        })

                        CurrentDoor.notifyId = id
                    end

                else
                    idle =  40
                end
            end

            -- Route through server to auth the door unlock
            if (exports['vx-keymapping']:Interact()) then
                TaskAnimTimedNoCancel("anim@heists@keycard@", "exit", 16, 8.0, 500)
                TriggerServerEvent("vx-locks:door:toggle", CurrentDoor.id, not CurrentDoor.lockState)
            end
    
            Citizen.Wait(idle)
        end

        if (CurrentDoor.notifyId) then
            exports['vx-context']:RemoveNotification(CurrentDoor.notifyId)
        end
    end)
end

-- We want to initalize the door cache so we don't have to RPC every door
RegisterNetEvent("vx-locks:cache:initalize", function(doorsFromServer)
    DOOR_CACHE = doorsFromServer

    -- Add Door to fivems door system
    -- Door system is a built in set of natives
    for doorId, door in pairs(DOOR_CACHE) do
        
        -- If the door isn't disabled and not regiserted add to system
        if (not door.isDisabled and not IsDoorRegisteredWithSystem(doorId)) then 
            
            -- Add Door to system
            AddDoorToSystem(doorId, door.model, door.position, false, false, false)

            -- Set values for auto matic door distance and rate
            if (door.automatic) then
                DoorSystemSetAutomaticDistance(doorId, door.automatic.distance)
                DoorSystemSetAutomaticRate(doorId, door.automatic.rate)
            end

            DoorSystemSetDoorState(doorId, door.isLocked, 0, 1)
        end

    end

end)

RegisterNetEvent("vx-locks:cache:refresh-door", function(doorId, newDoor)
    if (not doorId or not newDoor) then return end

    DOOR_CACHE[doorId] = newDoor
    DoorSystemSetAutomaticRate(doorId, 1.0, 0, 0)
    DoorSystemSetDoorState(doorId, newDoor.isLocked, 0, 1)

    if (CurrentDoor.id == doorId) then
        CurrentDoor.lockState = newDoor.isLocked
    end
end)

RegisterNetEvent("vx-locks:keyfob", function()
    if (not CurrentZone) then return end
    TriggerServerEvent("vx-locks:keyfob:auth", CurrentZone, not DOOR_CACHE[GetDoorByZone(CurrentZone)].isLocked)
end)

RegisterNetEvent('vx-target:changed', function(entity, position, type)

    -- If entity doesn't meet existing requirements
    -- Return CurrentDoor var to default
    if (entity == nil or type ~= 3) then

        if (CurrentDoor.notifyId) then
            exports['vx-context']:RemoveNotification(CurrentDoor.notifyId)
        end

        CurrentDoor = {
            position = vector3(0, 0, 0),
            id = nil,
            lockState = false,
            notifyId = nil,
            watching = false
        }

        return
    end

    local door = GetDoorFromEntity(entity)
    if (not door) then return end

    CurrentDoor.id = door
    CurrentDoor.position = position
    CurrentDoor.lockState = (DoorSystemGetDoorState(door) ~= 0 and true or false)

    if (not CurrentDoor.watching) then
        AttachLoopToDoor()
    end
end)

-- Zone Handling
AddEventHandler('vx-zones:enter', function(name, data)
    if (not data and not data.isDoor) then return end
    CurrentZone = name
end)

AddEventHandler('vx-zones:exit', function(name, data)

    -- Auto lock the keyfob doors when they leave the zone, just in case
    -- Should still  test
    if (data and data.isDoor and not DOOR_CACHE[GetDoorByZone(name)].isLocked) then
        TriggerServerEvent("vx-locks:keyfob:auth", name, true)
    end

    CurrentZone = nil
end)

Citizen.CreateThread(function()

    exports['vx-zones']:AddBoxZone("mrpd_bollard_01", vector3(415.2, -1020.12, 29.23), 5.2, 21.0, {
        name="mrpd_bullard_01",
        heading=0,
        minZ=27.83,
        maxZ=34.23,
        data = {
            isDoor = true
        }
    })

    exports['vx-zones']:AddBoxZone("mrpd_bottom_garage_left", vector3(431.19, -1003.5, 28.78), 19.6, 5.4, {
        name="mrpd_bottom_garage_left",
        heading=0,
        --debugPoly=true,
        minZ=24.58,
        maxZ=30.78,
        data = {
            isDoor = true
        }
      })

    TriggerServerEvent("vx-locks:cache:initalize:__s__")
end)

RegisterCommand("k", function()
    TriggerEvent("vx-locks:keyfob")
end)