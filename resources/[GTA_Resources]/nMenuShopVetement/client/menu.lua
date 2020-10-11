tShirtMenu = RageUI.CreateMenu("T-Shirt",  "Magasin de vetement.")
pullMenu = RageUI.CreateMenu("Pull",  "Magasin de vetement.")
vesteMenu = RageUI.CreateMenu("Veste",  "Magasin de vetement.")
pantalonMenu = RageUI.CreateMenu("Pantalon",  "Magasin de vetement.")
chaussureMenu = RageUI.CreateMenu("Chaussure",  "Magasin de vetement.")




local prix = 0
local itemName = " "
local Duree = 0
local index_tShirt, index_pull, indexVeste, indexPantalon, indexChaussure = 1, 1, 1, 1, 1


--> TShirt Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(tShirtMenu, function()
			for i = 1, #Config.Locations do
                local tShirtPos = Config.Locations[i]["MagasinDeVetement"]["TShirtPos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, tShirtPos["x"], tShirtPos["y"], tShirtPos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('TShirt', tTshirtLabel, index_tShirt, "", {}, true, {
                        onListChange = function(Index, Item)
                            index_tShirt = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 11, tTshirtValue[index_tShirt][1], tTshirtValue[index_tShirt][2], 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 8, tTshirtValue[index_tShirt][5], 0, 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 3, tTshirtValue[index_tShirt][4], 0, 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouveauTshirt", tTshirtValue[index_tShirt][1], tTshirtValue[index_tShirt][2], tTshirtValue[index_tShirt][3], tTshirtValue[index_tShirt][4], tTshirtValue[index_tShirt][5])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)


--> Pull Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(pullMenu, function()
			for i = 1, #Config.Locations do
                local pullPos = Config.Locations[i]["MagasinDeVetement"]["PullPos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, pullPos["x"], pullPos["y"], pullPos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Pull', tPullLabel, index_pull, "", {}, true, {
                        onListChange = function(Index, Item)
                            index_pull = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 11, tPullValue[index_pull][1], tPullValue[index_pull][2], 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 8,  tPullValue[index_pull][5], 0, 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 3,  tPullValue[index_pull][4], 0, 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouveauPull", tPullValue[index_pull][1], tPullValue[index_pull][2], tPullValue[index_pull][3], tPullValue[index_pull][4], tPullValue[index_pull][5])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)

--> Veste Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(vesteMenu, function()
			for i = 1, #Config.Locations do
                local vestePos = Config.Locations[i]["MagasinDeVetement"]["VestePos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, vestePos["x"], vestePos["y"], vestePos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Veste', tVesteLabel, indexVeste, "", {}, true, {
                        onListChange = function(Index, Item)
                            indexVeste = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 11, tVesteValue[indexVeste][1], tVesteValue[indexVeste][2], 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 8,  tVesteValue[indexVeste][5], 0, 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 3,  tVesteValue[indexVeste][4], 0, 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouvelVeste", tVesteValue[indexVeste][1], tVesteValue[indexVeste][2], tVesteValue[indexVeste][3], tVesteValue[indexVeste][4], tVesteValue[indexVeste][5])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)


--> Pantalon Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(pantalonMenu, function()
			for i = 1, #Config.Locations do
                local pantalonPos = Config.Locations[i]["MagasinDeVetement"]["PantalonPos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, pantalonPos["x"], pantalonPos["y"], pantalonPos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Pantalon', tPantalonLabel, indexPantalon, "", {}, true, {
                        onListChange = function(Index, Item)
                            indexPantalon = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 4, tPantalonValue[indexPantalon][1], tPantalonValue[indexPantalon][2], 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouveauPantalon", tPantalonValue[indexPantalon][1], tPantalonValue[indexPantalon][2], tPantalonValue[indexPantalon][3])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)

--> Chaussure Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(chaussureMenu, function()
			for i = 1, #Config.Locations do
                local chaussurePos = Config.Locations[i]["MagasinDeVetement"]["ChaussurePos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, chaussurePos["x"], chaussurePos["y"], chaussurePos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Pantalon', tChaussureLabel, indexChaussure, "", {}, true, {
                        onListChange = function(Index, Item)
                            indexChaussure = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 6, tChaussureValue[indexChaussure][1], tChaussureValue[indexChaussure][2], 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouvelChaussure", tChaussureValue[indexChaussure][1], tChaussureValue[indexChaussure][2], tChaussureValue[indexChaussure][3])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)

Citizen.CreateThread(function()
    while true do
        Duree = 250
        if IsNearOfZones() then
            Duree = 0
            
            if GetLastInputMethod(0) then
                Ninja_Core__DisplayHelpAlert("~INPUT_PICKUP~ pour ~b~intéragir")
            else
                Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~b~intéragir")
            end
        end

        if GetNearZone() == "TshirtMenu" then 
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
               RageUI.Visible(tShirtMenu, not RageUI.Visible(tShirtMenu))
            end
        elseif GetNearZone() == "PullMenu" then
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(pullMenu, not RageUI.Visible(pullMenu))
            end
        elseif GetNearZone() == "VesteMenu" then
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(vesteMenu, not RageUI.Visible(vesteMenu))
            end
        elseif GetNearZone() == "PantalonMenu" then 
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(pantalonMenu, not RageUI.Visible(pantalonMenu))
            end
        elseif GetNearZone() == "ChaussureMenu" then 
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(chaussureMenu, not RageUI.Visible(chaussureMenu))
            end
        end

        if RageUI.Visible(tShirtMenu) or RageUI.Visible(pullMenu) or RageUI.Visible(vesteMenu) or RageUI.Visible(pantalonMenu) or RageUI.Visible(chaussureMenu) == true then 
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
            DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT  
        end

       Citizen.Wait(Duree)
   end
end)