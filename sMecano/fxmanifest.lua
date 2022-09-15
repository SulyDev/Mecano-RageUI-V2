fx_version 'adamant'

game 'gta5'

client_scripts {
        -- RageUI
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
  }

client_scripts {
    '@es_extended/locale.lua',
    -- Script
    'client/cl_coffre.lua',
    'client/cl_garage.lua',
    'client/cl_boss.lua',
    'client/cl_vestiaire.lua',
    'client/cl_menu.lua',
    'cl_craft.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    -- Script
    'server/sv_mecano.lua',
}

dependencies {
    'es_extended'
}


shared_scripts {
    'config.lua'
}
