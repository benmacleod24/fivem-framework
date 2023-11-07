local CurrentResource, Promises, Functions, Identifier = GetCurrentResourceName(), {}, {}, 0
RPC = {}

function ClearPromise(callID)
    Citizen.SetTimeout(5000, function()
        Promises[callID] = nil
    end)
end

function ParamPacker(...)
    local params, pack = {...}, {}
    
    for i = 1, 15, 1 do
        pack[i] = {param = params[i]}
    end
    
    return pack
end

function ParamUnpacker(params, index)
    local idx = index or 1
    
    if idx <= #params then
        return params[idx]["param"], ParamUnpacker(params, idx + 1)
    end
end


function RPC.Register(name, func)
    
    -- Allow for multiple names, migrate to different endpoints
    if (type(name) == 'table') then
        for i = 1, #name do
            Functions[name[i]] = func
        end
        return;
    end

    Functions[name] = func
end

RegisterNetEvent("rpc:request", function(origin, name, callID, params)
    local src = source
    local response
    
    if not Functions[name] then return end
    
    local success, error = pcall(function()
        response = ParamPacker(Functions[name](src, ParamUnpacker(params)))
    end)
    
    if not success then
        TriggerClientEvent("rpc:error", src, CurrentResource, origin, name, error)
    end
    
    if response == nil then
        response = {}
    end
    
    TriggerClientEvent("rpc:response", src, origin, callID, response, true)
end)

function RPC.Execute(src, name, ...)
    local callID, solved = Identifier, false
    Identifier = Identifier + 1
    
    Promises[callID] = promise:new()
    
    TriggerClientEvent("rpc:request", src, CurrentResource, name, callID, ParamPacker(...), true)
    
    SetTimeout(20000, function()
        if not solved then
            Promises[callID]:resolve({nil})
            TriggerEvent("rpc:timeout", CurrentResource, name)
        end
    end)
    
    local response = Citizen.Await(Promises[callID])
    
    solved = true
    
    ClearPromise(callID)
    
    return ParamUnpacker(response)
end

RegisterNetEvent("rpc:response", function(origin, callID, response)
    if CurrentResource == origin and Promises[callID] then
        Promises[callID]:resolve(response)
    end
end)
