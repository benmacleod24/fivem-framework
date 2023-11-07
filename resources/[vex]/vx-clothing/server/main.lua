-- Save players clothings into db
-- Check if string exist
function SavePlayerClothes(netId, clothingData)
    local characterId = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId
    local query = [[
         UPDATE characters_clothing
         SET clothes = ?
         WHERE characterId = ?
    ]]

    exports.oxmysql:updateSync(query, {json.encode(clothingData), characterId})
end

-- Gather players clothing string from db
function FetchPlayersClothes(characterId)
    local query = [[
        SELECT clothes
        FROM characters_clothing
        WHERE characterId = ?
    ]]

    return exports.oxmysql:singleSync(query, {characterId})
end

RegisterNetEvent('vx-clothing:save')
AddEventHandler('vx-clothing:save', function (clothingData)
    SavePlayerClothes(source, clothingData)
end)

-- Base events to handle character selection& creations
RegisterNetEvent('base:character:selected')
AddEventHandler('base:character:selected', function(character)
    local data = FetchPlayersClothes(character.characterId)
    TriggerClientEvent('vx-clothing:load', character.netId, data)
end)

RegisterNetEvent('base:character:created')
AddEventHandler('base:character:created', function(character)
    local query = [[
        INSERT INTO characters_clothing
        (characterId) VALUES (?)
    ]]

    exports.oxmysql:insertSync(query, {character})
end)
