CHARACTERS = {}

RPC.Register("base:characters:get", function(netId)
    return GetUserCharacters(netId)
end)

RPC.Register("base:character:get", function(netId, character_id)
    return GetCharacterById(character_id)
end)

RPC.Register("base:characters:post", function(netId, data)
    return CreateCharacter(data, netId)
end)

RPC.Register("base:characters:select", function(netId, data)
    SelectCharacter(data, netId)
    return true
end)

function GetUserCharacters(netId)
    if (not netId) then return {} end
    local user = FetchActiveUsers(netId)
    local characters = exports.oxmysql:executeSync("SELECT * FROM characters WHERE characterOwner = ?", {user.userId})
    return characters
end

function GetUserCharacter(characterId)
    if (not characterId) then return {} end
    local character = exports.oxmysql:singleSync("SELECT * FROM characters WHERE characterId = ?", {characterId})
    return character
end

function CreateCharacter(data, netId)
    local query = [[
        INSERT INTO characters
        (characterOwner, firstName, lastName, dateOfBirth, gender)
        VALUES (?, ?, ?, ?, ?)
    ]]

    local character = exports.oxmysql:insertSync(query, {FetchActiveUsers(netId).userId, data.firstName, data.lastName, data.dateOfBirth, data.gender})
    
    TriggerClientEvent('base:character:created', netId, character)
    TriggerEvent('base:character:created', character)
    
    return character
end

-- Select the character
-- Sends events when the character is selected
-- Key for the character table is the netId
function SelectCharacter(characterId, netId)
    local character = GetUserCharacter(characterId)

    if (not character or character == "{}") then 
        exports["vx-lib"]:ConsoleError("base", "Error getting character data for "..characterId..".")
        return
    end
    
    character = {
        characterId = character.characterId,
        characterOwner = character.characterOwner,
        firstName = character.firstName,
        lastName = character.lastName,
        netId = netId,
    }

    CHARACTERS[tostring(netId)] = character

    TriggerClientEvent("base:character:selected", netId, character)
    TriggerEvent("base:character:selected", character)
    Wait(1000)
    TriggerClientEvent("nui:OpenApplication", netId, "spawn")

    -- Updated lastSelected value in Database
    -- This is analytics for the staff dashaboard
    local query = [[UPDATE characters SET lastSelected = current_timestamp() WHERE characterId = ?]]
    exports.oxmysql:updateSync(query, {characterId})

    exports["vx-lib"]:ConsoleLog("base", "Adding ["..character.characterId.."] to characters table.")
end

-- Get players active character
-- Gathers data from netId
function GetPlayerActiveCharacter(netId)
    for k,v in pairs(CHARACTERS) do
        if (k == tostring(netId)) then
            return CHARACTERS[k]
        end
    end
end

function GetCharacterById(character_id)
    for k,v in pairs(CHARACTERS) do
        if (v.characterId == character_id) then
            return CHARACTERS[k]
        end
    end
end

-- Get active characters
-- Gathers data from netId
function GetActiveCharacters(netId)
    return CHARACTERS
end

function DropCharacter(netId)
    CHARACTERS[tostring(netId)] = nil
    TriggerEvent("base:character:dropped", netId)
    TriggerClientEvent("base:character:dropped", netId)

    exports["vx-lib"]:ConsoleLog("base", "Removing ["..netId.."] from characters table.")
end

-- Get players active character RPC
RPC.Register('vx-base:character:active', function(netId)
    return GetPlayerActiveCharacter(netId)
end)

-- Get active characters RPC
RPC.Register('vx-base:characters:active', function(netId)
    return GetActiveCharacters()
end)

-- RPC Mainly to handle swapping of characters
-- Pretty much sets character with netId to nil and calls out an event for it
RPC.Register("base:character:drop", function(netId)
    DropCharacter(netId)
end)

-- Remove character after user disconnect
AddEventHandler("playerDropped", function()
    local netId = tostring(source)
    CHARACTERS[netId] = nil
    exports["vx-lib"]:ConsoleLog("base", "Removing ["..netId.."] from characters table.")
end)



exports('GetPlayerActiveCharacter', GetPlayerActiveCharacter)
exports('GetCharacterById', GetCharacterById)
exports('GetActiveCharacters', GetActiveCharacters)
exports('DropCharacter', DropCharacter)