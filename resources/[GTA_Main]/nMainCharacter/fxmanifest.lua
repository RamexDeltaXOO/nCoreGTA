fx_version 'adamant'
game 'gta5'

dependencies {'ghmattimysql'}


files {
    'json/**/*'
}

server_scripts {
	'server/main.lua'
}

client_scripts {
    'config/config.lua',
	"client/client.lua",
    'client/menu.lua'
}