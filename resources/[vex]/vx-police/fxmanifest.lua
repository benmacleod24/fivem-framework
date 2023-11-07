fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Police Systems'
version '0.1.0'

shared_scripts {
    "@vx-lib/shared/utils.lua",
    "config/menus.lua",
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    'server/clockinout.lua',
    "server/actions.lua"
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    'client/main.lua',
    'client/binds.lua',
}