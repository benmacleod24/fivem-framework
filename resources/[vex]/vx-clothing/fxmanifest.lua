fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Clothing'
version '0.1.0'

shared_scripts {
    -- "@vx-lib/shared/rpc.lua",
    '@vx-lib/client/nui.lua'
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    "server/main.lua",
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    'config/locations.lua',
    'client/utils.lua',
    "client/main.lua",
    "client/headblend.lua",
    "client/nui.lua",
}