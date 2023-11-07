fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Inventory'
version '0.1.0'

shared_scripts {
    -- "@vx-lib/shared/rpc.lua",
    "@vx-lib/shared/better_natives.lua",
}

server_script {
    "@vx-lib/server/rpc.lua",
    'server/main.lua',
}

client_script {
    "@vx-lib/client/rpc.lua",
    'client/main.lua',
}