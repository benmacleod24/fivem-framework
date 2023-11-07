JOBS = {}

-- Fetch Jobs and Initalize Them
-- All jobs private and public
function InitalizeJobs()
    local jobs = exports.oxmysql:executeSync('SELECT * FROM fivem_jobs')

    for _,v in pairs(jobs) do
        jobObj = v

        -- Create Party table
        if (v.is_party_enabled >= 1) then
            jobObj.is_party_enabled = true
            jobObj.parties = {}
        else
            jobObj.is_party_enabled = false
            jobObj.employees = {}
            jobObj.max_member_limit = nil
        end

        JOBS[v.name] = jobObj
    end

    exports['vx-lib']:Console():Log("Successfully loaded jobs config.")
end

-- Fetches players active job
-- Public or private
function GetPlayersActiveJob(netId)
    for k,v in pairs(JOBS) do

        -- Determine if party or not
        if (v.is_party_enabled) then

            -- This is very ugly
            -- Search all parties
            for pk, pv in pairs(v.parties) do
                if (pv.partyMembers) then

                    -- Search through each party and it's members
                    for km, vm in pairs(pv.partyMembers) do
                        if (vm.netId == netId) then
                            return k
                        end
                    end
                end
            end

        elseif (v.employees[tostring(netId)]) then
            return k
        end
    end

    return false
end

-- Simply returns job based on key name
function GetJob(name)
    return JOBS[name]
end

-- Initalize all server jobs
Citizen.CreateThread(function()
    InitalizeJobs()
end)

exports("GetPlayersActiveJob", GetPlayersActiveJob)