RegisterNUICallback("characters/get", function(data, cb)
    local characters = RPC.Execute("base:characters:get")

    cb(characters)
end)

RegisterNUICallback("character/get", function(data, cb)
    local character_id = data.character_id
    local characters = RPC.Execute("base:character:get", character_id)

    cb(characters)
end)

RegisterNUICallback("characters/post", function(data, cb)
    local character = RPC.Execute("base:characters:post", data)

    cb(character)
end)

RegisterNUICallback("characters/selected", function(data, cb)
    local data = RPC.Execute("base:characters:select", data.characterId)

    cb(data)
end)