Inventory = {}

Inventory.AddItems = function(id, item, amount)

    -- Check if item exists before caching inventory
    if not Inventory.Items.CheckItem(item) then
        return false
    end

    local config = Config.Items[item]

    -- Retrieve the inventory from the cache
    local inventory = CheckInventory(id)

    -- Generate the new items
    local items = Inventory.Items.CreateItems(config, amount)

    for slot, stack in pairs(inventory.stacks) do
        -- Only try to add items to stacks of the same item
        if stack.config.name == item then
            items = Inventory.Stacks.AddItems(stack, items)
        end

        -- break the loop if all the items have been added
        if #items <= 0 then
            break
        end
    end
    -- If there are still more items to add, try creating new stacks
    if #items > 0 then
        while #items > 0 do
            local slot = Inventory.FindFirstEmptySlot(inventory)

            -- If slot is -1 then there are no free slots available and we can continue
            if slot == -1 then
                break
            end

            -- Create new stack
            local stack = Inventory.Stacks.CreateStack(config)

            print(json.encode(stack), "::NEW STACK::")
            
            -- Add as many items as possible to the new stack
            items = Inventory.Stacks.AddItems(stack, items)

            print(json.encode(items), "::NEW ITEMS::")

            -- Set the stack into the free slot of the inventory
            inventory.stacks[slot] = stack

            print(json.encode(inventory))
        end
    end

    -- If there are still items that could not be added, drop them on the ground
    Inventory.DropItems(items)
end

Inventory.RemoveItems = function(id, item, amount)
     -- Retrieve the inventory from the cache
     local inventory = CheckInventory(id)

     -- Actually store the amountRemoved as it's faster than doing #removedItems tons of times
     local amountRemoved = 0
     local removedItems = {}
        
     for slot, stack in pairs(inventory.stacks) do
         if stack.config.name == item then
            local items = Inventory.Stacks.RemoveItems(stack, amount - amountRemoved)

            for i = 1, #items, 1 do
                table.insert(removedItems, items[i])
            end

            if stack.amount() <= 0 then
                inventory.stacks[slot] = nil
            end

            amountRemoved = amountRemoved + #items
         end

         if amountRemoved == amount then
            break
         end
     end

     -- return the removed items, just do #removedItems for the amount
     return removedItems
end

Inventory.MoveItems = function(fromId, toId, fromSlot, toSlot, amount)
    local fromInventory = CheckInventory(fromId)
    local toInventory = CheckInventory(toId)

    -- If the from inventory slot has nothing then we have nothing to move
    if fromInventory.stacks[fromSlot] == nil then
        return
    end

    local fromStack = fromInventory.stacks[fromSlot]

    -- Remove the items from the from slot in the from inventory
    local items = Inventory.Stacks.RemoveItems(fromStack, amount)

    -- If the to slot in the to inventory has a stack then retrieve that if not create one
    local toStack
    if toInventory.stacks[toSlot] == nil then
        toStack = Inventory.Stacks.CreateStack(fromStack.config)
    else
        toStack = toInventory.stacks[toSlot]
    end

    -- Add as many items to the to slot stack as possible
    items = Inventory.Stacks.AddItems(toStack, items)

    -- Any items that could not be moved must be put back
    if #items > 0 then
        Inventory.Stacks.AddItems(fromStack, items)
    end

    -- Update the stacks in the inventory slots
    fromInventory.stacks[fromSlot] = fromStack
    toInventory.stacks[toSlot] = toStack
end

Inventory.HasItems = function(id, item, amount)
    return Inventory.CountItems(id, item) >= amount
end

Inventory.CountItems = function(id, item)
    local inventory = CheckInventory(id) 

    local count = 0

    for slot, stack in pairs(inventory.stacks) do
        if item.name == item then
            count = count + stack.amount()
        end
    end

    return count
end

-- Find the first empty stack slot in the inventory returning -1 if none exist
Inventory.FindFirstEmptySlot = function(inventory)
    for i = 1, inventory.data.slots, 1 do
        if inventory.stacks[i] == nil then
            return i
        end
    end

    return -1
end

Inventory.DropItems = function(items)

end