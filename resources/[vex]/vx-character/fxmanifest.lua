fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Character Data'
version '0.1.0'

shared_scripts {
    -- "@vx-lib/shared/rpc.lua",
    "@vx-lib/shared/utils.lua",
    '@vx-lib/client/nui.lua'
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    "server/cache.lua",
    "server/cuffing.lua",
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    "@vx-lib/client/player.lua",
    'client/vitals.lua',
    'client/cuffing.lua',
    "client/loops.lua",
    "client/radar.lua"
}
   