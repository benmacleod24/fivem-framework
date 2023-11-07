fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Base'
version '0.1.0'

shared_scripts {
    '@vx-lib/shared/utils.lua',
    -- '@vx-lib/shared/rpc.lua',
}

server_scripts {
    "server/*.lua",
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    '@vx-lib/client/nui.lua',
    '@vx-lib/client/entities.lua',
    'client/*.lua',
    'client/nui/*.lua',
}