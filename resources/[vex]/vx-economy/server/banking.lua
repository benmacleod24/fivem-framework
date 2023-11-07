--#region
-- This region involves functions with ID that aren't accountNumber

-- Get characters bank accounts that they have access too
function GetCharacterBankAccounts(netId)
    local characterId = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId

    local q = [[
        SELECT ba.*, baa.accessLevel
        FROM bank_accounts ba
        LEFT JOIN bank_accounts_access baa ON baa.bankId = ba.accountId
        WHERE baa.characterId = ?
    ]]

    return exports.oxmysql:executeSync(q, {characterId})
end

function GetCharacterPersonalAccount(netId)
    local characterId = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId

    local q =[[
        SELECT *
        FROM bank_accounts
        WHERE accountOwner = ? and accountType = 'personal'
    ]]

    return exports.oxmysql:singleSync(q, {characterId})
end
--#endregion

-- Get Account Info
-- Based off accountNumber not accountId
-- Players only see accountNumber not MySQL ID
function GetBankAccount(accountNumber)
    if (not accountNumber) then return {} end
    accountNumber = tostring(accountNumber)

    local q = [[
        SELECT *
        FROM bank_accounts
        WHERE accountNumber = ?
    ]]

    return exports.oxmysql:singleSync(q, {accountNumber})
end

-- Get Account Info
-- Based off accountId not accountNumber
-- Players only see accountNumber not MySQL ID
function GetBankAccountById(accountId)
    if (not accountId) then return {} end

    local q = [[
        SELECT *
        FROM bank_accounts
        WHERE accountId = ?
    ]]

    return exports.oxmysql:singleSync(q, {accountId})
end

-- Sets new Bank Account amount
-- Does NOT add or subtract only sets to certain amount
function SetBankAccountAmount(accountNumber, newAccountAmount)
    if (not newAccountAmount) then return end
    if (not accountNumber) then return end

    local q = [[
        UPDATE bank_accounts
        SET accountAmount = ?
        WHERE accountNumber = ?
    ]]

    local res = exports.oxmysql:executeSync(q, {newAccountAmount, accountNumber})
    return res
end

-- Check bank account for certain amount
function BankHaveEnough(accountNumber, checkAmount)
    if (not accountNumber or not checkAmount) then return false end
    local bankAmount = GetBankAccount(accountNumber).accountAmount
    if (tonumber(bankAmount) >= tonumber(checkAmount)) then return true end
    return false
end

-- Exports
exports('GetCharacterBankAccounts', GetCharacterBankAccounts)
exports('SetBankAccountAmount', SetBankAccountAmount)
exports('GetBankAccount', GetBankAccount)
exports('BankHaveEnough', BankHaveEnough)