RegisterUiCallBack("phone/workforce/current-job", function(data, cb)
    cb(exports['vx-jobs']:GetCurrentJobLocation())
end)

RegisterUiCallBack("phone/workforce/party/new", function(data, cb)
    print(data.name)
    exports['vx-jobs']:CreateParty(data)
    cb({})
end)

-- Must return a confirmed party_id for the UI
RegisterUiCallBack("phone/workforce/party/join", function(data, cb)
    print(data.job_id)
    exports['vx-jobs']:CreateParty(data)
    cb({})
end)