fx_version 'cerulean'
game 'gta5'

author 'DrillUK Reward Slot'
description 'Neon reward slot machine (NUI) with center selector'
version '1.0.0'

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/style.css',
  'html/app.js',
  'html/assets/audio/*.mp3',
  'html/assets/visual/*.gif',
  -- 'html/sounds/tick.ogg',
  -- 'html/sounds/win.ogg',
  -- 'html/sounds/bigwin.ogg',
}

client_scripts {
  'client/client.lua'
}

server_scripts {
  'server/server.lua'
}
