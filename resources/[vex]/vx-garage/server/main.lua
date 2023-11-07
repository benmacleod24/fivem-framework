RPC.Register("vx-garage:get:vehicles", function(netId, data)
    local q = [[
        SELECT *
        FROM vehicles
        WHERE vehicleGarage = ?
    ]]

    return exports.oxmysql:executeSync(q, {data.garageName})
end)