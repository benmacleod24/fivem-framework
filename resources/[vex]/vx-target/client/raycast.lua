function GetForwardVector(rotation)
    local rot = (math.pi / 180.0) * rotation
    return vector3(-math.sin(rot.z) * math.abs(math.cos(rot.x)), math.cos(rot.z) * math.abs(math.cos(rot.x)), math.sin(rot.x))
end

function PerformRaycast(origin, target, radius, flags)
    local rayHandle = StartShapeTestSweptSphere(origin.x, origin.y, origin.z, target.x, target.y, target.z, radius, flags == false or 286, PlayerPedId(), 0)
    local retval, hit, endCoords, surfaceNoraml, entityHit = GetShapeTestResult(rayHandle)

    return entityHit, endCoords, GetEntityType(entityHit)
end

-- Origin comes from head/eyes on ped
function GetEntityPlayerIsLookingAt(distance, radius, flags)
    distance = distance or 3.0

    local origin = GetPedBoneCoords(PlayerPedId(), 31086)
    local forwardVectors = GetForwardVector(GetGameplayCamRot(2))
    local forwardCoords = origin + (forwardVectors * distance)

    if (not forwardVectors) then return end

    local entity, coords, entType = PerformRaycast(origin, forwardCoords, radius or 0.2, flags)

    if (not entity) then return end
    return entity, coords, entType
end

Citizen.CreateThread(function()
    while true do
        local entity, coords, etype = GetEntityPlayerIsLookingAt()

        if entity and entityType ~= 0 then
            if entity ~= CurrentTarget then
                CurrentTarget = entity
                TriggerEvent('vx-target:changed', entity, coords, etype)
            end
        elseif CurrentTarget then
            CurrentTarget = nil
            TriggerEvent('vx-target:changed', entity)
        end

        Wait(250)
    end
end)


exports('PerformRaycast', PerformRaycast)
exports('GetEntityPlayerIsLookingAt', GetEntityPlayerIsLookingAt)