Console = Console or {}

-- Console Object for logging correctly in both the client & server.
-- Simply just changes the color and log label based on the method called.

Console.Log = function(self, message, module)
    local invokingModule = GetInvokingResource()

    -- Allowing for custom modules so it's not just resources.
    if (module) then
        invokingModule = module
    end

    local formattedMessage = string.format("^2[Vex Log - %s]^7 %s", splitString(invokingModule, "-")[2] or "No Module Found", message or "")

    Citizen.Trace(formattedMessage .. "\n")
    return formattedMessage
end

Console.Error = function(self, message, module)
    local invokingModule = GetInvokingResource()

    -- Allowing for custom modules so it's not just resources.
    if (module) then
        invokingModule = module
    end

    local formattedMessage = string.format("^1[Vex Error - %s]^7 %s", splitString(invokingModule, "-")[2] or "No Module Found", message or "")
    
    Citizen.Trace(formattedMessage .. "\n")
    return formattedMessage
end

Console.Warn = function(self, message, module)
    local invokingModule = GetInvokingResource()

    -- Allowing for custom modules so it's not just resources.
    if (module) then
        invokingModule = module
    end

    local formattedMessage = string.format("^3[Vex Error - %s]^7 %s", splitString(invokingModule, "-")[2] or "No Module Found", message or "")
    
    Citizen.Trace(formattedMessage .. "\n")
    return formattedMessage
end

exports("Console", function(message, module) return Console end)