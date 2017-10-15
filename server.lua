local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local cfg = module("vrp_discord", "config")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRPdiscord")
vRPjailerC = Tunnel.getInterface("vRPdiscord","vRPdiscord")


AddEventHandler('chatMessage', function(source, name, message)

  cmd = string.sub (message, 1, 1)
  if (cmd ~= "/") then
	msg = "/ooc "..message
  else
	msg = message
  end
  sm = stringsplit(msg, " ");
  if sm[1] == "/ooc" then
	CancelEvent()
	TriggerClientEvent('chatMessage', -1, "^6OOC | ^7" .. name, { 128, 128, 128 }, string.sub(msg,5))
	discordname = "OOC | " .. name 
  	--sendToDiscord(discordname, string.sub(msg,5))
  end

  if sm[1] == "/me" then
	CancelEvent()

        vRP.getUserIdentity({source, function(identity)
	      dsp_name = identity.firstname.." "..identity.name
	      TriggerClientEvent('chatMessage', -1, "^3Me | ^7" .. dsp_name, { 128, 128, 128 }, string.sub(msg,5))
	      discordname = "Me | " .. name 
  	      --sendToDiscord(discordname, string.sub(msg,5))
        end})
  end





  if sm[1] == "/tweet" then
	CancelEvent()
        vRP.getUserIdentity({source, function(identity)
	      dsp_name = identity.firstname.." "..identity.name
	      TriggerClientEvent('chatMessage', -1, "^3Twitter | ^7" .. dsp_name, { 128, 128, 128 }, string.sub(msg,8))
	      discordname = dsp_name 
  	      sendToDiscord(discordname, string.sub(msg,8), cfg.twitter_webhook)
        end})
  end

  if sm[1] == "/twitter" then
	CancelEvent()
        vRP.getUserIdentity({source, function(identity)
	      dsp_name = identity.firstname.." "..identity.name
	      TriggerClientEvent('chatMessage', -1, "^3Twitter | ^7" .. dsp_name, { 128, 128, 128 }, string.sub(msg,9))
	      discordname = dsp_name 
  	      sendToDiscord(discordname, string.sub(msg,9), cfg.twitter_webhook)
        end})
  end

  if sm[1] == "/do" then
	CancelEvent()
        vRP.getUserIdentity({source, function(identity)
	      dsp_name = identity.firstname.." "..identity.name
	      discordname = dsp_name 
	      TriggerClientEvent('chatMessage', -1, "^2Do | ^7" .. dsp_name, { 128, 128, 128 }, string.sub(msg,5))
        end})
  end


  if sm[1] == "/911" then
	CancelEvent()
        vRP.getUserIdentity({source, function(identity)
	      dsp_name = identity.firstname.." "..identity.name
	      discordname = "911 | " .. dsp_name 
	      TriggerClientEvent('chatMessage', -1, "^8(911) | ^7" .. dsp_name, { 255, 255, 255 }, string.sub(msg,5))
  	      sendToDiscord(discordname, string.sub(msg,5), cfg.e911_webhook)
        end})
  end

  if sm[1] == "/news" then
	CancelEvent()
        vRP.getUserIdentity({source, function(identity)
		TriggerClientEvent("chatMessage", -1, "^3News", {255, 255, 255}, string.sub(msg,6))
		dsp_name = identity.firstname.." "..identity.name
		discordname = "News | " .. dsp_name 
  		sendToDiscord(discordname, string.sub(msg,6), cfg.news_webhook)
        end})
  end

  if sm[1] == "/ad" then
	CancelEvent()
        vRP.getUserIdentity({source, function(identity)
		dsp_name = identity.firstname.." "..identity.name
		discordname = "AD | " .. dsp_name 
		TriggerClientEvent("chatMessage", -1, "^2AD | " .. dsp_name, {255, 255, 255}, string.sub(msg,5))
  		sendToDiscord(discordname, string.sub(msg,5), cfg.ad_webhook)
        end})
  end

  --cmd = string.sub (message, 1, 1)
  if (cmd == "/") then
	return
  end
  --PerformHttpRequest(cfg.discord_webhook, function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
  --sendToDiscord(name, message)
end)

AddEventHandler('playerActivated', function()
  sendToDiscord('system', GetPlayerName(source) .. ' joined.', cfg.discord_webhook)
end)

AddEventHandler('playerConnecting', function()
  sendToDiscord('system', GetPlayerName(source) .. ' joined.', cfg.discord_webhook)
end)

AddEventHandler('playerDropped', function(reason)
  sendToDiscord('system', GetPlayerName(source) .. ' left (' .. reason .. ')', cfg.discord_webhook)
end)

function sendToDiscord(name, message, webhook)
print('sending to discord...'..webhook)
  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

sendToDiscord('system', 'Server Was Restarted!!!.', cfg.discord_webhook)
