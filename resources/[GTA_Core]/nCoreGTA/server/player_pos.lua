--@Super.Cool.Ninja

--Intégration de la position dans MySQL
RegisterServerEvent("GTA:SAVEPOS")
AddEventHandler("GTA:SAVEPOS", function( LastPosX , LastPosY , LastPosZ )
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	local lastPosition = "{" .. LastPosX .. ", " .. LastPosY .. ",  " .. LastPosZ.. "}"
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET lastpos=@lastPosition WHERE license = @username", {['@username'] = license, ['@lastPosition'] = lastPosition})
end)


RegisterServerEvent("GTA:SPAWNPLAYER")
AddEventHandler("GTA:SPAWNPLAYER", function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("SELECT * FROM gta_joueurs WHERE license = @username", {['@username'] = license}, function(result)
		if(result)then
			for k,v in ipairs(result)do
				if v.lastpos ~= "" then
					-- Formatage des données en JSON pour intégration dans MySQL.
					local ToSpawnPos = json.decode(v.lastpos)
					-- Intégration des données dans les variables dédiées
					local PosX = ToSpawnPos[1]
					local PosY = ToSpawnPos[2]
					local PosZ = ToSpawnPos[3]
					local PosH = ToSpawnPos[4]
					-- On envoie la derniere position vers le client pour le spawn
					TriggerClientEvent("GTA:LASTPOS", source, PosX, PosY, PosZ)
				end
			end
		end
	end)
end)