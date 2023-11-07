fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Interact'
version '0.1.0'

shared_scripts {
    "@vx-lib/client/nui.lua",
}

client_scripts {
    "client/contexts.lua",
    "client/main.lua",
    'client/exports.lua',
    'client/entries/object.lua',
}