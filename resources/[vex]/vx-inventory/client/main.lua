INVENTORY_OPEN = false
INVENTORY_PLAYER = nil

RegisterNetEvent("vx-inventory:character:selected", function(character, inventory)
    INVENTORY_PLAYER = Inventory.CreateInventory(inventory)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        DisableControlAction(0, 37, true)

        if IsDisabledControlJustPressed(0, 37) then
            exports['vx-nui']:DispatchNui("nui:inventory:left", INVENTORY_PLAYER)
        
            TriggerScreenblurFadeIn(1000)
            exports['vx-nui']:OpenApplication("inventory", true)
        end
    end
end)

AddEventHandler('nui:application:close', function(app)
    if (app ~= 'inventory') then return end
    INVENTORY_OPEN = false
    TriggerScreenblurFadeOut(1*1000)
end)

RegisterCommand("inv", function()
    print(json.encode(INVENTORY_PLAYER.data))
    print(json.encode(INVENTORY_PLAYER.stacks), "::STACKS::")
end)

RegisterCommand("add", function(net_id, args)
    INVENTORY_PLAYER.Functions.AddItems(args[1], 2)
    Wait(2000)
    print(json.encode(INVENTORY_PLAYER.stacks))
end)

RegisterUiCallBack("inventory/move-item", function(data, cb)
    if (data.inventoryType == "player") then
        INVENTORY_PLAYER.Functions.MoveItems(data.toInventory, data.fromSlot, data.toSlot, 1)
    end
end)