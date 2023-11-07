-- Endpoints for Models
RegisterUiCallBack('clothing/model/set', function(data, cb)
    SetPlayerSkin(data.modelString)
    
    cb(characters)
end)

-- Endpots for Clothing
-- Collect & Return players current texture & drawable ID for componentId
RegisterUiCallBack('clothing/clothes/component/current', function(data, cb)
    cb(GetPlayerComponentData(data.componentId))
end)

-- Update player drawable or texture endpoint.
RegisterUiCallBack('clothing/clothes/component/drawable/set', function(data, cb)
    SetPlayerComponent(data)

    cb({})
end)

-- Endpoints for Accessories
-- Collect & Return players current texture & drawable ID for componentId (accessory)
RegisterUiCallBack('clothing/acessories/component/current', function(data, cb)
    cb(GetPlayerAccessoryData(data.componentId))
end)

-- Update player drawable or texture for componentId (accessory).
RegisterUiCallBack('clothing/acessories/component/drawable/set', function(data, cb)
    SetPlayerAccessory(data)

    cb({})
end)

-- Update player drawable or texture for componentId (accessory).
RegisterUiCallBack('clothing/focus/toggle', function(data, cb)
    exports['vx-nui']:SetUIFocus(not focusToggled, not focusToggled)
    focusToggled = not focusToggled

    cb({})
end)