isCuffed = false

function BuildClockMenu()
    exports['vx-context']:OpenContextMenu(Menus.Duty)
end

Citizen.CreateThread(function()
    exports['vx-zones']:AddBoxZone('mrpd_clock', vector3(441.19, -981.98, 30.69), 2.2, 1.8, {
        name="mrpd_clock",
        heading=0,
        minZ=27.39,
        maxZ=32.39
    })

    exports['vx-interact']:AddPeekEntryByPolyZone('mrpd_clock', {        
        id = 'vx:police:clock:in',
        label = 'Clock In/Out',
        icon = 'fa-solid fa-clock',
    }, {
        cb = BuildClockMenu,
        isEnabled = function(context, entity)
            hasJob = RPC.Execute('jobs:player:has_job', {name = 'leo'})
            return hasJob
        end
    })
end)