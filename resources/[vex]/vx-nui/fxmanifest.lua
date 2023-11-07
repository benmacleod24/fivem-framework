fx_version 'cerulean'
games { 'gta5' }

author 'Ben Macleod'
description 'VEX Framework NUI'
version '0.1.0'

shared_scripts {
    "@vx-lib/shared/utils.lua",
}

client_scripts {
    "@vx-lib/client/rpc.lua",
    "client/main.lua",
    "client/events.lua",
    "client/commands.lua",
    'client/apps/*.lua',
}

ui_page "content/build/index.html"
files {
    "content/build/index.html",
    "content/build/images/**/**/*.png",
    "content/build/*.json",
    "content/build/static/js/*.js",
    "content/build/static/css/*.css",
    "content/build/static/media/*.svg",
    "content/build/static/media/*.ttf",
    'content/build/images/icons/*.png',
}