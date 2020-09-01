Player = {}
Player.__index = Player

RegisterServerEvent("GTA_Notif:OnPlayerJoin")
AddEventHandler('GTA_Notif:OnPlayerJoin', function()
	local source = source
	local license = ""
    local Identifiers = GetPlayerIdentifiers(source)
    for i,identifier in ipairs(Identifiers) do
        if string.find(identifier, "license:") then
            license = identifier
        end
    end
	exports.ghmattimysql:execute("SELECT * FROM gta_joueurs WHERE license = @username", {['@username'] = license}, function(res)
		if(res[1].nom == "Sans Nom" and res[1].prenom == "Sans Prenom") then
			TriggerClientEvent('nMenuNotif:showNotification', -1,"~y~Un nouveau citoyen~g~ vient de rejoindre la ville.")
		else
			TriggerClientEvent('nMenuNotif:showNotification', -1,"~b~"..res[1].nom.. " "..res[1].prenom.."~g~ vient de rejoindre la ville.")
		end
	end)
end)

AddEventHandler('playerDropped', function()
	local source = source
	local license = ""
    local Identifiers = GetPlayerIdentifiers(source)
    for i,identifier in ipairs(Identifiers) do
        if string.find(identifier, "license:") then
            license = identifier
        end
    end
	exports.ghmattimysql:execute("SELECT * FROM gta_joueurs WHERE license = @username", {['@username'] = license}, function(res)
		if(res[1].nom == "Sans Nom" and res[1].prenom == "Sans Prenom") then
			TriggerClientEvent('nMenuNotif:showNotification', -1,"~y~Un nouveau citoyen ~r~ vient de quitté la ville.")
		else
			TriggerClientEvent('nMenuNotif:showNotification', -1,"~b~"..res[1].nom.. " "..res[1].prenom.."~r~ vient de quitté la ville.")
		end
	end)
end)

function Player:GetLicense(source)
	for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.sub(v, 1, string.len("license")) == "license" then
			return v
		end
	end
end

function Player:Find(source, callback)
	local src = source
	local pLicense = Player:GetLicense(src)
	local Parameters = {['license'] = pLicense}

	exports.ghmattimysql:execute("SELECT * FROM gta_joueurs WHERE license = @license", Parameters, function(data)
		for k, v in pairs(data) do
			if callback then
				callback(v)
			end
		end
	end)
end

function Player:New(license, argent_propre, argent_sale, banque)
	local Parameters = {
	    ['license'] = license,
		['argent_propre'] = argent_propre,
		['argent_sale'] = argent_sale,
		['banque'] = banque
	}

	return exports.ghmattimysql:execute("INSERT INTO gta_joueurs (`license`,`argent_propre`,`argent_sale`, `banque`) VALUES (@license, @argent_propre, @argent_sale, @banque)", Parameters, function() end)
end


RegisterServerEvent('GTA:LoadArgent')
AddEventHandler('GTA:LoadArgent', function()
	local src = source
	Player:Find(src, function(data)
		if data then
			local argentPropre = data.argent_propre
			local argentSale = data.argent_sale
			local argentBanque = data.banque
			
			TriggerClientEvent('GTA:AfficherArgentPropre', src, argentPropre)
			TriggerClientEvent('GTA:AfficherBanque', src, argentBanque)
		end
	end)
end)

RegisterServerEvent('GTA:GetInfoJoueurs')  --> cette event sert uniquement a get les donnée de votre perso.
AddEventHandler('GTA:GetInfoJoueurs', function(source, callback)
	local src = source
	for k,v in ipairs(GetPlayerIdentifiers(src)) do
		if string.sub(v, 1, string.len("license")) == "license" then
			pLicense = v
		end
	end

	local Parameters = {['license'] = pLicense}
	exports.ghmattimysql:scalar("SELECT license FROM gta_joueurs WHERE license = @license", Parameters, function(result)
		exports.ghmattimysql:execute("SELECT * FROM gta_joueurs WHERE license = @license", Parameters, function(data)
			for k, v in pairs(data) do
				if callback then
					callback(v)
				end
			end
		end)
	end)
end)

RegisterServerEvent('GTA:GetGlobaleJoueurs')  --> cette event sert uniquement renvoyé les donné de votre perso.
AddEventHandler('GTA:GetGlobaleJoueurs', function(callback)
	local src = source
	for k,v in ipairs(GetPlayerIdentifiers(src)) do
		if string.sub(v, 1, string.len("license")) == "license" then
			pLicense = v
		end
	end

	local Parameters = {['license'] = pLicense}
	exports.ghmattimysql:scalar("SELECT license FROM gta_joueurs WHERE license = @license", Parameters, function(result)
		exports.ghmattimysql:execute("SELECT * FROM gta_joueurs WHERE license = @license", Parameters, function(data)
			callback(data)
		end)
	end)
end)

RegisterServerEvent('GTA:CreationJoueur')  --> cette event sert uniquement a créer votre perso.
AddEventHandler('GTA:CreationJoueur', function(source)
    local src = source
    for k,v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("license")) == "license" then
            pLicense = v
        end
    end

    local Parameters = {['license'] = pLicense}

    local license = ""
    local Identifiers = GetPlayerIdentifiers(source)
    for i,identifier in ipairs(Identifiers) do
        if string.find(identifier, "license:") then
            license = identifier
        end
    end

    exports.ghmattimysql:scalar("SELECT license FROM gta_joueurs WHERE license = @license", Parameters, function(result)
        if not result then
            if config.activerWhitelist == false then
                print('Creation de personnage pour : [' .. GetPlayerName(src) .. "] -  [License] : "..license)
            end

            Player:New(pLicense, config.argentPropre, config.argentSale, config.banque)
        end
    end)
end)

RegisterServerEvent('GTA:salaire')
AddEventHandler('GTA:salaire', function()
	local src = source
	local license = ""
    local Identifiers = GetPlayerIdentifiers(src)
    for i,identifier in ipairs(Identifiers) do
        if string.find(identifier, "license:") then
            license = identifier
        end
    end
	Player:Find(src, function(data)
		if data then
			exports.ghmattimysql:execute("SELECT salaire FROM gta_joueurs INNER JOIN gta_metiers ON gta_joueurs.job = gta_metiers.metiers WHERE license = @license",{['@license'] = license}, function (res)
				local newValue = data.banque + res[1].salaire
				exports.ghmattimysql:execute("UPDATE gta_joueurs SET banque=@newValue WHERE license = @license", {['license'] = tostring(data.license), ['newValue'] = tostring(newValue)}, function() end)
				TriggerClientEvent('GTA:AfficherBanque', src, newValue)
				TriggerClientEvent("nMenuNotif:showNotification", src, "~g~ Salaire reçu : + "..res[1].salaire.." ~g~$")
			end)
		end
	end)
end)

RegisterServerEvent('GTA:AjoutArgentPropre') --> cette event sert uniquement a ajouté de l'argent propre.
AddEventHandler('GTA:AjoutArgentPropre', function(source, value)
	local src = source
	Player:Find(src, function(data)
		if data then
			local newValue = data.argent_propre + value
			exports.ghmattimysql:execute("UPDATE gta_joueurs SET argent_propre=@newValue WHERE license = @license", {['license'] = tostring(data.license), ['newValue'] = tostring(newValue)}, function() end)
			TriggerClientEvent('GTA:AfficherArgentPropre', src, newValue)
		end
	end)
end)


RegisterServerEvent('GTA:AjoutArgentSale') --> cette event sert uniquement a ajouté de l'argent sale.
AddEventHandler('GTA:AjoutArgentSale', function(source, value)
	local src = source
	Player:Find(src, function(data)
		if data then
			local newValue = data.argent_sale + value
			exports.ghmattimysql:execute("UPDATE gta_joueurs SET argent_sale=@newValue WHERE license = @license", {['license'] = tostring(data.license), ['newValue'] = tostring(newValue)}, function() end)
			--> Si vous utilisé un hud autre que de base, veuillez le refresh ici.
		end
	end)
end)

RegisterServerEvent('GTA:AjoutArgentBanque') --> cette event sert uniquement a ajouté de l'argent en banque.
AddEventHandler('GTA:AjoutArgentBanque', function(source, value)
	local src = source
	Player:Find(src, function(data)
		if data then
			local newValue = data.banque + value
			exports.ghmattimysql:execute("UPDATE gta_joueurs SET banque=@newValue WHERE license = @license", {['license'] = tostring(data.license), ['newValue'] = tostring(newValue)}, function() end)
			TriggerClientEvent('GTA:AfficherBanque', src, newValue)
		end
	end)
end)

RegisterServerEvent('GTA:RetirerArgentPropre') --> cette event sert uniquement a retirer votre argent propre par une valeur en parametre.
AddEventHandler('GTA:RetirerArgentPropre', function(source, value)
	local src = source
	Player:Find(src, function(data)
		if data then
			local getArgentPropre = data.argent_propre
			if getArgentPropre >= value then
				local newCash = data.argent_propre - value
				exports.ghmattimysql:execute("UPDATE gta_joueurs SET argent_propre=@newCash WHERE license = @license", {['license'] = tostring(data.license), ['newCash'] = tostring(newCash)}, function() end)
				TriggerClientEvent('GTA:AfficherArgentPropre', src, newCash)
				TriggerClientEvent('GTA:AjoutSonPayer', src)
			else
				TriggerClientEvent("nMenuNotif:showNotification", source, "Vous n'avez cette somme d'argent sur vous.")
			end
		end
	end)
end)


RegisterServerEvent('GTA:RetirerArgentSale') --> cette event sert uniquement a retirer votre argent sale par une valeur en parametre.
AddEventHandler('GTA:RetirerArgentSale', function(source, value)
	local src = source

	Player:Find(src, function(data)
		if data then
			local getArgentSale = data.argent_sale
			if getArgentSale >= value then
				local newValue = data.argent_sale - value
				exports.ghmattimysql:execute("UPDATE gta_joueurs SET argent_sale=@newValue WHERE license = @license", {['license'] = tostring(data.license), ['newValue'] = tostring(newValue)}, function() end)
				--> Si vous utilisé un hud autre que de base, veuillez le refresh ici.
				TriggerClientEvent('GTA:AjoutSonPayer', src)
			else
				TriggerClientEvent("nMenuNotif:showNotification", source, "Vous n'avez cette somme d'argent sur vous.")
			end
		end
	end)
end)

RegisterServerEvent('GTA:RetirerArgentBanque') --> cette event sert uniquement a retirer votre argent en banque par une valeur en parametre. comme exemple payé une amende.
AddEventHandler('GTA:RetirerArgentBanque', function(source, value)
	local src = source
	Player:Find(src, function(data)
		if data then
			local newValue = data.banque - value
			exports.ghmattimysql:execute("UPDATE gta_joueurs SET banque=@newValue WHERE license = @license", {['license'] = tostring(data.license), ['newValue'] = tostring(newValue)}, function() end)
			TriggerClientEvent('GTA:AfficherBanque', src, newValue)
			TriggerClientEvent('GTA:AjoutSonPayer', src)
		end
	end)
end)

RegisterServerEvent('GTA:RetirerAtmBanque') --> cette event sert uniquement a retirer votre argent en banque par une valeur en parametre.
AddEventHandler('GTA:RetirerAtmBanque', function(source, value)
	local src = source
	Player:Find(src, function(data)
		if data then
			local getArgentBanque = data.banque
			if getArgentBanque >= value then
				local newValue = data.banque - value
				local newArgentPropre = data.argent_propre + value
				exports.ghmattimysql:execute("UPDATE gta_joueurs SET banque=@newValue WHERE license = @license", {['license'] = tostring(data.license), ['newValue'] = tostring(newValue)}, function() end)
				exports.ghmattimysql:execute("UPDATE gta_joueurs SET argent_propre=@newArgentPropre WHERE license = @license", {['license'] = tostring(data.license), ['newArgentPropre'] = tostring(newArgentPropre)}, function() end)
				TriggerClientEvent('GTA:AfficherBanque', src, newValue)
				TriggerClientEvent('GTA:AfficherArgentPropre', src, newArgentPropre)
			else
				TriggerClientEvent("nMenuNotif:showNotification", source, "Vous n'êtes pas bénificaire au découvert bancaire.")
			end
		end
	end)
end)


RegisterServerEvent('GTA:DeposerAtmBanque') --> cette event sert uniquement a retirer votre argent propre par une valeur en parametre.
AddEventHandler('GTA:DeposerAtmBanque', function(source, value)
	local src = source
	Player:Find(src, function(data)
		if data then
			local getArgentPropre = data.argent_propre
			if getArgentPropre >= value then
				local argentPropre = data.argent_propre - value
				local newValue = data.banque + value
				exports.ghmattimysql:execute("UPDATE gta_joueurs SET banque=@newValue WHERE license = @license", {['license'] = tostring(data.license), ['newValue'] = tostring(newValue)}, function() end)
				exports.ghmattimysql:execute("UPDATE gta_joueurs SET argent_propre=@argentPropre WHERE license = @license", {['license'] = tostring(data.license), ['argentPropre'] = tostring(argentPropre)}, function() end)
				TriggerClientEvent('GTA:AfficherBanque', src, newValue)
				TriggerClientEvent('GTA:AfficherArgentPropre', src, argentPropre)
			else
				TriggerClientEvent("nMenuNotif:showNotification", source, "Vous n'avez cette somme d'argent sur vous.")
			end
		end
	end)
end)

AddEventHandler('GTA:GetJoueurs', function(cb)
    cb(Player)
end)