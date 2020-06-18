fx_version 'bodacious'
game 'gta5'

dependencies {'ghmattimysql'}

export 'Ninja_Core_PedsText'
export 'Ninja_Core_StartAnim'
export 'Ninja_Core_nRequestAnimSet'
export 'nNotificationMain'

server_scripts {
    'config/config.lua',
    'server/player.lua',
    'server/whitelist.lua',
    'server/admin_command.lua',
    'server/player_pos.lua',
    'synchronisation/server.lua'
}

client_scripts {
    'utils/functionsExported.lua',
    'config/config.lua',
    'client/pedControl.lua',
    'client/admin_main.lua',
    'client/main.lua',
    'client/spawn.lua',
    'death/utilsdead.lua',
    'death/deadplayer.lua',
    'synchronisation/client.lua'
}

files {
    'loadingscreen/index.html',
    'loadingscreen/styles.css',
    'loadingscreen/bankgothic.ttf',
    'loadingscreen/loadscreen.jpg'
}

loadscreen 'loadingscreen/index.html'

--@Super.Cool.Ninja