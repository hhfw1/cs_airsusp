fx_version 'adamant'
game 'gta5'
author 'Team CodeStudio: https://discord.gg/ESwSKregtt'
description 'Code Studio Air Suspension'

ui_page 'ui/index.html'

client_script 'client.lua'
server_script 'server.lua'
shared_script 'shared.lua'

files {
	'ui/**',
}

escrow_ignore {
  'shared.lua', 
}

lua54 'yes'
