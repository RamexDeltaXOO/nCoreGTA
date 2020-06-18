fx_version 'bodacious'
game 'gta5'


dependencies {'ghmattimysql'}


files {
    'json/**/*'
}


server_scripts {
    'server/main.lua'
}

client_scripts {
    "client/client.lua",
    'client/menu.lua'
}