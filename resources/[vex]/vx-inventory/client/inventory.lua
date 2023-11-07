Inventory = {}

Inventory.CreateInventory = function(inventory)
    local self = inventory

    -- self.id
    -- self.data
    -- self.stacks

    self.Functions = {}

    self.Functions.AddItems = function(item, amount)
        local stacks = RPC.Execute("vx-inventory:items:add", self.data.id, item, amount)
        
        self.Functions.UpdateStacks(stacks)
    end

    self.Functions.RemoveItems = function(item, amount)
        local stacks = RPC.Execute("vx-inventory:items:remove", self.id, item, amount)

        self.Functions.UpdateStacks(stacks)
    end

    self.Functions.MoveItems = function(targetInventory, fromSlot, toSlot, amount)
        local stacks = RPC.Execute("vx-inventory:items:move", self.id, targetInventory, fromSlot, toSlot, amount)

        self.Functions.UpdateStacks(stacks)
    end

    self.Functions.HasItems = function(item, amount)
        return self.Functions.CountItems(item) >= amount
    end
    
    self.Functions.CountItems = function(item)
        local count = 0
    
        for slot, stack in pairs(self.stacks) do
            if item.name == item then
                count = count + stack.amount()
            end
        end
    
        return count
    end

    self.Functions.UpdateStacks = function(stacks)
        self.stacks = stacks

        if INVENTORY_OPEN then
            Inventory.UpdateNui(self.stacks)
        end
    end

    return self
end

Inventory.UpdateNui = function(data)
    exports['vx-nui']:DispatchNui("inventory:left:data", data)
end