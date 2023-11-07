fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Base'
version '0.1.0'

server_script "@vx-lib/server/rpc.lua"
client_script "@vx-lib/client/rpc.lua"

server_scripts {
    "server/main.lua"
}

client_scripts {
    "client/config.lua",
    "client/main.lua",
    'client/menu.lua',
}