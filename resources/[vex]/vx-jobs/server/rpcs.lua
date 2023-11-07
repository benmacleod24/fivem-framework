RPC.Register('vx-jobs:player:give', function(netId, data)
    return GivePlayerJob(netId, data.jobName or data.name)
end)

RPC.Register('jobs:player:has_job', function (netId, data)
    return DoesPlayerHaveJob(netId, data.jobName or data.name)
end)

RPC.Register('jobs:player:active_job', function (netId)
    return GetPlayersActiveJob(netId)
end)

RPC.Register('vx-jobs:table', function (netId)
    return JOBS
end)

RPC.Register("jobs:get", function(netId, data)
    return GetJob(data.job)
end)