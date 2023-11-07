RPC.Register('vx-economy:banking:accounts', function(netId)
    return GetCharacterBankAccounts(netId)
end)

RPC.Register('vx-economy:account:transactions', function(netId, data)
    return GetAccountTransactions(data.accountId)
end)

RPC.Register('vx-economy:account:amount:check', function(netId, data)
    return BankHaveEnough(data.accountNumber, data.amount)
end)

RPC.Register('vx-economy:account:actions:deposit', function(netId, data)
    if (not EnoughCash(netId, data.amount)) then rt(false) return end

    local bank = GetBankAccountById(data.accountId)
    local newBankAmount = tonumber(bank.accountAmount) + tonumber(data.amount)

    local cashAmount = GetCharactersCash(netId)
    local newCashAmount = cashAmount - data.amount

    -- Set new banking & cash values
    SetBankAccountAmount(bank.accountNumber, newBankAmount)
    SetCharacterCash(netId, newCashAmount)

    -- Flash new cash and generate transaction
    CreateTransaction(data.accountId, bank.accountNumber, data.amount, data.note)
    TriggerClientEvent('nui:DispatchNui', netId, 'nui:cash:flash', {amount = newCashAmount})
    return true
end)

RPC.Register('vx-economy:account:actions:withdraw', function(netId, data)
    local bank = GetBankAccountById(data.accountId)
    if (not BankHaveEnough(bank.accountNumber, data.amount)) then rt(false) return end
    local newBankAmount = tonumber(bank.accountAmount) - tonumber(data.amount)

    local cashAmount = GetCharactersCash(netId)
    local newCashAmount = cashAmount + data.amount

    -- Set new Banking & Cash Values
    SetCharacterCash(netId, newCashAmount)
    SetBankAccountAmount(bank.accountNumber, newBankAmount)

    -- Flash new cash and generate transaction
    CreateTransaction(data.accountId, bank.accountNumber, math.abs(tonumber(data.amount)) * -1, data.note)
    TriggerClientEvent('nui:DispatchNui', netId, 'nui:cash:flash', {amount = newCashAmount})
    return true
end)