fx_version 'adamant'
game 'gta5'

shared_script '@DiamondCasino/shared.lua'

-- Discord Ice Heart#1826
dependency 'es_extended'

ui_page "html/ui.html"

files {
	"html/ui.html",
  "html/js/index.js",
  "html/css/style.css",
}

client_script {
  '@es_extended/locale.lua',
  'config.lua',
  'client.lua',
}

server_script {
  '@es_extended/locale.lua',
  'config.lua',
  'server.lua',
  '@mysql-async/lib/MySQL.lua'
}

--
--
 
