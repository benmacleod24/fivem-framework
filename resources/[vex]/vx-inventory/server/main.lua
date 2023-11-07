Inventories = {}

function GetInventory(id)
    local self = {}

    self.id = id
    self.data = exports.oxmysql:singleSync("SELECT * FROM fivem_inventories WHERE id = ?", { id })
    self.items = exports.oxmysql:fetchSync("SELECT * FROM fivem_inventories_items WHERE id = ?", { id })

    if self.data == nil then
        return nil
    end

    return self
end

function FormatInventory(inventory)
    local self = {}

    self.stacks = {}
    self.data = inventory.data

    for i = 1, #inventory.items, 1 do
        local item = inventory.items[i]

        if self.stacks[item.slot] == nil then
            self.stacks[item.slot] = {}
        end

        item.data = json.decode(item.data)

        self.stacks[item.slot][item.order] = item
    end

    return self
end

function CheckInventory(id)
    if Inventories[id] == nil then
        local inventory = GetInventory(id)

        if inventory == nil then
            return 0
        end

        Inventories[id] = FormatInventory(inventory)
    end

    return Inventories[id]
end

function SaveInventory(id)

end

function CreateInventory(id, type, owner, createdBy)
    type = Config.Types[type]

    local query = "INSERT INTO fivem_inventories (id, owner, slots, type, max_weight, created_by) VALUES (?, ?, ?, ?, ?, ?)"
    local inventory = exports.oxmysql:insertSync(query, {id, owner, type.slots, type.id, type.max_weight, createdBy or 0})

    return inventory
end

function CalculateWeight(items)
    local weight = 0

    for i = 1, #items, 1 do
        weight = weight + items[i].weight
    end

    return weight
end


AddEventHandler("base:character:created", function(character_id)
    CreateInventory("char:"..character_id, "player", character_id)
end)

AddEventHandler("base:character:selected", function(character)
    local inventory = CheckInventory("char:" .. character.characterId)

    TriggerClientEvent("vx-inventory:character:selected", character.netId, character, inventory)
end)

AddEventHandler("base:character:dropped", function(netId)
    -- can't do fuck all with just the netId
    -- why not include the character id if one was selected???
end)