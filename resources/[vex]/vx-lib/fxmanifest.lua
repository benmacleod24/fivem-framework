fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Lib'
version '0.1.0'

shared_scripts {
    "shared/console.lua",
    "shared/rpc.lua",
    "shared/utils.lua",
    "shared/better_natives.lua",
}

server_scripts {
    'server/rpc.lua',
    'server/identifiers.lua',
    'server/spawners.lua',
    'server/discord.lua',
    'server/dbUtils.lua',
    'server/logs.lua',
}

client_scripts {
    'client/rpc.lua',
    'client/entities.lua',
    'client/spawners.lua',
    'client/disablers.lua',
    'client/nui.lua',
    "client/player.lua",
}