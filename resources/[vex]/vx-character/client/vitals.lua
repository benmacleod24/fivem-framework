Hunger = 100
Thirst = 100

-- Decay Rates
HungerDecay = 0.25
ThirstDecay = 0.5
DecayState = ''

IsReady = false
function ManageVitalsThread()
    print('[vx-character] Start vitals thread')

    Tick(function()
        -- When script is not ready
        -- Collect garage (a.k.a destroy thread)
        if (not IsReady) then
            print('[vx-character] ending vitals thread')
            return
        end

        -- Hunger less than 0 knock out player and sync
        -- Else deduct hunger and sync
        if (Hunger <= 0 or (Hunger - HungerDecay <= 0)) then
            TriggerEvent('vx-character:vitals:hunger:gones')
            TriggerServerEvent('vx-character:vitals:sync', 'hunger', 0)
            Hunger = 0
        else
            Hunger = Hunger - HungerDecay
            TriggerServerEvent('vx-character:vitals:sync', 'hunger', Hunger)
        end

        -- Thirst less than 0 knock out player and sync
        -- Else deduct thirst and sync
        if (Thirst <= 0 or (Thirst - ThirstDecay <= 0)) then
            TriggerEvent('vx-character:vitals:thirst:gones')
            TriggerServerEvent('vx-character:vitals:sync', 'thirst', 0)
            Thirst = 0
        else
            Thirst = Thirst - ThirstDecay
            TriggerServerEvent('vx-character:vitals:sync', 'thirst', Thirst)
        end

    end, 30000)

    -- Half Second NUI updates
    Tick(function()
        -- When script is not ready
        -- Collect garage (a.k.a destroy thread)
        if (not IsReady) then
            print('[vx-character] ending vitals thread')
            return
        end

        -- Update health value
        exports['vx-nui']:DispatchNui('nui:hud:status:set', {
        key = 'health',
        value = IsEntityDead(PlayerPedId()) and 0 or (GetEntityHealth(PlayerPedId()) - 100)
        })
    end, 500)

    DecayRateManagement()
end

-- Handle decay rate based on activity
function DecayRateManagement()
    Tick(function()
        if (not IsReady) then return end

        if (IsPedSprinting(PlayerPedId()) or IsPedRunning(PlayerPedId())) then
            HungerDecay = HungerDecay + (HungerDecay * 0.05)
            ThirstDecay = ThirstDecay + (ThirstDecay * 0.02)
            DecayState = 'isSprinting'
        elseif (DecayState == 'isFrozen') then
            HungerDecay = 0
            ThirstDecay = 0
        else
            HungerDecay = 0.25
            ThirstDecay = 0.5
            DecayState = nil
        end

    end, 1200)
end

-- Start Vitals Tick Thread
-- When character selected
RegisterNetEvent('base:character:selected', function(character)
    IsReady = true
    ManageVitalsThread()
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end)

-- Sync from the server side
-- LUA get a fucking switch statement
RegisterNetEvent('vx-character:vitals:sync:__c__', function(vType, value)
    if (vType == 'hunger') then
        Hunger = value
        exports['vx-nui']:DispatchNui('nui:hud:status:set', {
            key = 'hunger',
            value = value
        })
    end

    if (vType == 'thirst') then
        Thirst = value
        exports['vx-nui']:DispatchNui('nui:hud:status:set', {
            key = 'thirst',
            value = value
        })
    end
end)

-- Exports
exports('FreezeVitals', function(status)
    if (status) then DecayState = 'isFrozen' return end
    DecayState = ''
end)