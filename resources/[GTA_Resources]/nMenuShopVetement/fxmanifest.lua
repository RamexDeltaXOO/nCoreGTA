fx_version 'bodacious'
game 'gta5'


dependencies {'ghmattimysql'}

files {
    'json/**/*'
}

client_scripts {
    "client/client.lua",
    'client/menu.lua'
}

server_scripts {
    'server/main.lua'
}