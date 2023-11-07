Entries = {}

Entries[#Entries + 1] = {
    type = "entity",
    group = 2,
    data = {
        id = 'vx-vehicles:keys:give',
        label = 'Give Keys',
        icon = 'fa-solid fa-key'
    },
    options = {
        isEnabled = function(ctx, ent)
            return GetKeysByEntity(ctx.entity)
        end,
        cb = function(_, ctx)
            return GiveKeysToCloesetPlayer(ctx.entity)
        end,
    }
}

Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        if (entry.type == "entity") then
            exports['vx-interact']:AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
        end
    end
end)