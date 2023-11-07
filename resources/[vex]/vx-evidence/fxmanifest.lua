fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Evidence System'
version '0.1.0'

shared_scripts {
    '@vx-lib/shared/utils.lua',
    "config/main.lua",
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    "server/main.lua"
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    "client/main.lua",
}