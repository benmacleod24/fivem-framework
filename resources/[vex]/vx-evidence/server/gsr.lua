ACTIVE_GSR = {}

function AddGsrStatus(net_id)
    if (ACTIVE_GSR[tostring(net_id)]) then return end

    -- Add them to ACTIVE_GSR table
    ACTIVE_GSR[tostring(net_id)] = true

    -- Create loop to clear it in x time
    Citizen.SetTimeout(Config.gsr_falloff_time, function()
        ACTIVE_GSR[tostring(net_id)] = nil
    end)
end

-- Removes it outside of SetTimeout func
function RemoveGsrStatus(net_id)
    if (not ACTIVE_GSR[tostring(net_id)]) then return end
    ACTIVE_GSR[tostring(net_id)] = nil
end

-- Gets the status of their GSR
function GetPlayersGsrStatus(net_id)
    if (not ACTIVE_GSR[tostring(net_id)]) then return false end
    return ACTIVE_GSR[tostring(net_id)]
end

-- ::Events::
RegisterNetEvent("vx-evidence:gsr:add", function()
    local net_id = source
    AddGsrStatus(net_id)
end)

RegisterNetEvent("vx-evidence:gsr:remove", function()
    local net_id = source
    RemoveGsrStatus(net_id)
end)

RPC.Register("vx-evidence:gsr:status", function (net_id)    
    return GetPlayersGsrStatus(net_id)
end)