fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Economy'
version '0.1.0'

shared_scripts {
    '@vx-lib/shared/utils.lua',
    -- '@vx-lib/shared/rpc.lua',
    'shared/sh_config.lua',
    "shared/parking_spots.lua",
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    "server/main.lua"
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    'client/utils.lua',
    "client/main.lua",
}