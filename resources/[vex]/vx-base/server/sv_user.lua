AddEventHandler("playerConnecting", function(name, setKickReason, deferals)
    local netId = source

    deferals.defer()
    deferals.update("Hello, "..name.."! We are checking your Discord & License.")

    -- Verify Steam is running
    local license = exports["vx-lib"]:GetIdentifier(netId, "license")
    if (not license or license == "") then
        deferals.done("Please open Steam and rejoin, we could not find your License.")
    end

    -- Verify Discord is running
    local discordId = exports["vx-lib"]:GetIdentifier(netId, "discord")
    if (not discordId or discordId == "") then
        deferals.done("Please open Discord and rejoin, we could not find your Discord ID.")
    end

    -- Fetch User data
    local user = GetPlayerInfo(netId)
    if (not user) then
        deferals.update("We are creating your user!")
        
        local newUser = CreateNewPlayer(netId)
        if (not newUser) then deferals.update("Failed to create user data.") end
        deferals.done()
    end

    deferals.done()
end)

-- Handle player dropped events here.
-- Not globally but just for this file.
AddEventHandler('playerDropped', function (reason)
    local netId = source
    local license = exports['vx-lib']:GetIdentifier(netId, 'license')

    -- Update the players last connected date
    local updateConnectedDateQuery = [[ UPDATE `fivem_players` SET `last_connected` = current_timestamp() WHERE `license` = ? ]]
    exports.oxmysql:updateSync(updateConnectedDateQuery, { license })

  end)



-- Get player from the database based off their licsence id
function GetPlayerInfo(netId)
    if (not netId) then return nil end

    local license = exports['vx-lib']:GetIdentifier(netId, 'license')
    local query = "SELECT * FROM fivem_players WHERE license = ?"
    local playerInfo = exports.oxmysql:singleSync(query,{ splitString(license, ":")[1] })

    -- Verify that the player info exist
    if (not playerInfo) then return nil end

    return playerInfo
end

-- Create new player in the database.
-- Takes in the players netId to collect information.
-- Returns their newly created playerId.
function CreateNewPlayer(netId)

    if (not netId) then return nil end

    local identities = exports['vx-lib']:GetIdentifier(netId, { "discord", "steam", "license" })
    print(json.encode(identities), "Test")
    local query = [[ INSERT INTO fivem_players (steam, license, discord, last_connected) VALUES (?, ?, ?, current_timestamp()) ]]

    local playerId = exports.oxmysql:insertSync(query, { identities["steam"] or "", identities["license"] or "", identities["discord"] or "" })
    
    return playerId
end