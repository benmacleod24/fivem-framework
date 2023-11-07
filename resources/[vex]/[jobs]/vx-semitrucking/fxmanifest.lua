fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Base'
version '0.1.0'

shared_scripts {
    "@vx-lib/shared/rpc.lua",
    "@vx-lib/shared/utils.lua",
}

client_scripts {
    'client/*.lua'
}