GLOBAL_ZONE = nil

function CreateComboZone(zone)
    if (GLOBAL_ZONE ~= nil) then
        GLOBAL_ZONE:AddZone(zone)
        return
    end

    GLOBAL_ZONE = ComboZone:Create({ zone }, { name = 'vx-zones'})
    GLOBAL_ZONE:onPlayerInOutExhaustive(function(isPointInside, point, insideZone, enteredZones, leftZones)

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

-- Handle adding an event to the zone
function CreateZoneEvent(eventName, zoneName)
    if (GLOBAL_ZONE.events and GLOBAL_ZONE.events[eventName] ~= nil) then    
        return
    end

    GLOBAL_ZONE:addEvent(eventName, zoneName)
end

-- Wrapper for loop of multi-events
function AddZoneEvents(name, events)
    if (events == nil) then return end

    for _, v in ipairs(events) do
        CreateZoneEvent(v, name)
    end
end

-- Exports
exports('AddBoxZone', function(name, vectors, lenght, width, options)
    if (not options) then options = {} end
    options.name = name

    boxCenter = type(vectors) ~= 'vector3' and vector3(vectors.x, vectors.y, vectors.z) or vectors
    zone = BoxZone:Create(boxCenter, lenght, width, options)

    CreateComboZone(zone)
    AddZoneEvents(zone, options.zoneEvents)
end)

exports('AddCircleZone', function(name, center, radius, options)
    if (not options) then options = {} end
    options.name = name

    circleCenter = type(vectors) ~= 'vector3' and vector3(center.x, center.y, center.z) or center
    zone = CircleZone:Create(circleCenter, radius, options)

    CreateComboZone(zone)
    AddZoneEvents(zone, options.zoneEvents)
end)

exports('AddPolyZone', function(name, vectors, options)
    if (not options) then options = {} end
    options.name = name

    zone = PolyZone:Create(vectors, options)

    CreateComboZone(zone)
    AddZoneEvents(zone, options.zoneEvents)
end)