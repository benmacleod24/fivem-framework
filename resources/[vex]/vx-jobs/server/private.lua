-- Gives player job, this is check against `fivem_character_jobs`
-- Handes whitelisted jobs such as poice
function GivePlayerJob(netId, jobName)
    local characterId = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId

    -- No need to clock in 
    if (GetPlayersActiveJob(netId) == jobName) then
        return false
    end

    -- Check if the job exist
    if (not JOBS[jobName]) then
        exports['vx-lib']:Console():Error("Job ("..jobName..") doesn't exit to be given to netId "..netId)
        return false
    end

    -- Don't have an employee table for party jobs
    if (JOBS[jobName].is_party_enabled) then
        return false
    end

    -- Verify player has the job
    local hasJob, job = DoesPlayerHaveJob(netId, jobName)
    if (not hasJob) then return false end

    newEmployee = {
        netId = netId,
        characterId = characterId,
        level = job.whitelistedLevel
    }

    JOBS[jobName].employees[tostring(netId)] = newEmployee
    exports['vx-lib']:Console():Log('Employeed '..netId..' at '..jobName)
    return true
end

-- Remove player existing job
function RemovePlayerJob(netId, jobName)
    if (not JOBS[jobName]) then return false end

    for k,v in pairs(JOBS[jobName].employees) do
        if (v.netId == netId) then
            JOBS[jobName].employees[k] = nil
        end
    end

    exports['vx-lib']:Console():Log('Unemployeed '..netId..' at '..jobName)
end

exports('GivePlayerJob', GivePlayerJob)
exports('RemovePlayerJob', RemovePlayerJob)