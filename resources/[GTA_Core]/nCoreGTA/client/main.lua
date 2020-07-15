--@Super.Cool.Ninja

local waitWantedLevel = 5

RegisterNetEvent("GTA:JoueurLoaded")
AddEventHandler("GTA:JoueurLoaded", function()
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
                Citizen.Wait(waitWantedLevel)
                
                --> Permet de ne pas recevoir d'indice de recherche :
                if (GetPlayerWantedLevel(PlayerId()) > 0) then
				    waitWantedLevel = 0
                    SetPlayerWantedLevel(PlayerId(), 0, false)
                    SetPlayerWantedLevelNow(PlayerId(), false)
				else
				    waitWantedLevel = 5
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

    local ipls = {'facelobby', 'farm', 'farmint', 'farm_lod', 'farm_props', 
                'des_farmhouse', 'post_hiest_unload', 'v_tunnel_hole',
                'rc12b_default', 'refit_unload', 'shr_int'}

    for _,v in pairs(ipls) do
        if not IsIplActive(v) then
            RequestIpl(v)
        end
    end
end)

RegisterNetEvent("GTA:AfficherArgentPropre")
AddEventHandler("GTA:AfficherArgentPropre", function(value)
	StatSetInt("MP0_WALLET_BALANCE", value, false)
    ShowHudComponentThisFrame(4)

    Wait(1000)
    RemoveMultiplayerBankCash(0xC7C6789AA1CFEDD0)
end)

RegisterNetEvent("GTA:AfficherBanque")
AddEventHandler("GTA:AfficherBanque", function(value)
	StatSetInt("BANK_BALANCE", value, true)
    ShowHudComponentThisFrame(3)
    
    Wait(1000)
    RemoveMultiplayerHudCash(0x968F270E39141ECA)
end)

RegisterNetEvent("GTA:AjoutSonPayer")
AddEventHandler("GTA:AjoutSonPayer", function()
    PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
end)