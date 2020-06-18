RegisterServerEvent("GTA:CheckAdmin")
AddEventHandler("GTA:CheckAdmin", function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:scalar("SELECT isAdmin FROM gta_joueurs WHERE ?", {{['license'] = license}}, function(isAdmin)
		if isAdmin then
			TriggerClientEvent("GTA:UpdatePlayerAdmin", source, isAdmin)
		end
	end)
end)

RegisterServerEvent("GTA_Admin:AjoutArgentPropre")
AddEventHandler("GTA_Admin:AjoutArgentPropre", function(qty)
	local source = source
	TriggerEvent("GTA:AjoutArgentPropre", source, tonumber(qty))
end)

RegisterServerEvent("GTA_Admin:AjoutArgentSale")
AddEventHandler("GTA_Admin:AjoutArgentSale", function(qty)
	local source = source
	TriggerEvent("GTA:AjoutArgentSale", source, tonumber(qty))
end)

RegisterServerEvent("GTA_Admin:AjoutArgentBanque")
AddEventHandler("GTA_Admin:AjoutArgentBanque", function(qty)
	local source = source
	TriggerEvent("GTA:AjoutArgentBanque", source, tonumber(qty))
end)