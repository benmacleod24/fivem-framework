CurrentWeather = 'EXTRASUNNY'
WeatherFrozen = false
WeatherTimer = 0

RegisterNetEvent('vx-sync:weather:sync')
AddEventHandler('vx-sync:weather:sync', function()
    TriggerClientEvent('vx-sync:weather:update', -1, CurrentWeather)
end)

RegisterNetEvent("sync:weather:set", function(data)
    CurrentWeather = data
    TriggerEvent('vx-sync:weather:sync')
end)

-- Events for weather frozen data
RegisterNetEvent("sync:weather:freeze:toggle", function(data)
    WeatherFrozen = not WeatherFrozen
    TriggerEvent('vx-sync:weather:sync')
end)

RPC.Register("sync:weather:frozen", function (netId, data)
    return WeatherFrozen
end)

Tick(function()
    WeatherTimer = WeatherTimer + 1

    if (WeatherTimer >= 10 and not WeatherFrozen) then
        NextWeatherType()
    end
end, 60 * 1000)

function NextWeatherType()

    if ( CurrentWeather == 'CLEAR' or CurrentWeather == 'EXTRASUNNY' ) then
        local random = math.random(1, 2)
        
        if ( random == 1) then
            CurrentWeather = 'CLOUDS'
        else
            CurrentWeather = 'OVERCAST'
        end
    end

    if ( CurrentWeather == 'CLEARING' or CurrentWeather == 'OVERCAST' or CurrentWeather == 'CLOUDS' ) then
        local random = math.random(1, 12)

        if ( random == 1 ) then
            if ( CurrentWeather == 'CLEARING' ) then
                CurrentWeather = 'CLEAR'
            else
                if ( math.random(100) > 85 ) then
                    CurrentWeather = 'RAIN'
                else
                    CurrentWeather = "CLOUDS"
                end
            end
        elseif ( random == 2) then
            CurrentWeather = 'CLEAR'
        elseif ( random == 3) then
            CurrentWeather = 'FOGGY'
        elseif ( random > 3 and random < 6) then
            CurrentWeather = 'SMOG'
        else
            CurrentWeather = 'EXTRASUNNY'
        end
    end

    if ( CurrentWeather == 'THUNDER' or CurrentWeather == 'RAIN' ) then
        CurrentWeather = 'CLEARING'
    end

    if ( CurrentWeather == 'SMOG' or CurrentWeather == 'FOGGY' ) then
        CurrentWeather = 'CLEAR'
    end
    TriggerEvent('vx-sync:weather:sync')
end