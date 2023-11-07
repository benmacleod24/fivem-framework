fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Economy'
version '0.1.0'

shared_scripts {
    '@vx-lib/shared/utils.lua',
    '@vx-lib/shared/better_natives.lua',
    -- '@vx-lib/shared/rpc.lua',
    '@vx-lib/client/nui.lua',
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    "server/cash.lua",
    "server/banking.lua",
    'server/transactions.lua',
    'server/rpcs.lua',
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    'client/banking.lua',
    'client/atm.lua',
}