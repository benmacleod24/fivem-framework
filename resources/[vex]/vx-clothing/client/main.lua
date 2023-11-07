inClothing = false
focusToggled = false
CurrentZone, ZoneData, ZoneCenter, NotifyClear = false, nil, nil, nil


-- Want to let client know they are in the clothing menu
-- Also want to trigger listener loops
function OpenClothingStore()

    print(CurrentZone, ZoneData)

    -- Make sure they are in a clothing store
    if (not CurrentZone or not ZoneData or not ZoneData.isClothingStore) then
        return
    end


    inClothing = true
    focusToggled = true
    
    TriggerClothingLoops()
    exports['vx-nui']:OpenApplication("clothing", true)
end

-- Trigger the loops when the clothing store is open
-- Will fall off when no longer in the clothing store
function TriggerClothingLoops()
    if (not inClothing) then return end

    -- Listens for refocusing the NUI
    -- Uses right click (25)
    Citizen.CreateThread(function()
        while (inClothing) do
            if (IsDisabledControlJustReleased(0, 25)) then
                print("running")
                exports['vx-nui']:SetUIFocus(not focusToggled, not focusToggled)
                focusToggled = not focusToggled
            end
            Citizen.Wait(0)
        end
    end)

    -- Used to disable the cinematic camera
    Citizen.CreateThread(function() 
        while (inClothing) do
          N_0xf4f2c0d4ee209e20() 
          Wait(30 * 1000)
        end 
      end)

end

-- Want to reset the clothing store once exited
-- Or they will be allowed to right click focus
AddEventHandler("nui:application:close", function(app)
    if (app ~= "clothing") then return end

    inClothing = false
    focusToggled = false
end)

-- Managing zones events
AddEventHandler('vx-zones:enter', function(name, data, center)
    if (not data or not data.isClothingStore) then return end

    CurrentZone = name
    ZoneData = data
    ZoneCenter = center
end)

AddEventHandler('vx-zones:exit', function(name, data)

    -- Make sure the zone is a clothing store & app is clothing
    -- Close application and cancel changes
    if (data.isClothingStore and exports['vx-nui']:GetOpenApplication() == "clothing") then
        exports['vx-nui']:CloseApplication()
    end

    CurrentZone = false
    ZoneData = nil
    ZoneCenter = nil
    NotifyClear = nil
end)

-- TEMP Command
RegisterCommand("clothing", OpenClothingStore)

exports('SetPlayerComponent', SetPlayerComponent)
exports('GetPlayerComponentData', GetPlayerComponentData)
exports('SetPlayerSkin', SetPlayerSkin)