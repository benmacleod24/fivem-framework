NOTIFICATIONS = {}

--[[
    label = string,
    color = Any hex color code,
    timeout = number (in seconds),
    isStatic = boolean (void timeout param)
]]

function SendNotification(notification)
    local id = #NOTIFICATIONS + 1
    notification.id = id

    -- We want to generate the ID from the active notifications we have
    if (not id) then
        id = #NOTIFICATIONS + 1
    end

    exports['vx-nui']:DispatchNui('notifications:add', notification)

    -- Add to our client-side table
    NOTIFICATIONS[id] = notification
    
    return id, RemoveNotification, UpdateNotification
end

RegisterNetEvent('vx-context:notification')
AddEventHandler('vx-context:notification', function (notification)
    SendNotification(notification)
end)

function UpdateNotification(notificationId, newNotification)
    exports['vx-nui']:DispatchNui('notification:update:'..notificationId, newNotification)
end

function RemoveNotification(notificationId)
    exports['vx-nui']:DispatchNui('notification:remove:'..notificationId, {})
end

exports('SendNotification', SendNotification)
exports('RemoveNotification', RemoveNotification)
exports('UpdateNotification', UpdateNotification)