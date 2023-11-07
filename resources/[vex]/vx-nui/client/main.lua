-- Globals
IS_FOCUSED = false
OPEN_APPLICATION = ""

function DispatchNui(name, data)
    if (not name) then return false end
    if (data and type(data) ~= 'table') then return false end

    SendNUIMessage({
        type = name,
        payload = data or {}
    })
end

function OpenApplication(name, hasFocus)
    if (type(name) ~= 'string') then return end;

    DispatchNui('root/app-management/set', { appName = name })
    OPEN_APPLICATION = name

    -- Allow for setting focus while opening
    if (hasFocus) then
        SetUIFocus(hasFocus, hasFocus)
    end

    TriggerEvent('nui:application:opened', OPEN_APPLICATION)
    return OPEN_APPLICATION
end

function SetUIFocus(hasKeyboard, hasMouse)
    SetNuiFocus(hasKeyboard, hasMouse)
    IS_FOCUSED = hasKeyboard or hasMouse
    TriggerEvent('vx-base:focus', IS_FOCUSED, hasKeyboard, hasMouse)
    return IS_FOCUSED
end

function CloseApplication()
    SetUIFocus(false, false)
    TriggerEvent('nui:application:close', OPEN_APPLICATION)
    OpenApplication("")
    OPEN_APPLICATION = ""
end

function GetOpenApplication()
    return OPEN_APPLICATION
end

function IsUiFocused()
    return IS_FOCUSED
end

UiEvents = {}
function RegisterNuiEvent(eventName)
    if (UiEvents[eventName]) then return false end
    UiEvents[eventName] = true

    RegisterNUICallback(eventName, function(...)
        TriggerEvent(('_vx_uiCB:%s'):format(eventName), ...)
    end)
end

RegisterNUICallback('app/close', function (data, cb)
    CloseApplication()

    cb({
        success = true
    })
end)

RegisterNetEvent('base:character:selected')
AddEventHandler('base:character:selected', function(character)
    DispatchNui('root/app-management/character/set', character)
end)

RegisterNetEvent('base:character:dropped')
AddEventHandler('base:character:dropped', function(character)
    DispatchNui("root/app-management/reset")
end)

Citizen.CreateThread(function()
    TriggerEvent('nui:ready')
end)

exports('GetOpenApplication', GetOpenApplication)
exports('DispatchNui', DispatchNui)
exports('RegisterNuiEvent', RegisterNuiEvent)
exports('OpenApplication', OpenApplication)
exports('CloseApplication', CloseApplication)
exports('SetUIFocus', SetUIFocus)
exports('IsUiFocused', IsUiFocused)