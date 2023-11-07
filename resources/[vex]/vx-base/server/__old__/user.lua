AddEventHandler("playerConnecting", function(name, setKickReason, deferals)
    local netId = source

    deferals.defer()
    deferals.update("Hello, "..name.."! We are checking your Discord & License.")

    -- Verify Steam is running
    local license = exports["vx-lib"]:GetIdentifierType(netId, "license")
    if (not license or license == "") then
        deferals.done("Please open Steam and rejoin, we could not find your License.")
    end

    -- Verify Discord is running
    local discordId = exports["vx-lib"]:GetIdentifierType(netId, "discord")
    if (not discordId or discordId == "") then
        deferals.done("Please open Discord and rejoin, we could not find your Discord ID.")
    end

    -- Fetch User data
    local user = FetchUser(netId)
    if (not user) then
        deferals.update("We are creating your user!")
        local newUser = CreateUser(netId)
        if (not newUser) then deferals.update("Failed to create user data.") end
        deferals.done()
    end

    deferals.done()
end)

function FetchUser(netId)
    local license = exports["vx-lib"]:GetIdentifierType(netId, "license")
    local res = exports.oxmysql:singleSync("SELECT * FROM users WHERE userLicense = ?", {splitString(license, ":")[2]})
    return res
end

function CreateUser(netId)
    local license = exports["vx-lib"]:GetIdentifierType(netId, "license")
    local steamId = exports["vx-lib"]:GetIdentifierType(netId, "steam")
    local discord = exports["vx-lib"]:GetIdentifierType(netId, "discord")
    local res = exports.oxmysql:insertSync("INSERT INTO users (userSteam, userLicense, userDiscord) VALUES (:steam, :license, :discord)", {
        steam = splitString(steamId, ":")[2],
        license = splitString(license, ":")[2],
        discord = splitString(discord, ":")[2],
    })
end