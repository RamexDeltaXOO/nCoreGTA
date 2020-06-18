RegisterServerEvent("GTA:UpdateTShirtVestePull")
AddEventHandler("GTA:UpdateTShirtVestePull", function(topsid, topsdraw, topscouleur, torsosid, torsosdraw, undershirtid, undershirtdraw, prix)
local source = source
local license = GetPlayerIdentifiers(source)[1]
prix = prix or 0

TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        local argentPropre = data.argent_propre

        if (tonumber(argentPropre) >= prix) then
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET topsID=@topsid, topsDraw=@topsdraw, topsCouleur=@topscouleur, undershirtsID=@undershirtid,undershirtsDraw=@undershirtdraw,torsosID=@torsosid,torsosDraw=@torsosdraw WHERE license=@license", {
                ['@license'] = license,
                ['@topsid'] = topsid, 
                ['@topsdraw'] = topsdraw,
                ['@topscouleur'] = topscouleur, 
                ['@undershirtid'] = undershirtid, 
                ['@undershirtdraw'] = undershirtdraw, 
                ['@torsosid'] = torsosid, 
                ['@torsosdraw'] = torsosdraw})
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
            TriggerClientEvent('nMenuNotif:showNotification', source, "~g~Tenue reçue !")
        else
            TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
        end
        TriggerClientEvent('GTA_Vetement:ChargerTenuePersoaa', source)
    end)
end)


RegisterServerEvent("GTA:UpdateSousVeste")
AddEventHandler("GTA:UpdateSousVeste", function(undershirtid, undershirtdraw, prix)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
    prix = prix or 0
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        local argentPropre = data.argent_propre
        if (tonumber(argentPropre) >= prix) then
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET undershirtsID=@undershirtid,undershirtsDraw=@undershirtdraw WHERE license=@license", {
                ['@license'] = license,
                ['@undershirtid'] = undershirtid, 
                ['@undershirtdraw'] = undershirtdraw})
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
            TriggerClientEvent('nMenuNotif:showNotification', source, "~g~Tenue reçue !")
        else
            TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
        end
        TriggerClientEvent('GTA_Vetement:ChargerTenuePersoaa', source)
    end)
end)

RegisterServerEvent("GTA:UpdatePantalonShop")
AddEventHandler("GTA:UpdatePantalonShop", function(legsid, legsdraw, legscouleur, prix)
	local source = source
    local license = GetPlayerIdentifiers(source)[1]
    prix = prix or 0

    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        local argentPropre = data.argent_propre
        if (tonumber(argentPropre) >= prix) then
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET legsID=@legsid,legsDraw=@legsdraw, legsCouleur=@legscouleur WHERE license=@license", {
                ['@license'] = license,
                ['@legsid'] = legsid, 
                ['@legsdraw'] = legsdraw,
                ['@legscouleur'] = legscouleur})
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
            TriggerClientEvent('nMenuNotif:showNotification', source, "~g~Tenue reçue !")
        else
            TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
        end
        TriggerClientEvent('GTA_Vetement:ChargerTenuePerso', source)
    end)
end)

RegisterServerEvent("GTA:UpdateChaussure")
AddEventHandler("GTA:UpdateChaussure", function(shoesid, shoesdraw, prix)
	local source = source
    local license = GetPlayerIdentifiers(source)[1]
    prix = prix or 0
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        local argentPropre = data.argent_propre
        if (tonumber(argentPropre) >= prix) then
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET shoesID=@shoesid,shoesDraw=@shoesdraw WHERE license=@license", {
                ['@license'] = license,
                ['@shoesid'] = shoesid, 
                ['@shoesdraw'] = shoesdraw})
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
            TriggerClientEvent('nMenuNotif:showNotification', source, "~g~Tenue reçue !")
        else
            TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
        end
        TriggerClientEvent('GTA_Vetement:ChargerTenuePerso', source)
    end)
end)

RegisterServerEvent("GTA:UpdateAccessoires")
AddEventHandler("GTA:UpdateAccessoires", function(acessoireid, acessoiredraw, prix)
	local source = source
    local license = GetPlayerIdentifiers(source)[1]
    prix = prix or 0
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        local argentPropre = data.argent_propre
        if (tonumber(argentPropre) >= prix) then
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET AccessoiresID=@acessoireid, AccessoiresDraw=@acessoiredraw WHERE license=@license", {
                ['@license'] = license,
                ['@acessoireid'] = acessoireid, 
                ['@acessoiredraw'] = acessoiredraw})
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
            TriggerClientEvent('nMenuNotif:showNotification', source, "~g~Tenue reçue !")
        else
            TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
        end
        TriggerClientEvent('GTA_Vetement:ChargerTenuePerso', source)
    end)
end)

RegisterServerEvent("GTA:UpdateChapeau")
AddEventHandler("GTA:UpdateChapeau", function(hatsid, hatsdraw, prix)
	local source = source
    local license = GetPlayerIdentifiers(source)[1]
    prix = prix or 0
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        local argentPropre = data.argent_propre
        if (tonumber(argentPropre) >= prix) then
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET HatsID=@hatsid, HatsDraw=@hatsdraw WHERE license=@license", {
                ['@license'] = license,
                ['@hatsid'] = hatsid, 
                ['@hatsdraw'] = hatsdraw})
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
            TriggerClientEvent('nMenuNotif:showNotification', source, "~g~Tenue reçue !")
        else
            TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
        end
        TriggerClientEvent('GTA_Vetement:ChargerTenuePerso', source)
    end)
end)