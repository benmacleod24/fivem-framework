fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Base'
version '0.1.0'

shared_scripts {
    "@vx-lib/shared/utils.lua",
}

server_scripts {
    "@vx-lib/server/rpc.lua",
    "server/sv_user.lua",
    "server/sv_users.lua",
    "server/sv_character.lua",
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    "client/*.lua"
}