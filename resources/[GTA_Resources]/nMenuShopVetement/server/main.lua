RegisterServerEvent("GTA_Vetement:NouveauTshirt")
AddEventHandler("GTA_Vetement:NouveauTshirt", function(drawID, couleurID, prix, torsosID, undershirtID)
    prix = prix or 0
    local source = source	
    local player = GetPlayerIdentifiers(source)[1]
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        if (data.argent_propre >= prix) then 
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement accepté !")
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET topsDraw=@drawID,topsCouleur=@couleurID, torsosDraw=@torsosDraw, undershirtsDraw=@undershirtsDraw WHERE license=@license", {
                ['@license'] = player,
                ['@drawID'] = drawID, 
                ['@couleurID'] = couleurID,
                ['@torsosDraw'] = torsosID,
                ['@undershirtsDraw'] = undershirtID
            })
        else
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement refusé !")
        end
    end)
end)

RegisterServerEvent("GTA_Vetement:NouveauPull")
AddEventHandler("GTA_Vetement:NouveauPull", function(drawID, couleurID, prix, torsosID, undershirtID)
    prix = prix or 0
    local source = source	
    local player = GetPlayerIdentifiers(source)[1]
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        if (data.argent_propre >= prix) then 
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement accepté !")
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET topsDraw=@drawID,topsCouleur=@couleurID, torsosDraw=@torsosDraw, undershirtsDraw=@undershirtsDraw WHERE license=@license", {
                ['@license'] = player,
                ['@drawID'] = drawID, 
                ['@couleurID'] = couleurID,
                ['@torsosDraw'] = torsosID,
                ['@undershirtsDraw'] = undershirtID
            })
        else
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement refusé !")
        end
    end)
end)

RegisterServerEvent("GTA_Vetement:NouvelVeste")
AddEventHandler("GTA_Vetement:NouvelVeste", function(drawID, couleurID, prix, torsosID, undershirtID)
    prix = prix or 0
    local source = source	
    local player = GetPlayerIdentifiers(source)[1]
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        if (data.argent_propre >= prix) then 
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement accepté !")
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET topsDraw=@drawID,topsCouleur=@couleurID, torsosDraw=@torsosDraw, undershirtsDraw=@undershirtsDraw WHERE license=@license", {
                ['@license'] = player,
                ['@drawID'] = drawID, 
                ['@couleurID'] = couleurID,
                ['@torsosDraw'] = torsosID,
                ['@undershirtsDraw'] = undershirtID
            })
        else
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement refusé !")
        end
    end)
end)

RegisterServerEvent("GTA_Vetement:NouveauPantalon")
AddEventHandler("GTA_Vetement:NouveauPantalon", function(drawID, couleurID, prix)
    prix = prix or 0
    local source = source	
    local player = GetPlayerIdentifiers(source)[1]
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        if (data.argent_propre >= prix) then 
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement accepté !")
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET legsDraw=@drawID,legsCouleur=@couleurID WHERE license=@license", {
                ['@license'] = player,
                ['@drawID'] = drawID, 
                ['@couleurID'] = couleurID
            })
        else
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement refusé !")
        end
    end)
end)

RegisterServerEvent("GTA_Vetement:NouvelChaussure")
AddEventHandler("GTA_Vetement:NouvelChaussure", function(drawID, couleurID, prix)
    prix = prix or 0
    local source = source	
    local player = GetPlayerIdentifiers(source)[1]
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        if (data.argent_propre >= prix) then 
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement accepté !")
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET shoesDraw=@drawID,shoesCouleur=@couleurID WHERE license=@license", {
                ['@license'] = player,
                ['@drawID'] = drawID, 
                ['@couleurID'] = couleurID
            })
        else
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement refusé !")
        end
    end)
end)

RegisterServerEvent("GTA_Vetement:NouveauBonnet")
AddEventHandler("GTA_Vetement:NouveauBonnet", function(drawID, prix)
    prix = prix or 0
    local source = source	
    local player = GetPlayerIdentifiers(source)[1]
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        if (data.argent_propre >= prix) then 
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement accepté !")
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET HatsDraw=@drawID WHERE license=@license", {
                ['@license'] = player,
                ['@drawID'] = drawID
            })
        else
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement refusé !")
        end
    end)
end)

RegisterServerEvent("GTA_Vetement:NouveauAccessoire")
AddEventHandler("GTA_Vetement:NouveauAccessoire", function(drawID, prix)
    prix = prix or 0
    local source = source	
    local player = GetPlayerIdentifiers(source)[1]
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        if (data.argent_propre >= prix) then 
            TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement accepté !")
            exports.ghmattimysql:execute(
                "UPDATE gta_joueurs_vetement SET AccessoiresDraw=@drawID WHERE license=@license", {
                ['@license'] = player,
                ['@drawID'] = drawID
            })
        else
			TriggerClientEvent('nMenuNotif:showNotification', source, "Paiement refusé !")
        end
    end)
end)