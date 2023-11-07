Console = exports['vx-lib']:Console() or {}

-- Active characters table.
-- All active characters are stored against the player netId (as string).
CHARACTERS = {}

-- Get collection of players character against their playerId.
-- playerId is obtained by netId.
function GetPlayersCharacters(netId)
    if (not netId) then return end
    local playerInfo = GetPlayerInfo(netId)

    -- Player must be present to get their characters.
    if (not playerInfo) then return nil end

    -- SQL query
    local playersCharactersQuery = [[ SELECT * FROM fivem_characters WHERE player_id = ? ]]
    local playersCharacters = exports.oxmysql:fetchSync(playersCharactersQuery, { playerInfo.id })

    return playersCharacters
end

-- Get characters info against their character Id.
function GetCharacterInfo(characterId)
    -- Character Id is reqiured to find their info.
    if (not characterId) then return end

    -- SQL Query
    local charactersInfoQuery = [[ SELECT * FROM fivem_characters WHERE id = ? ]]
    local charactersInfo = exports.oxmysql:singleSync(charactersInfoQuery, { characterId })

    return charactersInfo
end

-- Create a players new character.
-- Data is passed from the NUI and returns the new characters id.
function CreateCharacter(netId, data)

    -- Blocker statements making sure correct data exist.
    if (not netId) then return nil end
    if (not data) then return nil end

    -- SQL Query.
    local newCharacterQuery = [[ 
        INSERT INTO 
        characters (player_id, first_name, last_name, date_of_birth, gender) 
        VALUES (?, ?, ?, ? ,?) 
    ]]

    local newCharacter = exports.oxmysql:insertSync(newCharacterQuery, { 
        GetPlayerInfo(netId).id,
        data.firstName,
        data.lastName,
        data.dateOfBirth,
        data.gender
    })

    -- Through new error if the character was not created successfully.
    if (not newCharacter) then
        Console:Error("An error occured while trying to create a character for player id #"..GetPlayerInfo(netId).id)
        return nil
    end

    return newCharacter
end

-- Handles the selecting of a character from the nui.
-- Dispatchs an event for the server and the client so they can initalize what they need too.
-- Also opens the spawn selection menu
function SetActiveCharacter(netId, characterId)

    local characterInfo = GetCharacterInfo(characterId)

    -- Through error if we can't collect characters info.
    if (not characterInfo) then
        Console:Error("An error occured while selecting character, could not collect character info.")
        return
    end

    local activeCharacter = {
        id = characterInfo.id,
        firstName = characterInfo.first_name,
        lastName = characterInfo.last_name,
        netId = netId
    }

    CHARACTERS[tostring(netId)] = activeCharacter

    -- Dispatch client & server events with character info.
    TriggerClientEvent("base:character:selected", netId, character)
    TriggerEvent("base:character:selected", character)

    -- Wait a second and then open the spawn selection menu.
    Wait(1000)
    TriggerClientEvent("nui:OpenApplication", netId, "spawn")

    -- Update the last_selected field in the database
    local lastSelectedUpdateQuery = [[ UPDATE fivem_characters SET last_selected = current_timestamp() WHERE id = ? ]]
    exports.oxmysql:updateSync(lastSelectedUpdateQuery, { characterInfo.id })

    Console:Log("Adding ["..character.characterId.."] to characters table.")
end

-- Remove the active character a player has
-- Dispatches an event similar to SetActiveCharacter.
function RemoveActiveCharacter(netId)
    CHARACTERS[tostring(netId)] = nil

    -- Dispatch an event letting the client & server know the character was dropped.
    TriggerEvent("base:character:dropped", netId)
    TriggerClientEvent("base:character:dropped", netId)

    Console:Log("Removing ["..netId.."] from characters table.")
end

-- Get players active character from their netId.
function GetPlayersActiveCharacter(netId)
    local activeCharacter = CHARACTERS[tostring(netId)]

    -- Return null if there is not active character.
    if (not activeCharacter) then return nil end

    return activeCharacter
end

-- Get players active character by their character Id.
-- Returns character object or null
function GetPlayerActiveCharacterById(characterId)
    for k,v in pairs(CHARACTERS) do
        if (v.characterId == character_id) then
            return CHARACTERS[k]
        end
    end

    -- Return null if we can't find a character.
    return nil
end

-- [[ Events ]]

RPC.Register("vx-base:character:active", function(netId)
    return GetPlayersActiveCharacter(netId)
end)

RPC.Register("vx-base:characters:active", function(netId)
    return CHARACTERS
end)

RPC.Register("base:characters:get", function(netId)
    return GetPlayersCharacters(netId)
end)

RPC.Register("base:character:get", function(netId, character_id)
    return GetCharacterInfo(character_id)
end)

RPC.Register("base:characters:post", function(netId, data)
    return CreateCharacter(netId, data)
end)

RPC.Register("base:characters:select", function(netId, data)
    return  SetActiveCharacter(netId, data)
end)

-- RPC Mainly to handle swapping of characters
-- Pretty much sets character with netId to nil and calls out an event for it
RPC.Register("base:character:drop", function(netId)
    RemoveActiveCharacter(netId)
end)

-- Remove character after user disconnect
AddEventHandler("playerDropped", function()
    local netId = tostring(source)
    CHARACTERS[netId] = nil
    Console:Log("Removing ["..netId.."] from characters table.")
end)