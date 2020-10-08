--@Super.Cool.Ninja

--Intégration de la position dans MySQL
RegisterServerEvent("GTA:SAVEPOS")
AddEventHandler("GTA:SAVEPOS", function( LastPosX , LastPosY , LastPosZ )
	local source = source
	local license = ""
    local Identifiers = GetPlayerIdentifiers(source)
    for i,identifier in ipairs(Identifiers) do
        if string.find(identifier, "license:") then
            license = identifier
        end
    end
	local lastPosition = "{" .. LastPosX .. ", " .. LastPosY .. ",  " .. LastPosZ.. "}"
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['lastpos'] = lastPosition}, {['license'] = license} })
end)


RegisterServerEvent("GTA:SPAWNPLAYER")
AddEventHandler("GTA:SPAWNPLAYER", function()
	local source = source
	local license = ""
    local Identifiers = GetPlayerIdentifiers(source)
    for i,identifier in ipairs(Identifiers) do
        if string.find(identifier, "license:") then
            license = identifier
        end
    end
	exports.ghmattimysql:scalar("SELECT lastpos FROM gta_joueurs WHERE ?", {{['license'] = license}}, function(lastpos)
		local newPos = json.decode(lastpos)

		Wait(50)

		
		-- On envoie la derniere position vers le client pour le spawn
		TriggerClientEvent("GTA:LASTPOS", source, newPos[1], newPos[2], newPos[3])
	end)
end)

RegisterServerEvent("GTA:SetPositionPlayer")
AddEventHandler("GTA:SetPositionPlayer", function()
	local source = source
	local license = ""
    local Identifiers = GetPlayerIdentifiers(source)
    for i,identifier in ipairs(Identifiers) do
        if string.find(identifier, "license:") then
            license = identifier
        end
    end
	exports.ghmattimysql:scalar("SELECT lastpos FROM gta_joueurs WHERE ?", {{['license'] = license}}, function(lastpos)
		local newPos = json.decode(lastpos)

		Wait(50)

		-- On envoie la derniere position vers le client pour le spawn
		TriggerClientEvent("GTA:NewPlayerPosition", source, newPos[1], newPos[2], newPos[3])
	end)
end)