Citizen.CreateThread(function ()
    exports['vx-interact']:AddPeekEntryByEntityType(3, 
         {
            id = 'vx-locks:door:info',
            label = 'Get Door Info',
            icon = 'fa-solid fa-terminal'
        },
         {
            isEnabled = function(context, ent)
                return true
            end,
            cb = function(data)
                data.position = GetEntityCoords(data.entity)
                data.hash = GetHashKey(data.entity)
                TriggerServerEvent("vx-locks:dev_tools:print", data)
            end,
        }
    )
end)