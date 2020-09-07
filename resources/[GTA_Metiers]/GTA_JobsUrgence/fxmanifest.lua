fx_version 'cerulean'
games { 'gta5' }

dependencies {'ghmattimysql'}

dependency 'nMenuPersonnel'



files {
    'configuration_jobs/json/**/*',
    'police/json/**/*',
    'medics/json/**/*'
}

server_scripts {
    'configuration_jobs/server_main/server.lua',
    'police/server/server.lua',
    'medics/server/server.lua'
} 

client_scripts { 
    'configuration_jobs/config/config.lua',
    'configuration_jobs/utils/utils.lua',
    'configuration_jobs/npc/config.lua',
    'configuration_jobs/npc/main_npc.lua',
    'Coma/dead_utils.lua',
    'Coma/dead_main.lua',
    'police/client/**/*',
    'police/menu/**/*',
    'medics/client/**/*',
    'medics/menu/**/*'

}