CURRENT_TIME = {}
baseTime = 0
timeOffSet = 0
freezeTime = false

-- Main event
-- Communicates every sync request between cli and serv
RegisterNetEvent('vx-sync:time:sync')
AddEventHandler('vx-sync:time:sync', function()
    TriggerClientEvent('vx-sync:time:update', -1, CURRENT_TIME)
end)

RPC.Register("sync:time:set", function(netId, hour, minuite)
    return SetTime(hour, minuite)
end)

function SetTime(hour, minuite)
    ShiftToMinute(minuite)
    ShiftToHour(hour)

    local hour, minute, second = timeToHMS()
    CURRENT_TIME = {
        hour = hour,
        minute = minute,
        second = second
    }
end

-- Setting the Base time of the server
-- Runs every half second
Tick(function()
    local osTime = os.time(os.date("!*t"))/2 + 360

    if (freezeTime) then
        timeOffSet = timeOffSet + baseTime - osTime
    end

    baseTime = osTime
    local hour, minute, second = exports['vx-lib']:timeToHMS(baseTime)
    CURRENT_TIME = {
        hour = hour,
        minute = minute,
        second = second
    }
end, 500)

Tick(function()
    TriggerEvent('vx-sync:time:sync')
end, 5000)

-- Utils for Time
-- Specific to Resource
function ShiftToMinute(minute)
    timeOffset = timeOffset - (((baseTime + timeOffset) % 60) - minute)
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ((((baseTime + timeOffset) / 60) % 24) - hour) * 60
end