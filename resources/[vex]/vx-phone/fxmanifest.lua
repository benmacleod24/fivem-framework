fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Phone Controller'
version '0.1.0'

shared_scripts {
    "@vx-lib/shared/utils.lua"
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    "server/main.lua",
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    "@vx-lib/client/nui.lua",
    'client/*.lua',
    'client/**/*.lua',
}