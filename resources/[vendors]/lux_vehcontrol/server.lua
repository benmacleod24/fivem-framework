--[[
---------------------------------------------------
LUXART VEHICLE CONTROL (FOR FIVEM)
---------------------------------------------------
Last revision: NOV 07 2016
Coded by Lt.Caine
---------------------------------------------------
NOTES

---------------------------------------------------
]]

RegisterNetEvent("lvc_TogDfltSrnMuted_s", function(toggle, list)
    for _, v in pairs(list) do
        TriggerClientEvent("lvc_TogDfltSrnMuted_c", v.src, source, toggle)
    end
end)

RegisterNetEvent("lvc_SetLxSirenState_s", function(newstate, list)
    for _, v in pairs(list) do
        TriggerClientEvent("lvc_SetLxSirenState_c", v.src, source, newstate)
    end
end)

-- RegisterNetEvent("lvc_TogPwrcallState_s", function(toggle, list)
--     for _, v in pairs(list) do
--         TriggerClientEvent("lvc_TogPwrcallState_c", v.src, source, toggle)
--     end
-- end)

RegisterNetEvent("lvc_SetAirManuState_s", function(newstate, list)
    for _, v in pairs(list) do
        TriggerClientEvent("lvc_SetAirManuState_c", v.src, source, newstate)
    end
end)

RegisterNetEvent("lvc_TogIndicState_s", function(newstate, list)
    for _, v in pairs(list) do
        TriggerClientEvent("lvc_TogIndicState_c", v.src, source, newstate)
    end
end)
