fx_version 'cerulean'
game 'gta5'

dependencies {'ghmattimysql'}

ui_page 'progressBar/progressbar.html'

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
    'config/config.lua',
    'utils/functionsExported.lua',
    'client_main/notif_main.lua',
    'client_main/admin_main.lua',
    'client_main/main.lua',
    'client_main/spawn.lua',
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

export 'ShowNotification'
export 'ShowAdvancedNotification'
export 'Ninja_Core_PedsText'
export 'Ninja_Core_StartAnim'
export 'Ninja_Core_nRequestAnimSet'
export 'progression'

--@Super.Cool.Ninja