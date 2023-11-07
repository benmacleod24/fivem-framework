-- Get the transactions for a bank account
function GetAccountTransactions(accountId)

    local q = [[
        SELECT *
        FROM bank_accounts_transactions
        WHERE transactionOwner = ?
        ORDER BY transactionDate DESC 
    ]]

    return exports.oxmysql:executeSync(q, {accountId})
end

-- Create a banking transaction
-- Might change transactionOwner to accountNumber kinda dumb
--[[
    transactionOwner = accountId
    transactionInitaior = accountNumber
    transactionAmount = number
    transactionDescription = string
]]
function CreateTransaction(transactionOwner, transactionInitaior, transactionAmount, transactionDescription)
    if (not transactionOwner) then return false end
    if (not transactionInitaior) then return false end
    if (not transactionAmount) then return false end

    local q = [[
        INSERT INTO bank_accounts_transactions
        (transactionOwner, transactionInitator, transactionAmount, transactionDescription)
        VALUES (?, ?, ?, ?)
    ]]

    return exports.oxmysql:insertSync(q, {transactionOwner, transactionInitaior, transactionAmount, transactionDescription})
end