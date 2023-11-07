CurrentZone, ZoneData, ZoneCenter = false, nil, nil

-- Returns job based on job polyzone player is in.
function GetCurrentJobLocation()
    if (not ZoneData or not CurrentZone) then return false end
    local job = RPC.Execute("jobs:get", {job = ZoneData.name})
    return job
end

-- Just an RPC wrapper for the server-side `GetActivePlayersJob` func
function GetPayersActiveJob()
    local activeJob = RPC.Execute("jobs:payer:active_job")
    return activeJob
end

-- Zone check & rpc wrapper for Creating a party
function CreateParty(data)
    if (not ZoneData or not CurrentZone) then return false end
    return RPC.Execute("job:party:new", {jobName = ZoneData.name, opts = data})
end

-- Managing zones events
AddEventHandler('vx-zones:enter', function(name, data, center)
    if (not data or not data.name or not data.is_job) then return end
    CurrentZone = name
    ZoneData = data
    ZoneCenter = center
end)

AddEventHandler('vx-zones:exit', function(name, data)
    CurrentZone = false
    ZoneData = nil
    ZoneCenter = nil
end)

exports('GetCurrentJobLocation', GetCurrentJobLocation)
exports('GetPayersActiveJob', GetPayersActiveJob)
exports('CreateParty', CreateParty)