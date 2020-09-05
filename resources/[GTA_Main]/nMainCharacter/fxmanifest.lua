fx_version 'adamant'
game 'gta5'

files {
    'json/**/*'
}

server_script 'server/main.lua'

client_scripts {
    'config/config.lua',
	"client/client.lua",
    'client/menu.lua'
}