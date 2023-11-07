-- Simple wrapper to check if trucking
-- So no need to repeat it a million times
function IsTrucker()
    activeJob = GetPayersActiveJob()

    if (not GetPayersActiveJob()) then return false end
    if (activeJob.name == "semitrucking") then return true end

    return false
end

-- Root Function to start the job
function StartTrucking()

    if (not IsTrucker()) then return false end

    -- Collect list of spots
    -- Generate Semi-Truck (Store against party data)

end