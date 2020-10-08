fx_version 'cerulean'
game 'gta5'

dependencies {'ghmattimysql'}

files {
    'json/**/*'
}

server_scripts {
    'server/server_main.lua',
    'server/server_inventaire.lua'
}

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

    'config/config.lua',
    'client/client_main.lua',
    'client/client_armes.lua',
    'client/client_inventaire.lua',
    'client/client_menu.lua'
}

export 'getQuantity'
export 'notFull'