RegisterServerEvent('nGetStats')
AddEventHandler('nGetStats', function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	exports.ghmattimysql:execute("SELECT faim, soif FROM gta_joueurs WHERE license = @license", { ['@license'] = license }, function(res)
		TriggerClientEvent('nGetStats', source, res[1].faim, res[1].soif)
	end)
end)

RegisterServerEvent("nSetFaim")
AddEventHandler("nSetFaim", function(faim)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['faim'] = faim}, {['license'] = license} })
end)

RegisterServerEvent("nSetSoif")
AddEventHandler("nSetSoif", function(soif)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['soif'] = soif}, {['license'] = license} })
end)