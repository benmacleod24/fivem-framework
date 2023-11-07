fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Jobs'
version '0.1.0'

shared_scripts {
    -- "@vx-lib/shared/rpc.lua"
}

server_script {
    '@vx-lib/server/rpc.lua',
    'server/character.lua',
    'server/main.lua',
    'server/public.lua',
    'server/private.lua',
    'server/rpcs.lua',
}

client_script {
    '@vx-lib/client/rpc.lua',
    'client/main.lua',
}