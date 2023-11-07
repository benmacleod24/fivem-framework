CurrentWeather = 'EXTRASUNNY'

RegisterNetEvent('vx-sync:time:update')
AddEventHandler('vx-sync:time:update', function(time)
    NetworkOverrideClockTime(time.hour, time.minute, 0)
end)

RegisterNetEvent('vx-sync:weather:update')
AddEventHandler('vx-sync:weather:update', function(weather, time)
    if (CurrentWeather ~= weather) then
        CurrentWeather = weather
        SetWeatherTypeOverTime(weather, time or 15.0)
        Wait(15000)
    end

    SetWeatherTypePersist(weather)
    SetWeatherTypeNow(weather)
    SetWeatherTypeNowPersist(weather)

    if (CurrentWeather == 'XMAX') then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
    end
end)