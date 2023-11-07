Config = {}
Config.Types = {}

Config.Items = {}
Config.ItemsLookup = {}

Citizen.CreateThread(function() 
    local types = exports.oxmysql:fetchSync("SELECT * FROM config_inventory_types")
    for i = 1, #types, 1 do
        local type = types[i]

        Config.Types[type.id] = type
    end


    local items = exports.oxmysql:fetchSync("SELECT * FROM config_inventory_items")
    for i = 1, #items, 1 do
        local item = items[i]

        -- decode array of alias strings
        item.aliases = json.decode(item.aliases)

        -- store the actual item in the items table
        Config.Items[item.id] = item

        -- first add the actual item name to the lookup table
        Config.ItemsLookup[item.name] = Config.Items[item.id]
        for a = 1, #item.aliases, 1 do
            local alias = item.aliases[i]

            -- Store a reference to the actual item using the alias in the lookup table
            Config.ItemsLookup[alias] = Config.Items[item.name]
        end
    end
end)

RegisterCommand("items", function()
    print(json.encode(Config.Items))
end)