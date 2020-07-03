RegisterServerEvent("GTA_Requete:NotifRefuser")
AddEventHandler("GTA_Requete:NotifRefuser", function(target)
    if target ~= nil then
        TriggerClientEvent('nMenuNotif:showNotification', target, "~r~l'individu a refusé votre requete")
    end
end)


-----------------------------------------------------------------> RETROGRADEMENT :
RegisterServerEvent('GTA:RetroTarget')
AddEventHandler('GTA:RetroTarget', function(target, grade)
	local source = source	
    local targetP = GetPlayerIdentifiers(target)[1]

    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['grade'] = grade}, {['license'] = targetP} })

    exports.ghmattimysql:execute("SELECT nom, prenom FROM gta_joueurs WHERE license = @license", { ['@license'] = targetP}, function(res)
        TriggerClientEvent('nMenuNotif:showNotification', source, "Vous avez ~r~rétrogradé~b~ " ..res[1].nom.. " " .. res[1].prenom.. " en ".. grade.."~w~.")
    end)

    TriggerClientEvent('nMenuNotif:showNotification', target, "Vous avez été ~r~rétrogradé~w~ en "..grade..".")
end)

-----------------------------------------------------------------> PROMOUVOIR :
RegisterServerEvent('GTA:PromouvoirTarget')
AddEventHandler('GTA:PromouvoirTarget', function(target, grade)
	local source = source	
    local targetP = GetPlayerIdentifiers(target)[1]

    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['grade'] = grade}, {['license'] = targetP} })

    exports.ghmattimysql:execute("SELECT nom, prenom FROM gta_joueurs WHERE license = @license", { ['@license'] = targetP}, function(res)
        TriggerClientEvent('nMenuNotif:showNotification', source, "Vous avez ~g~promu~b~ " ..res[1].nom.. " " .. res[1].prenom.. " en "..grade.."~w~.")
    end)

    TriggerClientEvent('nMenuNotif:showNotification', target, "Vous avez été ~g~promu~w~ en "..grade..".")
end)