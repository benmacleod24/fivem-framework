IS_CUFFED = false

function CuffClosestPlayer()
    local closestPlayer = exports['vx-lib']:GetClosestPlayer()
    local distanceBetween = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(closestPlayer))

    -- Want to make sure the distance between each player is close enough
    -- Also want to make sure they aren't in a vehicle (RP Sake)
    if (not closestPlayer) then
        print("No one near/in vehicle")
        return
    end

    -- We want to trigger a network call here
    -- Auth through the server
    local cuffAttemp = RPC.Execute("character:cuff", closestPlayer)

    -- Want to makre sure the server allowed us to cuff successfully
    if (not cuffAttemp) then
        print("An error occured while trying to cuff (missing netId or targetNetId)")
        return
    end

    -- Trigger Anim Here
    Wait(100)
    TaskAnim("mp_arrest_paired", "cop_p2_back_right", 32, 8.0)
    Wait(3500)
    ClearPedTasksImmediately(PlayerPedId())
end

-- Called when a player has successfully been cuffed
RegisterNetEvent("character:cuffed", function(executerNetId)
    -- Set client as cuffed
    IS_CUFFED = true

    -- Begin cuffed loop
    -- found in -> loops.lua "character:loops:cuffed"
    TriggerEvent("character:loops:cuffed")

    -- Get position of player who is cuffing this client
    local executer = GetPlayerPed(GetPlayerFromServerId(executerNetId))
    local executerHeading = GetEntityHeading(executer)

    -- Visual things to make it look real
    SetEntityHeading(PlayerPedId(), executerHeading)
    SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(executer, 0.0, 0.45, 0.0))

    -- Anim handling
    ClearPedTasksImmediately(PlayerPedId())
    TaskAnim("mp_arrest_paired", "crook_p2_back_right", 32, 8.0)

    -- Should prob add in a skill check here
end)

RegisterCommand("cuff", function()
    CuffClosestPlayer()
end)

exports('CuffClosestPlayer', CuffClosestPlayer)