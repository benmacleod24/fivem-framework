CurrentCell = nil
CurrentZone, ZoneData, ZoneCenter, NotifyClear = false, nil, nil, nil

function GetMyJailCell()
    return Config.Cells[CurrentCell]
end

-- Sends them to their current jail cell
function SendToCell(notify)
    -- Fade Screen out quickly
    DoScreenFadeOut(250)
    Wait(300)

    -- Freeze Player & Send them to their cell
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), GetMyJailCell().x, GetMyJailCell().y, GetMyJailCell().z)
    SetEntityHeading(PlayerPedId(), GetMyJailCell().h)

    -- Fade their screen back in one succesfully
    Wait(750)
    DoScreenFadeIn(750)

    -- Unfreeze them & notify the player
    FreezeEntityPosition(PlayerPedId(), false)

    if (notify ) then
        exports['vx-context']:SendNotification({label = notify.label, color = notify.color, timeout = 4})
    end
end

-- Runs when a player has been sent to prison
RegisterNetEvent("prison:sent", function(res)

    -- Make sure we aren't running this on anyone who isn't in prison
    local inPrison = RPC.Execute("prison:isPlayerInPrison")
    if (not inPrison) then return end

    -- Assign the prisoner a jail cell
    CurrentCell = math.random(1, #Config.Cells)
    exports['vx-characters']:FreezeVitals(true)

    SendToCell({label = "Welcome to Prison!", color = 'orange.400'})
end)

-- Zone Handling
AddEventHandler('vx-zones:enter', function(name)
    CurrentZone = name

    if (name == "prison_time_check") then
        TriggerEvent("prison:timecheck:loop")
    end
end)

AddEventHandler('vx-zones:exit', function(name)
    local inPrison = RPC.Execute("prison:isPlayerInPrison")

    -- Send them back to their cell if they try to escape
    if (inPrison and name == "prison") then
        SendToCell({label = "Nice Try! Still in Prison.", color = 'red.500'})
        return
    end

    CurrentZone = nil
end)