RegisterServerEvent("GTA:CheckAdmin")
AddEventHandler("GTA:CheckAdmin", function()
	local source = source
	local license = ""
    local Identifiers = GetPlayerIdentifiers(source)
    for _,identifier in ipairs(Identifiers) do
        if string.find(identifier, "license:") then
            license = identifier
        end
    end

	local res = MySQL.Sync.fetchScalar("SELECT isAdmin FROM gta_joueurs WHERE license = @username", {['@username'] = license})
	if (res == true) then
		TriggerClientEvent("GTA:UpdatePlayerAdmin", source, res)
	end
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