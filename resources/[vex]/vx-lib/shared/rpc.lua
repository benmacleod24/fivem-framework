--[[
  ::DEPRECATED::
  
  This version of RPC is no longer in use
  Slowly migrating old RPCs
]]

RPC = {}

if IsDuplicityVersion() then
    
    local registered_callbacks = {}
    
    function RPC.Register(name, callback)
        if not registered_callbacks[name] then
            registered_callbacks[name] = callback
            local event = "rpc:" .. name
            RegisterNetEvent(event, function(...)
                local src = source
                registered_callbacks[name](function(...)
                    TriggerClientEvent(event .. "_return", src, ...)
                end, ...)
            end)
        end
    end

else
    
    local registered_callbacks = {}
    
    function RPC.Callback(name, callback, ... )
        local send_event = "rpc:" .. name
        local return_event = "rpc:" .. name .. "_return"
        if not registered_callbacks[return_event] then
            registered_callbacks[return_event] = callback
            RegisterNetEvent(return_event, function(...)
                local cb = registered_callbacks[return_event]
                cb(...)
            end)
        end
        TriggerServerEvent(send_event, ...)
    end
    
    local calls = false

    function RPC.Execute(name, ...)
        while calls do Wait(0) end
        calls = true
        
        p = promise.new()
        
        RPC.Callback(name, function(...)
            p:resolve({...})
        end, ...)

        local promise = Citizen.Await(p)
        calls = false
        return table.unpack(promise)
    end

end
