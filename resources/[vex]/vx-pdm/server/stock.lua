function GetCatlog()
    local q = [[
        SELECT *
        FROM pdm_catalog
    ]]

    return exports.oxmysql:executeSync(q)
end

function FetchVehicle(vehicleId)
    local q = [[
        SELECT *
        FROM pdm_catalog
        WHERE vehicleId = ?
    ]]
    return exports.oxmysql:singleSync(q, {vehicleId})
end

function PurchaseVehicleStock(vehicleId, quantity)
    local vehicle = FetchVehicle(vehicleId)
    local _quantity = vehicle.storeStock + tonumber(quantity)
    local price = vehicle.vehiclePrice * tonumber(quantity)

    if (not exports['vx-economy']:BankHaveEnough(48041185, price)) then
        return 'Insufficent Funds'
    end

    local q = [[
        UPDATE pdm_catalog
        SET storeStock = :stock
        WHERE vehicleId = :vehicleId
    ]]

    local pdmAccountAmount = exports['vx-economy']:GetBankAccount(48041185).accountAmount
    exports['vx-economy']:SetBankAccountAmount(48041185, (pdmAccountAmount - price))

    exports.oxmysql:executeSync(q, {stock = _quantity, vehicleId = vehicleId})
    return 'success'
end

RPC.Register('vx-pdm:catlog:get', function()
    return GetCatlog()
end)

RPC.Register('vx-pdm:stock:purchase', function(netId, data)
    return PurchaseVehicleStock(data.vehicleId, data.quantity)
end)