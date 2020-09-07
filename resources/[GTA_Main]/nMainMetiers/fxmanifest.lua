fx_version 'cerulean'
games { 'gta5' }


dependencies {'ghmattimysql'}

files {
    'json/**/*'
}

server_script 'server/main.lua'

client_scripts {
    'config/config.lua',
    'client/blips.lua',
	"client/client.lua",
    'client/menu.lua'
}