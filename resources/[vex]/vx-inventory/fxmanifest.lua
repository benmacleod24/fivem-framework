fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'Ben Macleod, [PXA] Adam'
description 'VEX Framework Inventory'
version '0.1.0'

shared_scripts {
    "@vx-lib/shared/better_natives.lua",
}

server_script {
    "@vx-lib/server/rpc.lua",
    '@vx-lib/server/dbUtils.lua',
    "shared/utils.lua",
    'config.lua',
    'server/inventory.lua',
    'server/stacks.lua',
    'server/items.lua',
    'server/main.lua',
    'server/rpcs.lua'
}

client_script {
    "@vx-lib/client/rpc.lua",
    "@vx-lib/client/nui.lua",
    'client/inventory.lua',
    'client/main.lua'
}