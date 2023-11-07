-- Setter function for Clothing Components
function SetPlayerComponent(data)
    local ped = PlayerPedId()
    local componentId = data.componentId
    local drawableId = data.drawableId
    local textureId = data.textureId or 0

    -- Special texture setting for hair
    if (componentId == 2) then
        SetPedComponentVariation(ped, componentId, drawableId, 0, 1)
        SetPedHairColor(ped, 0, 0)
    end

    SetPedComponentVariation(ped, componentId, drawableId, textureId, 1)
end

-- Setter Function for Accories
function SetPlayerAccessory(data)
    local componentId = data.componentId
    local drawableId = data.drawableId
    local textureId = data.textureId or 0

    SetPedPropIndex(PlayerPedId(), componentId, drawableId, textureId, false)
end

-- Set Player Model
-- Grab any values that need to be persisted over after model change
function SetPlayerSkin(modelString)
    local model = GetHashKey(modelString)

    SetEntityInvincible(PlayerPedId(), true)
    if (IsModelInCdimage(model) and IsModelValid(model)) then

        -- Wait for Model to load
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Citizen.Wait(0)
        end

        -- Set players new ped
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        -- Grab players new Ped
        player = PlayerPedId()

        -- Post ped options
        SetPedMaxHealth(player, 200)
        SetPedDefaultComponentVariation(player)
        SetEntityHealth(player, GetEntityMaxHealth(player))
        SetEntityInvincible(player, false)
        SetPedHeadBlendData(player, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0, false)

    end

end

-- GET function for Clothing
-- Returns the current drawableId & textureId of component
-- Along with the maximum vales
function GetPlayerComponentData(componentId)
    local drawableId = GetPedDrawableVariation(PlayerPedId(), componentId)
    local textureId = GetPedTextureVariation(PlayerPedId(), componentId)
    local drawableMax = GetNumberOfPedDrawableVariations(PlayerPedId(), componentId)
    local textureMax = GetNumberOfPedTextureVariations(PlayerPedId(),componentId, drawableId)
    
    return {
        drawableId = drawableId,
        textureId = textureId,
        drawableMax = drawableMax,
        textureMax = textureMax,
    }
end

-- GET Function for Accessories
-- Current collection for existing ped props (accessories)
-- Returns propId & textureId along with maximum values
function GetPlayerAccessoryData(componentId)
    local drawableId = GetPedPropIndex(PlayerPedId(), componentId)
    local drawableMax = GetNumberOfPedPropDrawableVariations(PlayerPedId(), componentId)
    local textureId = GetPedPropTextureIndex(PlayerPedId(), componentId)
    local textureMax = GetNumberOfPedPropTextureVariations(PlayerPedId(), componentId, drawableId)

    return {
        drawableId = drawableId,
        textureId = textureId,
        drawableMax = drawableMax,
        textureMax = textureMax,
    }
end

-- Save players clothing
-- Needs to be updated to save everything in the DB
-- Might make a net function and send it to other parts of resource
function SavePlayerClothes()
    clothes = {}

    for i = 0, 11 do
        local data = GetPlayerComponentData(i)
        data.componentId = i
        table.insert(clothes, data)
    end

    TriggerServerEvent('vx-clothing:save', clothes)
end
RegisterCommand('clothing:save', SavePlayerClothes)

RegisterNetEvent('vx-clothing:load')
AddEventHandler('vx-clothing:load', function(clothingData)
    local clothes = json.decode(clothingData.clothes)
    SetPlayerSkin("mp_m_freemode_01")

    for k,v in pairs(clothes) do
        SetPlayerComponent(v)
    end
end)