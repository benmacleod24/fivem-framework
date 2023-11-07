SHOW_ENTITIES = false

function ToggleShowEntities(value)
    SHOW_ENTITIES = value
    return SHOW_ENTITIES
end

-- Citizen Thread
-- Draw lines
Tick(function()
        if (SHOW_ENTITIES) then
            
            -- Objects
            for obj in EnumerateObjects() do
                if GetDistanceBetweenCoords(GetEntityCoords(obj), GetEntityCoords(PlayerPedId())) < 10 then
                    local info = EntityInfo(obj)
                    local text = string.format("Model:~o~ %i \nEntity:~o~ %i \n~w~X: ~c~%.3f \n~w~Y:~c~ %.3f \n~w~Z:~c~ %.3f \n~w~H:~c~ %.3f", info.model, obj,info.x, info.y, info.z, info.h)
                    DrawText3D(info.x, info.y, info.z, {255, 255, 255, 200}, 0.3, text)
                end
            end

            -- Vehicles
            for obj in EnumerateVehicles() do
                if GetDistanceBetweenCoords(GetEntityCoords(obj), GetEntityCoords(PlayerPedId())) < 10 then
                    local info = EntityInfo(obj)
                    local text = string.format("Model:~o~ %i \n~w~X: ~c~%.3f \n~w~Y:~c~ %.3f \n~w~Z:~c~ %.3f \n~w~H:~c~ %.3f", info.model, info.x, info.y, info.z, info.h)
                    DrawText3D(info.x, info.y, info.z, {255, 255, 255, 200}, 0.3, text)
                end
            end

            -- Peds
            for obj in EnumeratePeds() do
                if GetDistanceBetweenCoords(GetEntityCoords(obj), GetEntityCoords(PlayerPedId())) < 10 then
                    local info = EntityInfo(obj)
                    local text = string.format("Model:~o~ %i \n~w~X: ~c~%.3f \n~w~Y:~c~ %.3f \n~w~Z:~c~ %.3f \n~w~H:~c~ %.3f", info.model, info.x, info.y, info.z, info.h)
                    DrawText3D(info.x, info.y, info.z, {255, 255, 255, 200}, 0.3, text)
                end
            end
        else
            Wait(500)
        end
end, 5)

exports('ToggleShowEntities', ToggleShowEntities)