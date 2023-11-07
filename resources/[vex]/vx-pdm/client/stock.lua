RegisterUiCallBack('phone/pdm/vehicles', function(data, cb)
    local data = RPC.Execute('vx-pdm:catlog:get')

    cb({
        success = true,
        data = data
    })
end)

RegisterUiCallBack('phone/pdm/stock/buy', function(data, cb)
    local purchaseStock = RPC.Execute('vx-pdm:stock:purchase', data)

    cb({
        success = true,
        data = purchaseStock
    })
end)