RegisterUiCallBack('atm/accounts/get', function(_data, cb)
    local accounts = RPC.Execute('vx-economy:banking:accounts')

    cb(accounts)
end)

RegisterUiCallBack('atm/transactions/get', function(data, cb)
    local transactions = RPC.Execute('vx-economy:account:transactions', {accountId = data.accountId})

    cb(transactions)
end)

RegisterUiCallBack('atm/actions/withdraw', function(data, cb)
    RPC.Execute('vx-economy:account:actions:withdraw', data)

    cb({})
end)

RegisterUiCallBack('atm/actions/deposit', function(data, cb)
    RPC.Execute('vx-economy:account:actions:deposit', data)

    cb({})
end)

-- Still need to wire this up didn't have time too
RegisterUiCallBack('atm/actions/transfer', function(data, cb)

    cb({})
end)