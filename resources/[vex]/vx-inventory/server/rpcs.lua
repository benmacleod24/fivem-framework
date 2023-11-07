RPC.Register("vx-inventory:items:add", function(netId, id, item, amount)
    Inventory.AddItems(id, item, amount)

    return Inventories[id].stacks
end)

RPC.Register("vx-inventory:items:remove", function(netId, data)
    Inventory.RemoveItems(data.id, data.item, data.amount)

    return Inventories[data.id].stacks
end)

RPC.Register("vx-inventory:items:move", function(netId, fromId, toId, fromSlot, toSlot, amount)
    Inventory.MoveItems(fromId, toId, fromSlot, toSlot, amount)

    return Inventories[data.id].stacks
end)