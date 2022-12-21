fx_version 'adamant'
game 'gta5'
author 'Team CodeStudio: https://discord.gg/ESwSKregtt'
description 'Code Studio Air Suspension'

ui_page 'ui/index.html'

client_script 'client.lua'
server_scripts {'server.lua', 'config/item.lua'}
shared_script 'config/shared.lua'

files {
	'ui/**',
}

escrow_ignore {
  'config/shared.lua', 
  'config/item.lua'
}

lua54 'yes'
