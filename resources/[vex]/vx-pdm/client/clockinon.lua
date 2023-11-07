

Citizen.CreateThread(function()
    exports['vx-zones']:AddBoxZone('pdm_main_zone', vector3(-42.41, -1094.81, 26.42), 24.2, 35.8, {
        name="pdm_main_zone",
        heading=338,
    })

    exports['vx-interact']:AddPeekEntryByModel(829413118, {
        id = 'pdm:clock:in',
        label = 'Clock In',
        event = 'vx-pdm:clock:in',
        icon = 'fa-clock',
    }, {
        isEnabled = function(context, entity)
            hasJob = RPC.Execute('jobs:player:has_job', {name = 'pdm'})

            return hasJob and context.zones['pdm_main_zone']
        end
    })
end)