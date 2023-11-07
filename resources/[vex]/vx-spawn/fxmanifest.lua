fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Base'
version '0.1.0'

shared_scripts {
    -- "@vx-lib/shared/rpc.lua",
    "sh_config.lua"
}

client_scripts {
    '@vx-lib/client/rpc.lua',
    '@vx-lib/client/nui.lua',
    'client/cl_spawn.lua'
}