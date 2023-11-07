-- Send player to jail
-- Only job authed right now is leo
-- Should prob do judge in the future
RegisterCommand("jail", function(netId, args)

    -- Requied they have correct job to jail
    if(exports['vx-jobs']:GetPlayersActiveJob(netId) ~= "leo") then
        return
    end

    local prisonerNetId = tonumber(args[1])
    local sentencelength = args[2]

    -- Send prisoner to prison
    local success = exports['vx-prison']:SendPlayerToPrison(prisonerNetId, sentencelength)
    if (not success) then return end

    -- Confirm with the police officer
    TriggerClientEvent("vx-context:notification", netId, {
        label = "Successfully Jailed!",
        timeout = 3.5,
        color = 'green.400',
    })
end)