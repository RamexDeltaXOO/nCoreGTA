local menuPos = json.decode(LoadResourceFile(GetCurrentResourceName(), 'medics/json/ConfigPos.json'))
local Duree = 0

Citizen.CreateThread(function()
while true do
    Duree = 1000
    if config.Job == "Medic" then
        local playerPed  = GetPlayerPed(-1)
        local coords = GetEntityCoords(playerPed)

        -----------------------------> Vestiaire :
        for _,v in pairs(menuPos) do
            local distance = getDistance(coords, v.VestiaireHopital.PriseDeService)

            if distance <= 15 then
                Duree = 8
                DrawMarker(v.VestiaireHopital.MarkerCouleur.type, v.VestiaireHopital.PriseDeService.x, v.VestiaireHopital.PriseDeService.y, v.VestiaireHopital.PriseDeService.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3,1.3,0.05,v.VestiaireHopital.MarkerCouleur.r,v.VestiaireHopital.MarkerCouleur.g,v.VestiaireHopital.MarkerCouleur.b,v.VestiaireHopital.MarkerCouleur.a, false, true, 2, false, false, false, false)
            end
            
            if distance < 1 then
                Duree = 8
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour accéder au ~b~Vestiaire")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour accéder au ~b~Vestiaire")
                end
                
                if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
                    TriggerServerEvent("GTA:LoadJobsJoueur") --> charge le grade, le jobs puis le service du joueur. 
                    TriggerEvent("GTA_Medic:ChargerMenuVestiaire")
                    Wait(250)
                    TriggerEvent("GTA_Medic:OuvrirMenuVestiaire")
                end
            end
        end

        -----------------------------> Inventaire :
        for _,v in pairs(menuPos) do
            local distance = getDistance(coords, v.InventaireHopital.PositionArmurerie)
            
            if distance <= 15 then
                Duree = 8
                DrawMarker(v.InventaireHopital.MarkerCouleur.type, v.InventaireHopital.PositionArmurerie.x, v.InventaireHopital.PositionArmurerie.y, v.InventaireHopital.PositionArmurerie.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3,1.3,0.05,v.InventaireHopital.MarkerCouleur.r,v.InventaireHopital.MarkerCouleur.g,v.InventaireHopital.MarkerCouleur.b,v.InventaireHopital.MarkerCouleur.a, false, true, 2, false, false, false, false)
            end

            
            if distance < 1 then
                Duree = 8
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour accéder au ~b~Stockage d'item")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour accéder au ~b~Stockage d'item")
                end
                
                if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
                    TriggerEvent("GTA_Medic:OuvrirMenuStock")
                end
            end
        end

        -----------------------------> Garage Sortie Véhicule :
        for _,v in pairs(menuPos) do
            local distance = getDistance(coords, v.GarageMedic.GarageMenu)

            if distance <= 15 then
                Duree = 8
                DrawMarker(v.GarageMedic.MarkerCouleur.type, v.GarageMedic.GarageMenu.x, v.GarageMedic.GarageMenu.y, v.GarageMedic.GarageMenu.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3,1.3,0.05,v.GarageMedic.MarkerCouleur.r,v.GarageMedic.MarkerCouleur.g,v.GarageMedic.MarkerCouleur.b,v.GarageMedic.MarkerCouleur.a, false, true, 2, false, false, false, false)
            end


            if distance < 3 then
                Duree = 8
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour accéder au ~b~garage")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour accéder au ~b~garage")
                end
                
                if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
                    for i=1, #Config.Locations do
                        local myPeds = Config.Locations[i]["myPedsLocation"]
                        exports.nCoreGTA:Ninja_Core_PedsText("~r~Garage Hôpital ~w~ ~h~: Hey !", 1000)
                        PlayAmbientSpeech2(myPeds["entity"], "GENERIC_HI", "SPEECH_PARAMS_FORCE_SHOUTED") --> Sert a faire parler le ped plus l'animer.
                        TriggerServerEvent("GTA:LoadJobsJoueur")
                        Wait(250)
                        TriggerEvent("GTA_Medic:OuvrirGarageMenu")
                    end
                end
            end
        end

        -----------------------------> Garage Rentrer Véhicule :
        for _,v in pairs(menuPos) do
            local distance = getDistance(coords, v.GarageMedic.RentrerVeh)

            if distance <= 15 then
                Duree = 8
                DrawMarker(v.GarageMedic.MarkerCouleur.type, v.GarageMedic.RentrerVeh.x, v.GarageMedic.RentrerVeh.y, v.GarageMedic.RentrerVeh.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3,1.3,0.05,v.GarageMedic.MarkerCouleur.r,v.GarageMedic.MarkerCouleur.g,v.GarageMedic.MarkerCouleur.b,v.GarageMedic.MarkerCouleur.a, false, true, 2, false, false, false, false)
            end

            if distance < 5 then
                Duree = 8
                
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ~r~ranger ~w~ votre véhicule.")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour ~r~ranger ~w~ votre véhicule.")
                end
                
                if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
                    if IsPedInAnyVehicle(playerPed) then
                        local veh = GetVehiclePedIsIn(playerPed)
                        SetEntityAsMissionEntity(veh, true, true )
                        TriggerEvent("GTA_Police:RentrerPoliceVeh", veh)
                    else
                        exports.nCoreGTA:nNotificationMain({
                            text = "~r~Aucun véhicule trouver.",
                            type = 'basGauche',
                            nTimeNotif = 3000,
                        })
                    end 
                end
            end
        end
    else
        Duree = 5000
        end
        Citizen.Wait(Duree)
    end
end)