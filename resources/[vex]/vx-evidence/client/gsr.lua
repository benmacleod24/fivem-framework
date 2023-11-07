has_fired_weapon = false

-- Loop that listens for ped shooting
Tick(function()
    if (IsPedShooting(PlayerPedId())) then
        TriggerServerEvent("vx:evidence:gsr:add")
        Citizen.Wait(5 * 1000)
    end
end)