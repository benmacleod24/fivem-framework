Entries = {}

Entries[#Entries + 1] = {
    group = 3,
    data = {
        id = 'vx:dev:get_model',
        label = 'Get Model Info',
        icon = 'fa-solid fa-terminal'
    },
    options = {
        isEnabled = function(context, ent)
            return true
        end,
        cb = function(data)
            print(json.encode(data))
        end,
    }
}

Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        exports['vx-interact']:AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
    end
end)