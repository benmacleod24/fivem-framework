HEAD_BLEND = {}

function SetHeadBlend(data)
    GetHeadBlendData(PlayerPedId())
    local shapeFirstID = data.shapeFirstID or HEAD_BLEND.shapeFirstID
    local shapeSecondID = data.shapeSecondID or HEAD_BLEND.shapeSecondID
    local shapeThirdID = data.shapeThirdID or HEAD_BLEND.shapeThirdID

    local skinFirstID = data.skinFirstID or HEAD_BLEND.skinFirstID
    local skinSecondID = data.skinSecondID or HEAD_BLEND.skinSecondID
    local skinThirdID = data.skinThirdID or HEAD_BLEND.skinThirdID

    local shapeMix = data.shapeMix or HEAD_BLEND.shapeMix
    local skinMix = data.skinMix or HEAD_BLEND.skinMix
    local thirdMix = data.thirdMix or HEAD_BLEND.thirdMix

    SetPedHeadBlendData(PlayerPedId(), shapeFirstID, shapeSecondID, shapeThirdID, skinFirstID, skinSecondID, skinThirdID, shapeMix, skinMix, thirdMix, false)
end

-- Get Head Blend data
function GetHeadBlendData(ped)
    local data = {Citizen.InvokeNative(0x2746BD9D88C5C5D0, ped, Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0))}

    HEAD_BLEND = {
        shapeFirstID = data[1],
        shapeSecondID = data[2],
        shapeThirdID = data[3],
        skinFirstID = data[4],
        skinSecondID = data[5],
        skinThirdID = data[6],
        shapeMix = data[7],
        skinMix = data[8],
        thirdMix = data[9],
    }

    return HEAD_BLEND
end

RegisterNetEvent('nui:application:opened')
AddEventHandler('nui:application:opened', function(app)
    if (app ~= 'clothing') then return end
    GetHeadBlendData(PlayerPedId())
end)

RegisterUiCallBack('clothing/headblend/set', function(data, cb)
    SetHeadBlend(data)

    cb({})
end)

RegisterUiCallBack('clothing/headblend/get', function(data, cb)
    local headBlendData = GetHeadBlendData(PlayerPedId())
    local rtData = {}

    if (data.value:find('Mix')) then
        rtData[data.value] = (exports['vx-lib']:round(headBlendData[data.value], 2) * 100)
    else
        rtData.shapeId = headBlendData["shape"..data.value]
        rtData.skinId = headBlendData["skin"..data.value] 
    end

    cb(rtData)
end)