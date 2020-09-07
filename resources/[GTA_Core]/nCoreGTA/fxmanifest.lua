fx_version 'cerulean'
games { 'gta5' }

dependencies {'ghmattimysql'}

ui_page 'progressBar/progressbar.html'

export 'Ninja_Core_PedsText'
export 'Ninja_Core_StartAnim'
export 'Ninja_Core_nRequestAnimSet'
export 'nNotificationMain'
export 'progression'

server_scripts {
    'config/config.lua',
    'server/player.lua',
    'server/whitelist.lua',
    'server/admin_command.lua',
    'server/player_pos.lua',
    'synchronisation/server.lua',
    'services/server.lua'
}

client_scripts {
    'utils/functionsExported.lua',
    'config/config.lua',
    'client/admin_main.lua',
    'client/main.lua',
    'client/spawn.lua',
    'synchronisation/client.lua',
    'services/client.lua'
}

files {
    'loadingscreen/index.html',
    'loadingscreen/style.css',
    'loadingscreen/background.png',
    'loadingscreen/loading.gif',
    'progressBar/progressbar.html'
}

loadscreen 'loadingscreen/index.html'

--@Super.Cool.Ninja