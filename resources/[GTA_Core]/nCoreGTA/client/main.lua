--@Super.Cool.Ninja

RegisterNetEvent("GTA:JoueurLoaded")
AddEventHandler("GTA:JoueurLoaded", function()

    --> Stop Dispatch
    Citizen.CreateThread(function()
        for i = 1, 12 do
            Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
        end
    end)

    --> PVP :
    if config.activerPvp == true then
        for _, player in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(player)
            SetCanAttackFriendly(ped, true, true)
            NetworkSetFriendlyFireOption(true)
        end
    end

    --> COPS :
    if config.activerPoliceWanted == false then
        Citizen.CreateThread(function()
            local myPlayer = GetEntityCoords(PlayerPedId())	
            while true do
                Citizen.Wait(0)
                
                --> Permet de ne pas recevoir d'indice de recherche :
                if (GetPlayerWantedLevel(PlayerId()) > 0) then
                    SetPlayerWantedLevel(PlayerId(), 0, false)
                    SetPlayerWantedLevelNow(PlayerId(), false)
                end

                --> Permet de ne pas spawn les véhicule de cops prés du poste de police :
                ClearAreaOfCops(myPlayer.x, myPlayer.y, myPlayer.z, 5000.0)
            end
        end)
    end

    --> Salaire :
    Citizen.CreateThread(function ()
        while true do
        Citizen.Wait(config.salaireTime)
            TriggerServerEvent("GTA:salaire")
        end
    end)

    --> Permet d'afficher votre version utilisée :
    if config.activerVersionDebug == true then 
        Citizen.CreateThread(function()
            while true do
                Wait(1)
                SetTextColour(255, 255, 255, 125)
                SetTextFont(0)
                SetTextScale(0.3 + 0.08, 0.3 + 0.08)
                SetTextCentre(false)
                SetTextEntry("STRING")
                AddTextComponentString(config.versionCore)
                DrawText(0.40, 0.001)
            end
        end)
    end
end)

RegisterNetEvent("GTA:AfficherArgentPropre")
AddEventHandler("GTA:AfficherArgentPropre", function(value)
	StatSetInt("MP0_WALLET_BALANCE", value, true)
	ShowHudComponentThisFrame(4)
	CancelEvent()
end)

RegisterNetEvent("GTA:AfficherBanque")
AddEventHandler("GTA:AfficherBanque", function(value)
	StatSetInt("BANK_BALANCE", value, true)
	ShowHudComponentThisFrame(3)	
	CancelEvent()
end)