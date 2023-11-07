local registeredEvents = {}

function RegisterUiCallBack(name, cb)
    local function intercepter(data, intCB)
        cb(data, function(returnMeta)
            intCB(returnMeta)
        end)
    end

    AddEventHandler(('_vx_uiCB:%s'):format(name), intercepter)
    if (GetResourceState('vx-nui') == 'started') then
        exports['vx-nui']:RegisterNuiEvent(name)
    end

    registeredEvents[#registeredEvents + 1] = name
end

AddEventHandler('nui:ready', function()
    for _, eventName in ipairs(registeredEvents) do
        exports['vx-nui']:RegisterNuiEvent(eventName)
    end
end)

exports('RegisterUiCallBack', RegisterUiCallBack)