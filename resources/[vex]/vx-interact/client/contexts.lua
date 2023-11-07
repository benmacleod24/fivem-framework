function GetEntityContext(entity)
    local context = {
        model = nil,
        flags = {},
        isDead = false,
        type = 0
    }

    context.type = GetEntityType(entity)
    context.isDead = IsEntityDead(entity)
    context.model = GetEntityModel(entity)
    context.entity = entity

    return context
end