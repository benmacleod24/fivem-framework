--[[
    ::MUST DO::
    Once the MDT dispatch endpoint has been made connect it up to this
]]

RegisterNetEvent('vx-police:clock:in')
AddEventHandler('vx-police:clock:in', function (data)
    local netId = source
    exports['vx-jobs']:GivePlayerJob(netId, 'leo')
    TriggerClientEvent('vx-context:notification', netId, {
        label = 'Clocked On',
        color = 'green.300',
        timeout = 3
    })
end)

RegisterNetEvent('vx-police:clock:out')
AddEventHandler('vx-police:clock:out', function (data)
    local netId = source
    exports['vx-jobs']:RemovePlayerJob(netId, 'leo')
    TriggerClientEvent('vx-context:notification', netId, {
        label = 'Clocked Off',
        color = 'orange.300',
        timeout = 3
    })
end)