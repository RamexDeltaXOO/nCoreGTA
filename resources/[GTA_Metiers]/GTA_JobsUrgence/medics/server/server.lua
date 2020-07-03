RegisterServerEvent('GTA_Medic:SoignerTarget')
AddEventHandler('GTA_Medic:SoignerTarget', function(target)
	TriggerClientEvent('GTA_Medic:TargetSoigner',target)
end)

RegisterServerEvent('GTA_Medic:ReanimerTarget')
AddEventHandler('GTA_Medic:ReanimerTarget', function(target)
	TriggerClientEvent('GTA_Medic:TargetReanimer', target)
end)

RegisterServerEvent("GTA_Medic:Demander_AutorisationFacture")
AddEventHandler("GTA_Medic:Demander_AutorisationFacture", function(target, montant, raison)
    if target ~= nil then
        TriggerClientEvent("GTA_Medic:RequeteFactureTarget", target, montant, raison)
    end
end)

RegisterServerEvent("GTA_Medic:FactureAutoriser")
AddEventHandler("GTA_Medic:FactureAutoriser", function(target, prix)
    local source = source
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        local argentPropre = data.argent_propre
        if target ~= nil then
            if (tonumber(argentPropre) >= prix) then
                TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
                TriggerClientEvent('nMenuNotif:showNotification', source, "~g~Facture payer.")
                TriggerClientEvent('nMenuNotif:showNotification', target, "L'individu vient de ~g~payer~w~ votre facture !")
            else
                TriggerClientEvent('nMenuNotif:showNotification', target, "~r~L'individu n'a pas assez d'argent !")
                TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
            end
        end
    end)
end)


-----------------------------------------------------------------> GESTION EMPLOYER :
RegisterServerEvent('GTA_Medic:RecruterIndividu')
AddEventHandler('GTA_Medic:RecruterIndividu', function(target)
	local source = source	
    local targetP = GetPlayerIdentifiers(target)[1]
    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['job'] = "Medic"}, {['license'] = targetP} })
    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['grade'] = "Stagiaire"}, {['license'] = targetP} })

    exports.ghmattimysql:execute("SELECT nom, prenom FROM gta_joueurs WHERE license = @license", { ['@license'] = targetP}, function(res)
        TriggerClientEvent('nMenuNotif:showNotification', source, "Vous avez ~g~recruté~b~ " ..res[1].nom.. " " .. res[1].prenom.. "~w~.")
    end)

    TriggerClientEvent('nMenuNotif:showNotification', target, "Vous avez été ~g~recruté~w~.")
end)

RegisterServerEvent('GTA_Medic:VirerIndividu')
AddEventHandler('GTA_Medic:VirerIndividu', function(target)
	local source = source	
    local targetP = GetPlayerIdentifiers(target)[1]
    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['job'] = "Chomeur"}, {['license'] = targetP} })
    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['grade'] = "Aucun"}, {['license'] = targetP} })
    exports.ghmattimysql:execute("SELECT nom, prenom FROM gta_joueurs WHERE license = @license", { ['@license'] = targetP}, function(res)
        TriggerClientEvent('nMenuNotif:showNotification', source, "Vous avez ~r~viré~b~ " ..res[1].nom.. " " .. res[1].prenom.. "~w~.")
    end)

    TriggerClientEvent('nMenuNotif:showNotification', target, "Vous avez été ~r~viré~w~.")
end)