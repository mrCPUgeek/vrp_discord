description "vRP Court"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
}

server_scripts{
  "@vrp/lib/utils.lua",
  "server.lua"
}
