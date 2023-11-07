Inventory.Stacks = {}

--[[ STACK DATA
    config: object      | Item config from the Config.Items table
    items: array        | Array of item objects
    amount: number      | Returns the count of the item array
    weight: number      | Combine calculated weight of all items in the stack
]]
Inventory.Stacks.CreateStack = function(config)
    local stack = {}

    print("Attemping to print stack")

    stack.config = config
    stack.items = {}
    stack.weight = CalculateWeight(stack.items)
    stack.amount = #stack.items

    return stack
end

-- Add item to stack
Inventory.Stacks.AddItem = function(stack, item)
    -- Return false if we are already at the max stack size
    if (stack.amount() >= stack.config.max) then
        return false
    end

    print("all good to add")

    table.insert(stack.items, item)
    stack =  Inventory.Stacks.Sort(stack)

    return true
end

-- Add items to stack returning any items that were not added
Inventory.Stacks.AddItems = function(stack, items)
    local overflowItems = {}

    for i = 1, #items, 1 do
        local success = Inventory.Stacks.AddItem(stack, items[i])

        if not success then
            table.insert(overflowItems, items[i])
        end
    end

    return overflowItems
end

-- function Inventory.Stacks.AddItems(stack, items)
--     local overflowItems = {}

--     for i = 1, #items, 1 do
--         local success = Inventory.Stacks.AddItem(stack, items[i])

--         if not success then
--             table.insert(overflowItems, items[i])
--         end
--     end

--     return overflowItems
-- end

-- Remove item and return removed item
Inventory.Stacks.RemoveItem = function(stack)
    stack = Inventory.Stacks.Sort(stack)

    local item = table.remove(stack.items, 1)

    return item
end

-- Remove items and return array of removed items
Inventory.Stacks.RemoveItems = function(stack, amount)
    local items = {}

    for i = 1, amount, 1 do
        local item =  Inventory.Stacks.RemoveItem(stack)

        table.insert(items, item)
    end

    return items
end

-- Remove item and forget about it
Inventory.Stacks.DeleteItem = function(stack)
    stack =  Inventory.Stacks.Sort(stack)

    table.remove(stack, 1)
end

-- Remove multiple items and forget about them
Inventory.Stacks.DeleteItems = function(stack, amount)
    for i = 1, amount, 1 do
        Inventory.Stacks.RemoveItem(stack)
    end
end

-- Sort stack by durability so the first item in the stack is always the lowest durability item
Inventory.Stacks.Sort = function(stack)
    table.sort(stack.items, function(a,b)
        return a["durability"] < b["durability"]
    end)

    return stack
end