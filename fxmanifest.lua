fx_version 'adamant'
version '2.0'
game 'gta5'
author 'CodeStudio'
description 'Air Suspension'

ui_page 'ui/index.html'

shared_scripts {'@ox_lib/init.lua', 'config.lua'}
client_script 'main/client.lua'
server_script 'main/server.lua'

files {'ui/**'}

dependencies {'ox_lib'}

lua54 'yes'