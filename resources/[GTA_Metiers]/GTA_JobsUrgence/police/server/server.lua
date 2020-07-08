local joueurMenotter = false
local items = {}

--[[
INFO : 
GRADE : 
    1 -> "Cadet"
    2 -> "Sergent"
    3 -> "SergentChef"
    4 -> "Lieutenant"
    5 -> "Capitaine"
]]

RegisterServerEvent('GTA_Police:Menotter_DemenotterServer')
AddEventHandler('GTA_Police:Menotter_DemenotterServer', function(target)
    joueurMenotter = not joueurMenotter
    if target ~= nil then
        
        if joueurMenotter == true then 
            TriggerClientEvent('nMenuNotif:showNotification', source, "l'individu est ~g~menotter")
            TriggerClientEvent('nMenuNotif:showNotification', target, "~b~La police ~w~vous ~r~menotte")
        else
            TriggerClientEvent('nMenuNotif:showNotification', target, "~b~La police ~w~vous ~g~démenotte")
            TriggerClientEvent('nMenuNotif:showNotification', source, "l'individu est ~r~démenotter")
        end

        TriggerClientEvent("GTA_Police:Menotter_Demenotter", target)
    end
end)

RegisterServerEvent("GTA_Police:Demander_IdentiterServer")
AddEventHandler("GTA_Police:Demander_IdentiterServer", function(target)
    if target ~= nil then
        TriggerClientEvent("GTA_Police:RequeteIdentiterJoueur", target)
    end
end)

RegisterServerEvent("GTA_Police:Regarder_IdentiterServer")
AddEventHandler("GTA_Police:Regarder_IdentiterServer", function(target)
    if target ~= nil then
        TriggerClientEvent("GTA_Police:MontrerIdentiterTarget", target)
    end
end)

RegisterServerEvent("GTA_Police:MettreJoueurVehicule")
AddEventHandler("GTA_Police:MettreJoueurVehicule", function(target, v)
    if target ~= nil then
        TriggerClientEvent('GTA_Police:ClientJoueurInVeh', target, v)
    end
end)

RegisterServerEvent("item:getItemsTarget")
AddEventHandler("item:getItemsTarget", function(target)
	items = {}
    local source = source
    if target ~= nil then
        local player = GetPlayerIdentifiers(target)[1]
        exports.ghmattimysql:execute("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_name` = `items`.`libelle` WHERE license=@username", { ['@username'] = player}, function(result)
            if (result) then
                for k,v in ipairs(result) do
                    t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle, ["isUsable"] = v.isUsable, ["type"] = v.type }
                    items[v.item_name] = t
                end
            end
            TriggerClientEvent("gui:getItemsTarget", source, items)
            TriggerClientEvent("GTA_Police:OuvrirInventaireSuspect", source)
        end)
    end
end)

RegisterServerEvent("item:supprimerItemTarget")
AddEventHandler("item:supprimerItemTarget", function(target, itemNameSelected, res, itemName)
    local source = source
    local quantity = math.floor(tonumber(res))
    if target ~= nil then
        TriggerClientEvent("player:looseItem", target, itemNameSelected, quantity)
        TriggerClientEvent('nMenuNotif:showNotification', source, "~w~Vous avez confisqué ~g~x"..quantity.. " ~b~" ..itemName)
        TriggerClientEvent('nMenuNotif:showNotification', target, "~w~La police vous a ~r~confisqué ~g~x" ..quantity.. " ~b~"..itemName)
    end
end)


RegisterServerEvent("GTA_Police:Demander_FouillerIndividu")
AddEventHandler("GTA_Police:Demander_FouillerIndividu", function(target)
    if target ~= nil then
        TriggerClientEvent("GTA_Police:RequeteInventaireJoueur", target)
    end
end)

RegisterServerEvent("GTA_Police:Demander_AutorisationAmende")
AddEventHandler("GTA_Police:Demander_AutorisationAmende", function(target, montant, raison)
    if target ~= nil then
        TriggerClientEvent("GTA_Police:RequeteAmendeJoueur", target, montant, raison)
    end
end)

RegisterServerEvent("GTA_Police:OpenTargetInventaire")
AddEventHandler("GTA_Police:OpenTargetInventaire", function(target)
    local source = source
    if target ~= nil then
        TriggerClientEvent('nMenuNotif:showNotification', source, "~r~La police procède à une fouille.")
        TriggerClientEvent('nMenuNotif:showNotification', target, "~g~l'individu se fait fouiller.")
        TriggerClientEvent("GTA_Police:OuvrirInventaireTarget", target)
    end
end)

RegisterServerEvent("GTA_Police:AmendeAutoriser")
AddEventHandler("GTA_Police:AmendeAutoriser", function(target, prix)
    local source = source
    TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
        local argentPropre = data.argent_propre
        if target ~= nil then
            if (tonumber(argentPropre) >= prix) then
                TriggerEvent('GTA:RetirerArgentPropre', source, tonumber(prix))
                TriggerClientEvent('nMenuNotif:showNotification', source, "~g~Amende payer.")
                TriggerClientEvent('nMenuNotif:showNotification', target, "L'individu vient de ~g~payer~w~ son amende !")
            else
                TriggerClientEvent('nMenuNotif:showNotification', target, "~r~L'individu n'a pas assez d'argent !")
                TriggerClientEvent('nMenuNotif:showNotification', source, "~r~Tu n'as pas suffisamment d'argent !")
            end
        end
    end)
end)


RegisterServerEvent('GTA_Police:verifierPlaqueImmatricule')
AddEventHandler('GTA_Police:verifierPlaqueImmatricule', function(plaque)
	local source = source	
	local player = GetPlayerIdentifiers(source)[1]
    local newPlaque = nil
    local newName = ""
    local newPrenom = ""

    exports.ghmattimysql:execute("SELECT * FROM gta_joueurs_vehicle JOIN gta_joueurs ON `gta_joueurs_vehicle`.`identifier` = `gta_joueurs`.`license` WHERE vehicle_plate=@plaque", { ['@plaque'] = plaque}, function(result)
        if result ~= nil then

            ---> Insert les nouvel donnée pour les comparer :
            for _,v in pairs(result) do
                --print("PLAQUE: ", plaque)
                --print("RESULT: ", v.vehicle_plate)
                newPlaque = v.vehicle_plate
                newName = v.nom
                newPrenom = v.prenom
            end

            ---> on compare les nouvel donnée : 
            if (newPlaque == plaque) then
                TriggerClientEvent('nMenuNotif:showNotification', source, "Le véhicule #"..plaque.." appartient a " .. newName .. " " ..newPrenom)
            else
                TriggerClientEvent('nMenuNotif:showNotification', source, "Le véhicule #"..plaque.." n'est pas enregistré !")
            end
        end
    end)
end)

-----------------------------------------------------------------> GESTION EMPLOYER :
RegisterServerEvent('GTA_Police:RecruterIndividu')
AddEventHandler('GTA_Police:RecruterIndividu', function(target)
	local source = source	
    local targetP = GetPlayerIdentifiers(target)[1]
    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['job'] = "Police"}, {['license'] = targetP} })
    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['grade'] = "Cadet"}, {['license'] = targetP} })

    exports.ghmattimysql:execute("SELECT nom, prenom FROM gta_joueurs WHERE license = @license", { ['@license'] = targetP}, function(res)
        TriggerClientEvent('nMenuNotif:showNotification', source, "Vous avez ~g~recruté~b~ " ..res[1].nom.. " " .. res[1].prenom.. "~w~.")
    end)

    TriggerClientEvent('nMenuNotif:showNotification', target, "Vous avez été ~g~recruté~w~.")
end)

RegisterServerEvent('GTA_Police:VirerIndividu')
AddEventHandler('GTA_Police:VirerIndividu', function(target)
	local source = source	
    local targetP = GetPlayerIdentifiers(target)[1]
    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['job'] = "Chomeur"}, {['license'] = targetP} })
    exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['grade'] = "Aucun"}, {['license'] = targetP} })
    exports.ghmattimysql:execute("SELECT nom, prenom FROM gta_joueurs WHERE license = @license", { ['@license'] = targetP}, function(res)
        TriggerClientEvent('nMenuNotif:showNotification', source, "Vous avez ~r~viré~b~ " ..res[1].nom.. " " .. res[1].prenom.. "~w~.")
    end)

    TriggerClientEvent('nMenuNotif:showNotification', target, "Vous avez été ~r~viré~w~.")
end)