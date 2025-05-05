fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'zyga'
description 'ZYGA DRUGS V2'


client_scripts {
    'client/*.lua'
}

shared_scripts {
    'shared/*.lua',
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

server_scripts {
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua',
}

