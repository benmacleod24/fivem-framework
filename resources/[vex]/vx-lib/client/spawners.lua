-- Create Vehicle (Client)
-- Look into server-side spawning
function CreateClientVehicle(vehicle, coords, heading, opts)
    if (not vehicle or not coords) then return end

    local _vehicle = vehicle
    _vehicle = GetHashKey(_vehicle)

    RequestModel(_vehicle)
    while (not HasModelLoaded(_vehicle)) do
        Wait(0)
    end

    _vehicle = CreateVehicle(_vehicle, coords.x, coords.y, coords.z, heading, 1, 1)
    SetModelAsNoLongerNeeded(GetHashKey(vehicle))
    SetVehicleOnGroundProperly(_vehicle)

    -- Place player in vehicle
    if (opts and opts.placeInVehicle) then
        TaskWarpPedIntoVehicle(PlayerPedId(), _vehicle, -1)
    end

    return _vehicle
end

--[[
    OPTIONS
    flags = vehicle decors
    placeInVehicle = bool
    heading = number
]]
-- Returns Entity ID from Server
function CreateServerVehicle(model, coordinates, options)
    local plate = options.plate or "NULL PLT"
    local placeInVehicle = options.plate or false

    -- Recieve Entity ID from Server
    local vehicle = RPC.Execute("vx-lib:spawners:vehicle:__s__", {
        model = model,
        coordinates = coordinates,
        plate = plate,
        options = options
    })

    local entId = NetworkGetEntityFromNetworkId(vehicle)

    -- Set Decors for Vehicle
    if (options and options.flags) then
        -- Determine decor type
        for k,v in pairs(options.flags) do
            
            if (type(v) == "boolean") then
                DecorSetBool(vehicle, k, v)
            end

            if (type(v) == "number") then
                DecorSetFloat(vehicle, k, v)
            end
        end
    end

    return entId
end

exports('CreateClientVehicle', CreateClientVehicle)
exports('CreateServerVehicle', CreateServerVehicle)