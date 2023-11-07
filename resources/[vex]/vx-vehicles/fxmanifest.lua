fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework Vehicle Management'
version '0.1.0'

server_script "@vx-lib/server/rpc.lua"
client_script "@vx-lib/client/rpc.lua"

server_scripts {
    "server/keys.lua",
    
}

client_scripts {
    "client/actions.lua",
    "client/keys.lua",
    "client/interact_entries.lua",
}