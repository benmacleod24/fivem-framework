Citizen.CreateThread(function ()
    Citizen.Wait(3000)
    local Id = PlayerId()

    -- Disable Dispatch
    for i = 1, 12 do
        EnableDispatchService(i, false)
    end

    SetMaxWantedLevel(0)
    DisablePlayerVehicleRewards(Id)
    SetPoliceIgnorePlayer(Id, true)
    SetDispatchCopsForPlayer(Id, false)
    NetworkSetFriendlyFireOption(true)

    while true do
        Citizen.Wait(50)
        DistantCopCarSirens(false)
    end
end)

-- Remove Cop Cars
Citizen.CreateThread(function()

    local policeStations = {
        {448.11700439453, -989.46789550781, 36.872337341309},
        {408.29452514648, -1010.8471069336, 29.40022277832},
        {389.33413696289, -1617.9036865234, 29.292037963867},
        {607.42175292969, 32.037746429443, 89.872505187988},
        {-563.53424072266, -148.22227478027, 38.021312713623},
        {-1084.1278076172, -869.61065673828, 4.8677096366882},
        {1850.9304199219, 3673.8796386719, 33.76496887207},
        {-454.33511352539, 6026.9291992188, 31.340545654297},
        {831.046875, -1265.5634765625, 26.282810211182},
        {-903.61413574219, -2399.2900390625, 14.02402973175},
        {577.630859375, 39.161876678467, 92.883888244629},
        {647.72991943359, -30.919246673584, 80.535133361816},
        {505.38928222656, 20.472354888916, 90.528076171875},
        {837.36755371094, -1342.7598876953, 26.353876113892},
        {381.22305297852, 796.85235595703, 187.51217651367},
        {-1626.5748291016, -1014.4693989258, 12.7056016922},
        {-2999.2607421875, 712.9892578125, 28.496892929077},
        {-1190.0573730469, -889.47595214844, 13.990588188171},
        {-1234.2989501953, -275.5940246582, 37.764163970947},
        {852.74029541016, -1393.3537597656, 26.134502410889},
        {431.6842956543, -531.0166015625, 28.848300933838},
        {385.68316650391, -603.31665039063, 29.457193374634},
        {132.68, -1074.754, 29.192},
    }
    
    while true do
        Wait(100)
        for i = 1, #policeStations do
            if Vdist(policeStations[i][1], policeStations[i][2], policeStations[i][3], GetEntityCoords(PlayerPedId())) < 300.0 then
                RemoveVehiclesFromGeneratorsInArea(policeStations[i][1] - 50.0, policeStations[i][2] - 50.0, policeStations[i][3] - 50.0, policeStations[i][1] + 50.0, policeStations[i][2] + 50.0, policeStations[i][3] + 50.0)
            end
        end
    end
end)

-- Disable Certain Cars
CreateThread(function()
    local suppressed_vehicles = {
        "police",
        "police2",
        "police3",
        "police4",
        "policeb",
        "policet",
        "sheriff",
        "sheriff2",
        "firetruck",
        "blimp",
        "adder",
        'zentorno',
        'turismor',
        'infernus',
        'bullet',
        'jester',
        "rhino",
        "polmav",
        "buzzard2",
        "cargobob",
        'barracks',
        'barracks2',
        'crusader',
        "shamal",
        "luxor",
        "luxor2",
        "jet",
        "lazer",
        "titan",
        "cargoplane",
        "rhino",
        "hydra",
    }

    local SCENARIO_GROUPS = {
        2017590552, -- LSIA planes
        2141866469, -- Sandy Shores planes
        1409640232, -- Grapeseed planes
        "ng_planes", -- Far up in the skies jets
    }
    local SCENARIO_TYPES = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
        "WORLD_VEHICLE_MILITARY_PLANES_BIG", -- Zancudo Big Planes
    }
    
    while true do
        Wait(5000)
        for _, model in pairs(suppressed_vehicles) do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end
        
        for _, scgrp in next, SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        
        for _, sctyp in next, SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
    end
end)

-- Disable HUD Components
Citizen.CreateThread(function()
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)

    while true do
        --
        -- 1 : WANTED_STARS
        -- 2 : WEAPON_ICON
        -- 3 : CASH
        -- 4 : MP_CASH
        -- 5 : MP_MESSAGE
        -- 6 : VEHICLE_NAME
        -- 7 : AREA_NAME
        -- 8 : VEHICLE_CLASS
        -- 9 : STREET_NAME
        -- 10 : HELP_TEXT
        -- 11 : FLOATING_HELP_TEXT_1
        -- 12 : FLOATING_HELP_TEXT_2
        -- 13 : CASH_CHANGE
        -- 14 : RETICLE
        -- 15 : SUBTITLE_TEXT
        -- 16 : RADIO_STATIONS
        -- 17 : SAVING_GAME
        -- 18 : GAME_STREAM
        -- 19 : WEAPON_WHEEL
        -- 20 : WEAPON_WHEEL_STATS
        -- 21 : HUD_COMPONENTS
        -- 22 : HUD_WEAPONS
        --
        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        -- HideHudComponentThisFrame(5)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(10)
        HideHudComponentThisFrame(11)
        HideHudComponentThisFrame(12)
        HideHudComponentThisFrame(13)
        HideHudComponentThisFrame(14)
        HideHudComponentThisFrame(15)
        --HideHudComponentThisFrame(16)
        HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(18)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        -- HideHudComponentThisFrame(21)
        -- HideHudComponentThisFrame(22)

        HudWeaponWheelIgnoreSelection()  -- CAN'T SELECT WEAPON FROM SCROLL WHEEL
        DisableControlAction(0, 37, true)

        

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)