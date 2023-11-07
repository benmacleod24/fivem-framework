-- Table Endpoints for Dev Panel
-- Find Better way to not pass server data such a way (Will do for now)

-- Active Characters Server Table
RegisterUiCallBack('dev/table/characters', function(data, cb)
    res = RPC.Execute('vx-base:characters:active')
    cb(res)
end)

-- Jobs Server Table
RegisterUiCallBack('dev/table/jobs', function(data, cb)
    res = RPC.Execute('vx-jobs:table')
    cb(res)
end)

RegisterUiCallBack('dev/table/hotels', function(data, cb)
    res = RPC.Execute('hotels:table')
    cb(res)
end)

RegisterUiCallBack('dev/table/interiors', function(data, cb)
    res = RPC.Execute('interiors:table')
    cb(res)
end)

RegisterUiCallBack('dev/table/vehicle-keys', function(data, cb)
    res = RPC.Execute('vx-vehicles:keys')
    cb(res)
end)