RegisterNetEvent("character:loops:cuffed", function()
    if (not IS_CUFFED) then return end

    Citizen.CreateThread(function()
        while (IS_CUFFED) do
            
            -- Disable all keys that need be when cuffed
            DisableControlAction(0, 311, true)-- K
            DisableControlAction(0, 172, true)-- Up Arrow
            DisableControlAction(0, 173, true)-- down Arrow
            DisableControlAction(0, 174, true)-- left Arrow
            DisableControlAction(0, 175, true)-- right Arrow
            DisableControlAction(0, 63, false)-- Disables vehicle Left
            DisableControlAction(0, 64, false)-- Disables vehicle right
            DisableControlAction(0, 59, false)-- Disables vehicle reverse
            DisableControlAction(0, 278, false)
            DisableControlAction(0, 279, false)
            DisableControlAction(0, 75, true)-- Vehicle exit
            DisableControlAction(1, 23, true)-- F
            DisableControlAction(0, 25, true)-- right click
            DisableControlAction(1, 106, true)-- VehicleMouseControlOverride
            DisableControlAction(1, 263, true)--Disables Melee Actions
            DisableControlAction(1, 140, true)--Disables Melee Actions
            DisableControlAction(1, 141, true)--Disables Melee Actions
            DisableControlAction(1, 142, true)--Disables Melee Actions
            DisableControlAction(1, 37, true)--Disables INPUT_SELECT_WEAPON (tab) Actions
            DisablePlayerFiring(PlayerId(), true)-- Disable weapon firing

            -- Make sure they have no weapon out
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            -- Place them in handcuffed anim
            -- Purely for RP Sake
            if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3)) or (IsPedRagdoll(PlayerPedId())) then
                TaskAnim("mp_arresting", "idle", cuffState, 8.0)
            end

            Citizen.Wait(0)
        end
    end)
end)