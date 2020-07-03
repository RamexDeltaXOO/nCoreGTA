--||@SuperCoolNinja.||--
RegisterServerEvent('GTA:ChercherSonIdentiter')
AddEventHandler('GTA:ChercherSonIdentiter', function()
	local source = source	

	TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
		local nom = data.nom
		local prenom = data.prenom
		local travail = data.job
		local age = data.age
		local origine = data.origine
		local grade = data.grade
		
		TriggerClientEvent('GTA:RegarderIdentiter', source, tostring(nom), tostring(prenom), tostring(travail), tonumber(age), tostring(origine), tostring(grade))
	end)
end)


RegisterServerEvent('GTA:MontrerSonIdentiter')
AddEventHandler('GTA:MontrerSonIdentiter', function(NearestPlayerSID)
	local source = source	

	TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
		local nom = data.nom
		local prenom = data.prenom
		local travail = data.job
		local age = data.age
		local origine = data.origine
		local grade = data.grade

		if NearestPlayerSID ~= 0 then
			TriggerClientEvent('GTA:RegarderIdentiter', NearestPlayerSID, tostring(nom), tostring(prenom), tostring(travail), tonumber(age), tostring(origine), tostring(grade))
			TriggerClientEvent('nMenuNotif:showNotification', NearestPlayerSID, "Une personne vous montre son identité.")
		else
			TriggerClientEvent('nMenuNotif:showNotification', source, "Aucune personne devant vous")
		end
	end)
end)


RegisterServerEvent('GTA:RegardeSonArgent')
AddEventHandler('GTA:RegardeSonArgent', function()
	local source = source	

	TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
		local argentSale = data.argent_sale
		local argentPropre = data.argent_propre
		TriggerClientEvent('GTA:UpdateCash', source, tonumber(argentSale), tonumber(argentPropre))
	end)
end)

RegisterServerEvent('GTA:ServerRefreshDirtyMoney')
AddEventHandler('GTA:ServerRefreshDirtyMoney', function()
	local source = source	
	
	TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
		local argentSale = data.argent_sale
		TriggerClientEvent('GTA:UpdateDirtyCash', source, tonumber(argentSale))
	end)
end)

-----------------||CASH SYSTEM||-----------------
RegisterServerEvent('nArgent:DonnerArgentPropre')
AddEventHandler('nArgent:DonnerArgentPropre', function(toPlayer, amount)
	local source = source
	if (toPlayer ~= nil and tonumber(amount) > 0) then
		fromPlayer = tonumber(source)
		toPlayer = tonumber(toPlayer)
		amount = tonumber(amount)
		TriggerClientEvent('bank:givecash', source, toPlayer, amount)
	else
		TriggerClientEvent('nMenuNotif:showNotification', source,"Veuillez entrer une valeur numérique !")
		return false
	end
end)

RegisterServerEvent('GTA:DonnerArgentSale')
AddEventHandler('GTA:DonnerArgentSale', function(toPlayer, amount)
	local source = source

	if (toPlayer ~= nil and tonumber(amount) > 0) then
		fromPlayer = tonumber(source)
		toPlayer = tonumber(toPlayer)
		amount = tonumber(amount)
		TriggerClientEvent('bank:givesale', source, toPlayer, amount)
	else
		TriggerClientEvent('nMenuNotif:showNotification', source,"Veuillez entrer une valeur numérique !")
		return false
	end
end)

RegisterServerEvent('bank:givesale')
AddEventHandler('bank:givesale', function(toPlayer, amount)
	local source = source
	TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
		local argentSale = data.argent_sale 
		if (tonumber(argentSale) >= tonumber(amount)) then
			TriggerEvent('GTA:RetirerArgentSale', source, tonumber(amount))
			TriggerEvent('GTA:GetInfoJoueurs', toPlayer, function(data)
				TriggerEvent('GTA:AjoutArgentSale', toPlayer, tonumber(amount))
				TriggerClientEvent('nMenuNotif:showNotification', source,"Vous avez donné: ~r~-$".. amount)
				TriggerClientEvent('nMenuNotif:showNotification', toPlayer,"Une personne vous a donner de l'argent sale : ~r~$".. amount)
			end)
		else
			TriggerClientEvent('nMenuNotif:showNotification', source,"Pas assez d'argent dans le portefeuille !")
			CancelEvent()
		end
	end)
end)

RegisterServerEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
	local source = source
	TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
		local argentPropre = data.argent_propre
		if (tonumber(argentPropre) >= tonumber(amount)) then
			TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(amount))
			TriggerEvent('GTA:GetInfoJoueurs', toPlayer, function(data)
				TriggerEvent('GTA:AjoutArgentPropre', toPlayer, tonumber(amount))
				TriggerClientEvent('nMenuNotif:showNotification', source,"Vous avez donné: ~g~-$".. amount)
				TriggerClientEvent('nMenuNotif:showNotification', toPlayer,"Une personne vous a donner de l'argent propre: ~g~$".. amount)
			end)
		else
			TriggerClientEvent('nMenuNotif:showNotification', source, "Pas assez d'argent!")
			CancelEvent()
		end
	end)
end)

RegisterServerEvent("GTA:GetPlayerSex")
AddEventHandler('GTA:GetPlayerSex', function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:scalar("SELECT sex FROM gta_joueurs_humain WHERE ?", {{['license'] = license}}, function(sex)
		TriggerClientEvent("GTA:GetSexJoueur", source, sex)
	end)
end)

RegisterServerEvent("GTA:GetHautJoueur")
AddEventHandler('GTA:GetHautJoueur', function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	exports.ghmattimysql:execute("SELECT * FROM gta_joueurs_vetement WHERE license = @license", { ['@license'] = license}, function(res)
		TriggerClientEvent("GTA:MettreHautJoueur", source, {res[1].topsID, res[1].topsDraw, res[1].topsCouleur, res[1].undershirtsID, res[1].undershirtsDraw, res[1].undershirtsCouleur, res[1].torsosID, res[1].torsosDraw})
	end)
end)

RegisterServerEvent("GTA:GetBasJoueur")
AddEventHandler('GTA:GetBasJoueur', function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	exports.ghmattimysql:execute("SELECT * FROM gta_joueurs_vetement WHERE license = @license", { ['@license'] = license}, function(res)
		TriggerClientEvent("GTA:MettreBasJoueur", source, {res[1].legsID, res[1].legsDraw, res[1].legsCouleur})
	end)
end)


RegisterServerEvent("GTA:GetChaussureJoueur")
AddEventHandler('GTA:GetChaussureJoueur', function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	exports.ghmattimysql:execute("SELECT * FROM gta_joueurs_vetement WHERE license = @license", { ['@license'] = license}, function(res)
		TriggerClientEvent("GTA:MettreChaussureJoueur", source, {res[1].shoesID, res[1].shoesDraw, res[1].shoesCouleur})
	end)
end)

RegisterServerEvent("GTA:GetBonnetJoueur")
AddEventHandler('GTA:GetBonnetJoueur', function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	exports.ghmattimysql:execute("SELECT * FROM gta_joueurs_vetement WHERE license = @license", { ['@license'] = license}, function(res)
		TriggerClientEvent("GTA:MettreBonnetJoueur", source, {res[1].HatsID, res[1].HatsDraw, res[1].HatsCouleurs})
	end)
end)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end