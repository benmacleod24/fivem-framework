Inventory.Items = {}

--[[ ITEM DATA
    uuid: string        | Unique identifier for this individual item
    name: string        | Item name
    durability: number  | Item durability or -1 for disabled
    weight: number      | Item weight
]]
Inventory.Items.CreateItem = function(config)
    local self = {}

    self.uuid = GenerateUUID()
    self.name = config.name
    self.durability = config.durability and 100 or -1
    self.created = os.time()
    self.weight = config.weight

    return self
end

Inventory.Items.CreateItems = function(config, amount)
    local items = {}

    for i = 1, amount, 1 do
        local item = Inventory.Items.CreateItem(config)

        table.insert(items, item)
    end

    return items
end

Inventory.Items.CheckItem = function(item)
    if Config.Items[item] == nil then 
        return false
    end

    return true
end