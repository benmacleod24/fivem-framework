RegisterCommand({'c', 'cash'}, function(netId, args, _)
    local cash = GetCharactersCash(netId)
    TriggerClientEvent('nui:DispatchNui', netId, 'nui:cash:flash', {amount = cash})
end)

-- Fetch Character Cash Amount
-- Character gotten from netId
function GetCharactersCash(netId)
    local activeCharacter = exports['vx-base']:GetPlayerActiveCharacter(netId)

    local query = [[
        SELECT cash from characters
        WHERE characterId = ?
    ]]

    return exports.oxmysql:singleSync(query, {activeCharacter.characterId}).cash
end

-- Sets character cash
-- Character gotten from netId
-- Does NOT add or subtract only sets amount
function SetCharacterCash(netId, amount)
    local activeCharacter = exports['vx-base']:GetPlayerActiveCharacter(netId)

    local q = [[
        UPDATE characters
        SET cash = ?
        WHERE characterId = ?
    ]]

    exports.oxmysql:executeSync(q, {amount, activeCharacter.characterId})
end

-- Check character cash against amount
-- Character gotten from netId
function EnoughCash(netId, checkAmount)
    local cash = GetCharactersCash(netId)
    if (tonumber(cash) <= tonumber(checkAmount)) then return false end
    return true
end

exports('GetCharactersCash', GetCharactersCash)
exports('EnoughCash', EnoughCash)