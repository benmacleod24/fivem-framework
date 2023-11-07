USERS = {}

-- User gets assigned netId.
-- Add user to the table of users.
AddEventHandler("playerJoining", function(oldId)
    local netId = source

    user = {
        steam = exports["vx-lib"]:GetIdentifierType(netId, "steam"),
        license = exports["vx-lib"]:GetIdentifierType(netId, "license"),
        userId = FetchUser(netId).userId,
        netId = netId,
    }

    USERS[tostring(netId)] = user
    exports["vx-lib"]:ConsoleLog("base", "Adding ["..FetchUser(netId).userId.."] to players table.")
end)

-- Remove user after disconnect.
AddEventHandler("playerDropped", function()
    local netId = tostring(source)
    USERS[netId] = nil
    exports["vx-lib"]:ConsoleLog("base", "Removing ["..FetchUser(netId).userId.."] from players table.")
end)

-- Get active users information.
function GetActiveUsers(netId)
    if (not netId) then return USERS end
    return USERS[tostring(netId)]
end