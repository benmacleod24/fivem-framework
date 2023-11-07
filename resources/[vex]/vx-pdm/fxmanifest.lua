fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework PDM'
version '0.1.0'

shared_scripts {
    -- '@vx-lib/shared/rpc.lua',
    '@vx-lib/client/nui.lua',
    "shared/*.lua",
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    'server/main.lua',
    'server/stock.lua',
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    'client/main.lua',
    'client/stock.lua',
    'client/clockinon.lua',
}