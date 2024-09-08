fx_version 'cerulean'
game 'gta5'
lua54 'yes'


client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
    'shared/logs.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'shared/config.lua',
}