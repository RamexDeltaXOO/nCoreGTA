local menuPos = json.decode(LoadResourceFile(GetCurrentResourceName(), 'police/json/ConfigPos.json'))
local Duree = 0

Citizen.CreateThread(function()
while true do
    Duree = 1000
    if config.Job == "Police" then
        local playerPed  = GetPlayerPed(-1)
        local coords = GetEntityCoords(playerPed)
            -----------------------------> Vestiaire :
            for _,v in pairs(menuPos) do
                local distance = getDistance(coords, v.VestiairePolice.PriseDeService)
                
                if distance <= 15 then
                    Duree = 8
                    DrawMarker(v.VestiairePolice.MarkerCouleur.type, v.VestiairePolice.PriseDeService.x, v.VestiairePolice.PriseDeService.y, v.VestiairePolice.PriseDeService.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3,1.3,0.05,v.VestiairePolice.MarkerCouleur.r,v.VestiairePolice.MarkerCouleur.g,v.VestiairePolice.MarkerCouleur.b,v.VestiairePolice.MarkerCouleur.a, false, true, 2, false, false, false, false)
                end

                if distance < 1 then
                    Duree = 8
                    if GetLastInputMethod(0) then
                        Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour accéder au ~b~Vestiaire")
                    else
                        Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour accéder au ~b~Vestiaire")
                    end
                    
                    if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
                        TriggerServerEvent("GTA:LoadJobsJoueur")
                        TriggerEvent("GTA_Police:ChargerMenuVestiaire")
                        Wait(250)
                        TriggerEvent("GTA_Police:OuvrirMenuVestiaire")
                    end
                end
            end
            -----------------------------> Armurerie :
            for _,v in pairs(menuPos) do
                local distance = getDistance(coords, v.ArmureriePolice.PositionArmurerie)
                
                if distance <= 15 then
                    Duree = 8
                    DrawMarker(v.ArmureriePolice.MarkerCouleur.type, v.ArmureriePolice.PositionArmurerie.x, v.ArmureriePolice.PositionArmurerie.y, v.ArmureriePolice.PositionArmurerie.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3,1.3,0.05,v.ArmureriePolice.MarkerCouleur.r,v.ArmureriePolice.MarkerCouleur.g,v.ArmureriePolice.MarkerCouleur.b,v.ArmureriePolice.MarkerCouleur.a, false, true, 2, false, false, false, false)
                end

                if distance < 5 then
                    Duree = 8
                    if GetLastInputMethod(0) then
                        Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour accéder à ~b~L'armurerie")
                    else
                        Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour accéder à ~b~L'armurerie")
                    end
                    
                    if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
                        for i=1, #Config.Locations do
                            local myPeds = Config.Locations[i]["myPedsLocation"]
                            exports.nCoreGTA:Ninja_Core_PedsText("~r~Armurerie Police ~w~ ~h~: Hey !", 1000)
                            PlayAmbientSpeech2(myPeds["entity"], "GENERIC_HI", "SPEECH_PARAMS_FORCE_SHOUTED") --> Sert a faire parler le ped plus l'animer.
                        end
                        TriggerServerEvent("GTA:LoadJobsJoueur")
                        Wait(250)
                        TriggerEvent("GTA_Police:OuvrirMenuArmu")
                    end
                end
            end

            -----------------------------> Garage Sortie Véhicule :
            for _,v in pairs(menuPos) do
                local distance = getDistance(coords, v.GaragePolice.SortieVeh)

                if distance <= 15 then
                    Duree = 8
                    DrawMarker(v.GaragePolice.MarkerCouleur.type, v.GaragePolice.SortieVeh.x, v.GaragePolice.SortieVeh.y, v.GaragePolice.SortieVeh.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3,1.3,0.05,v.GaragePolice.MarkerCouleur.r,v.GaragePolice.MarkerCouleur.g,v.GaragePolice.MarkerCouleur.b,v.GaragePolice.MarkerCouleur.a, false, true, 2, false, false, false, false)
                end

                if distance < 5 then
                    Duree = 8
                    if GetLastInputMethod(0) then
                        Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour accéder au ~b~garage")
                    else
                        Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour accéder au ~b~garage")
                    end
                    
                    if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
                        for i=1, #Config.Locations do
                            local myPeds = Config.Locations[i]["myPedsLocation"]
                            exports.nCoreGTA:Ninja_Core_PedsText("~r~Garage Police ~w~ ~h~: Hey !", 1000)
                            PlayAmbientSpeech2(myPeds["entity"], "GENERIC_HI", "SPEECH_PARAMS_FORCE_SHOUTED") --> Sert a faire parler le ped plus l'animer.
                        end
                        TriggerServerEvent("GTA:LoadJobsJoueur")
                        Wait(250)
                        TriggerEvent("GTA_Police:OuvrirGarageMenu")
                    end
                end
            end

            -----------------------------> Garage Rentrer Véhicule :
            for _,v in pairs(menuPos) do
                local distance = getDistance(coords, v.GaragePolice.RentrerVeh)
                
                if distance <= 15 then
                    Duree = 8
                    DrawMarker(v.GaragePolice.MarkerCouleur.type, v.GaragePolice.RentrerVeh.x, v.GaragePolice.RentrerVeh.y, v.GaragePolice.RentrerVeh.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.3,1.3,0.05,v.GaragePolice.MarkerCouleur.r,v.GaragePolice.MarkerCouleur.g,v.GaragePolice.MarkerCouleur.b,v.GaragePolice.MarkerCouleur.a, false, true, 2, false, false, false, false)
                end

                if distance < 5 then
                    Duree = 8
                    if GetLastInputMethod(0) then
                        Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ~r~ranger ~w~ votre véhicule de patrouille.")
                    else
                        Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour ~r~ranger ~w~ votre véhicule de patrouille.")
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