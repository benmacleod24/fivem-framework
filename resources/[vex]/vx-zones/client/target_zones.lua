GLOBAL_TARGET_ZONE = nil
debug = true

function CreateComboZone(zone)
    if (GLOBAL_TARGET_ZONE ~= nil) then
        GLOBAL_TARGET_ZONE:AddZone(zone)
        return
    end

    GLOBAL_TARGET_ZONE = ComboZone:Create({ zone }, { name = 'vx-target-zones'})
    GLOBAL_TARGET_ZONE:onPlayerInOutExhaustive(function(isPointInside, point, insideZone, enteredZones, leftZones)

        if (leftZones ~= nil) then
            for i = 1, #leftZones do
                TriggerEvent('vx-zones:exit', leftZones[i].name, leftZones[i].data)
            end
        end

        if (enteredZones ~= nil) then
            for i = 1, #enteredZones do
                TriggerEvent('vx-zones:enter', enteredZones[i].name, enteredZones[i].data, enteredZones[i].center)
            end
        end

    end, 500)

end

-- Exports
exports('AddBoxTargetZone', function(name, vectors, lenght, width, options)
    if (not options) then options = {} end
    options.name = name

    boxCenter = type(vectors) ~= 'vector3' and vector3(vectors.x, vectors.y, vectors.z) or vectors
    zone = BoxZone:Create(boxCenter, lenght, width, options)

    CreateComboZone(zone)
    AddZoneEvents(zone, options.zoneEvents)
end)

exports('AddCircleTargetZone', function(name, center, radius, options)
    if (not options) then options = {} end
    options.name = name

    circleCenter = type(vectors) ~= 'vector3' and vector3(center.x, center.y, center.z) or center
    zone = CircleZone:Create(circleCenter, radius, options)

    CreateComboZone(zone)
    AddZoneEvents(zone, options.zoneEvents)
end)

exports('AddPolyTargetZone', function(name, vectors, options)
    if (not options) then options = {} end
    options.name = name

    zone = PolyZone:Create(vectors, options)

    CreateComboZone(zone)
    AddZoneEvents(zone, options.zoneEvents)
end)

function GetTargetCoords()
    local entity, coords = exports['vx-target']:GetEntityPlayerIsLookingAt(3.0, 0.2, nil)
    TargetCoords = coords

    if debug and hit ~= 0 then
        DrawMarker(28, TargetCoords.x, TargetCoords.y, TargetCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.01, 0.01, 0.01, 255, 0, 0, 255, false, false, 2, nil, nil, false)
    end

    return TargetCoords
end