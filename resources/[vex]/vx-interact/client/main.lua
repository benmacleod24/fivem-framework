IsPeaking, IsPeakActive, UpdateRequired = false, false, false
CurrentZones, CurrentTarget = {}, false
ListCount = 0
EntryCallbacks = {}
peakEntries = {
    ['model'] = {},
    ['entity'] = {},
    ['polyzone'] = {}
}

--[[
    type: peakEntries
    group: model number, entity type
    data: id, event, label, ...
    options: isEnabled,...
]]
function AddPeakEntry(type, group, data, options)
    local entries = peakEntries[type]
    if (not entries) then return print('peak group doesnt exist') end

    local addEntry = function(groupId, data, options)
        GroupEntries = entries[groupId]

        -- Add group id if not exist
        if (not GroupEntries) then
            entries[groupId] = {}
            GroupEntries = entries[groupId]
        end

        -- Require ID and add to entry data
        if (not data.id) then return print('Missing ID for data') end
         GroupEntries[data.id] = {
             data = data,
             options = options
         }
    end

    addEntry(group, data, options)
end

function GetCurrentPeakEntryList()
    local context = GetEntityContext(CurrentTarget)
    context.zones = CurrentZones or {}

    ListCount = ListCount + 1
    local listId, entries = ListCount, {}
    
    -- Verify peak entry data and is enabled
    local VerifyPeakEntry = function (id, entry)
        options, data = entry.options, entry.data

        

        -- Verify if enabled
        if (not options.isEnabled(context, data)) then return end

        -- Allows for callbacks instead of events
        if (options.cb) then
            EntryCallbacks[data.id] = options.cb
        end

        data.model = context.model
        data .type = context.type
        data.flags = context.flags
        data.entity = CurrentTarget

        table.insert(entries, data)
    end

    if (CurrentTarget) then
        if (peakEntries['model'][context.model]) then
            for k,v in pairs(peakEntries['model'][context.model]) do
                VerifyPeakEntry(k, v)
            end
        end
    
        if (peakEntries['entity'][context.type]) then
            for k,v in pairs(peakEntries['entity'][context.type]) do
                VerifyPeakEntry(k, v)
            end
        end
    
        for zoneName, zoneData in pairs(CurrentZones) do
            if (zoneData) then
                if (peakEntries['polyzone'][zoneName]) then
                    for _, v in pairs(peakEntries['polyzone'][zoneName]) do
                        VerifyPeakEntry(k, v)
                    end
                end
            end
        end
    end

    StartTrackerThread(listId, entries,  context)
    return entries, context
end

function StartTrackerThread(listId, entries, context)
    local entity = CurrentTarget
    local Player = PlayerPedId()

    local bones, normal, zones = {}, {}, {}
    local updateRequired = true

    Citizen.CreateThread(function()
        while IsPeaking and ListCount == listId do

            if (updateRequired) then
                updateRequired = false
                -- print(json.encode(entries))
                UpdatePeekEntryList(entries)
            end

            Citizen.Wait(150)
        end
    end)
end

function UpdatePeekEntryList(entries)
   if (not IsPeakActive and #entries >= 1) then
        IsPeakActive = true
   elseif (IsPeakActive and #entries <= 0) then
        IsPeakActive = false
   end

   exports['vx-nui']:DispatchNui('target:entries:set', entries)
end

function StartPeaking()
    if (IsPeaking or exports['vx-nui']:GetOpenApplication() ~= '') then return end
    

    local entries, context

    IsPeaking = true
    UpdateRequired = true

    Citizen.CreateThread(function()
        while IsPeaking do
            DisablePlayerFiring(PlayerId(), true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 37, true)

            if (UpdateRequired) then
                UpdateRequired = false
                entries, context = GetCurrentPeakEntryList()
            end

            if (IsPeaking and IsPeakActive and IsDisabledControlJustReleased(0, 25)) then
                SetCursorLocation(0.5, 0.5)

                exports['vx-nui']:SetUIFocus(true, true)
            end

            Wait(0)
        end
    end)

    exports['vx-nui']:OpenApplication('target')
end

RegisterUiCallBack('/target/select', function(data, cb)
    StopPeaking()

    if (data.event) then
        TriggerEvent(data.event, data)
        TriggerServerEvent(data.event, data)
    end

    StopPeaking(true)
    cb({})

    -- Run last in case we are opening another NUI app
    if (EntryCallbacks[data.id]) then
        EntryCallbacks[data.id](data, GetEntityContext(CurrentTarget))
    end
end)

function StopPeaking(bypassFocus)
    if (not bypassFocus and exports['vx-nui']:IsUiFocused()) then return end
    if (exports['vx-nui']:GetOpenApplication() ~= "target") then return end

    IsPeaking = false
    IsPeakActive = false
    UpdateRequired = false
    exports['vx-nui']:CloseApplication()

end

RegisterUiCallBack('target/close', function(data, cb)
    StopPeaking(true)
    cb({})
end)

--#region
-- Event handlers
-- Zone & Target

AddEventHandler('vx-zones:enter', function (name, data, center)
    UpdateRequired = true
    CurrentZones[name] = {
        data = data,
        center = center
    }
end)

AddEventHandler('vx-zones:exit', function (name, data, center)
    UpdateRequired = true
    CurrentZones[name] = nil
end)

RegisterNetEvent("vx-target:changed", function(target, entityType, entityOffset)
    CurrentTarget = target
    UpdateRequired = true
end)

--#endregion


Citizen.CreateThread(function()
    RegisterCommand('+eye', StartPeaking)
    RegisterCommand('-eye', function() StopPeaking(false) end)
    exports["vx-keymapping"]:registerKeyMapping("Interact", "Use third eye", "+eye", "-eye", "LMENU")
end)

exports('isPeakActive', function() return isPeakActive end)