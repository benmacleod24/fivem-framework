fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Weather'
version '0.1.0'

shared_scripts {
    -- "@vx-lib/shared/rpc.lua",
    "@vx-lib/shared/utils.lua"
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    "server/config.lua",
    "server/time.lua",
    "server/weather.lua",
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    "client/main.lua"
}