function CreateVehicle(netId, model, coordinates, plate, options)

    -- Accept table or vector param for coords
    if (type(coordinates) == "table") then
        coordinates = TableToVector3(coordinates)
    end

    local vehicle = CreateAutomobile(model, coordinates, options.heading or 180.0)

    -- Wait to verify Network props
    while not DoesEntityExist(vehicle) do Wait(0) end
    while NetworkGetEntityOwner(vehicle) < 1 do Wait(0) end

    -- Server-Side Vehicle Options
    SetVehicleNumberPlateText(vehicle, plate)

    return NetworkGetNetworkIdFromEntity(vehicle), vehicle
end

-- RPC for Client Wrapper
RPC.Register("vx-lib:spawners:vehicle:__s__", function(netId, data)
    return CreateVehicle(netId, data.model, data.coordinates, data.plate, data.options)
end)

function CreateAutomobile(model, coordinates, heading)
    return Citizen.InvokeNative(`CREATE_AUTOMOBILE`, model, coordinates, heading)
end