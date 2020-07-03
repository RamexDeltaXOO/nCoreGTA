--> Variable : 
local cuffed = false
local ped = PlayerPedId()
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local requestIdentiter = false
local requestInventaire = false
local requestAmende = false
local amendeMontant = 0
local raisonAmende = ""
local Duree = 1000

--> Event :
RegisterNetEvent('GTA_Police:Menotter_Demenotter')
AddEventHandler('GTA_Police:Menotter_Demenotter', function()
    ped = PlayerPedId()
    RequestAnimDict("mp_arresting")
    
    while not HasAnimDictLoaded("mp_arresting") do
        Citizen.Wait(0)
    end
    
    if cuffed then
        ClearPedTasks(ped)
        SetEnableHandcuffs(ped, false)
        UncuffPed(ped)
        if GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
        elseif GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end
    else
        if GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then -- mp female
            prevFemaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 25, 0, 0)
        elseif GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then -- mp male
            prevMaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 41, 0, 0)
        end
        SetEnableHandcuffs(ped, true)
        TaskPlayAnim(ped, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
        
    end
    cuffed = not cuffed
    changed = true
end)

RegisterNetEvent('GTA_Police:ClientJoueurInVeh')
AddEventHandler('GTA_Police:ClientJoueurInVeh', function(veh)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

    if vehicleHandle ~= nil then
        SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
    end
end)

RegisterNetEvent('GTA_Police:CrocheterVehicule')
AddEventHandler('GTA_Police:CrocheterVehicule', function()
    local veh = GetVehicleNearOfMe()
    if veh ~= false then
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
        Citizen.Wait(10000)
        SetVehicleDoorsLocked(veh, 1)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        exports.nCoreGTA:nNotificationMain({
            text = "~g~Le véhicule est ouvert.",
            type = 'basGauche',
            nTimeNotif = 1000,
        })
    else
        exports.nCoreGTA:nNotificationMain({
            text = "~r~Aucun véhicule prés de vous.",
            type = 'basGauche',
            nTimeNotif = 1000,
        })
    end
end)

RegisterNetEvent('GTA_Police:CheckPlaqueImatricule')
AddEventHandler('GTA_Police:CheckPlaqueImatricule', function()
    local veh = GetVehicleNearOfMe()
    if(DoesEntityExist(veh)) then
		TriggerServerEvent("GTA_Police:verifierPlaqueImmatricule", GetVehicleNumberPlateText(veh))
    else
        exports.nCoreGTA:nNotificationMain({
            text = "~r~Aucun véhicule prés de vous.",
            type = 'basGauche',
            nTimeNotif = 1000,
        })
	end
end)

RegisterNetEvent("GTA_Police:RequeteIdentiterJoueur")
AddEventHandler("GTA_Police:RequeteIdentiterJoueur", function()
    requestIdentiter = true
    PlaySound(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
    exports.nCoreGTA:nNotificationMain({
        text = "~y~ Y ~w~pour montrer votre identité, ~r~L ~w~ pour refuser",
        type = 'milieuGauche',
        nTimeNotif = 15000,
    })
    Duree = 0
end)


RegisterNetEvent("GTA_Police:RequeteInventaireJoueur")
AddEventHandler("GTA_Police:RequeteInventaireJoueur", function()
    requestInventaire = true
    PlaySound(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
    exports.nCoreGTA:nNotificationMain({
        text = "~y~ Y ~w~pour accepter d'être fouiller, ~r~L ~w~ pour refuser",
        type = 'milieuGauche',
        nTimeNotif = 15000,
    })
    Duree = 0
end)

RegisterNetEvent("GTA_Police:RequeteAmendeJoueur")
AddEventHandler("GTA_Police:RequeteAmendeJoueur", function(montant, raison)
	requestAmende = true
    amendeMontant = montant
    raisonAmende = raison
    PlaySound(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
    exports.nCoreGTA:nNotificationMain({
        text = "~y~ Y ~w~pour ~g~payer~w~ votre amende ~r~L ~w~ pour ~r~refuser",
        type = 'milieuGauche',
        nTimeNotif = 15000,
    })
    Duree = 0
end)

RegisterNetEvent("GTA_Police:MontrerIdentiterTarget")
AddEventHandler("GTA_Police:MontrerIdentiterTarget", function()
	target, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
        requestIdentiter = false
        Duree = 1000
		TriggerServerEvent("GTA:MontrerSonIdentiter", GetPlayerServerId(target))
        exports.nCoreGTA:nNotificationMain({
            text = "~b~La police~g~ vérifie votre identité.",
            type = 'basGauche',
            nTimeNotif = 6000,
        })
    else
        exports.nCoreGTA:nNotificationMain({
            text = "~r~Aucune personne proche de vous.",
            type = 'basGauche',
            nTimeNotif = 6000,
        })
	end
end)

--Check si il est Policier, on affiche les blips :
RegisterNetEvent("GTA_Police:AfficherBlipsPoint")
AddEventHandler('GTA_Police:AfficherBlipsPoint', function ()
    --Sortie des veh :
    PoliceSortieVeh = AddBlipForCoord(463.499, -1019.33, 28.1039)
    SetBlipSprite(PoliceSortieVeh,225)		
    SetBlipColour(PoliceSortieVeh, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('SORTIE VEHICULE')
	EndTextCommandSetBlipName(PoliceSortieVeh)
	
	--Rentrer veh :
	PoliceDeleteVeh = AddBlipForCoord(451.999, -997.16, 25.7613)
	SetBlipSprite(PoliceDeleteVeh,225)		
	SetBlipColour(PoliceDeleteVeh, 69)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('GARAGE VEHICULE')
    EndTextCommandSetBlipName(PoliceDeleteVeh)
end)

RegisterNetEvent("GTA_Police:RetirerBlipsPoint")
AddEventHandler("GTA_Police:RetirerBlipsPoint", function ()

    --On retire le blip sortie véhicule si la personne n'est plus flics :
    if PoliceSortieVeh ~= nil and DoesBlipExist(PoliceSortieVeh) then
        Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(PoliceSortieVeh))
        PoliceSortieVeh = nil
	end
	
	--On retire le blip garage véhicule si la personne n'est plus flics :
	if PoliceDeleteVeh ~= nil and DoesBlipExist(PoliceDeleteVeh) then
		Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(PoliceDeleteVeh))
		PoliceDeleteVeh = nil
	end
end)

RegisterNetEvent("GTA_Police:onServicePolice")
AddEventHandler("GTA_Police:onServicePolice", function()
    local ped = GetPlayerPed(-1)
    if config.Job ~= "Police" then
        return
    end
	if config.Service then
        TriggerServerEvent("GTA:LoadVetement")
        exports.nCoreGTA:nNotificationMain({
            text = "~h~Fin de ~r~service.",
            type = 'basGauche',
            nTimeNotif = 1000,
        })

		TriggerServerEvent("player:serviceOff", "police") --> On lui retire le service pour  ne plus recevoir les appel d'urgence.
		TriggerEvent("GTA_Police:RetirerBlipsPoint") --> On retire les blips 
	else
        exports.nCoreGTA:nNotificationMain({
            text = "~h~Prise de ~g~service.",
            type = 'basGauche',
            nTimeNotif = 1000,
        })

		TriggerServerEvent("player:serviceOn", "police") --> On lui give le service pour recevoir les appel d'urgence.
		TriggerEvent("GTA_Police:AfficherBlipsPoint")  --> On ajoute les blips 
	end

    config.Service = not config.Service

	if config.Grade == "Cadet" then --Cadet
		if GetEntityModel(ped) == 1885233650 then
			SetPedComponentVariation(ped, 3, 30, 0, 0)--Gants
			SetPedComponentVariation(ped, 4, 35, 0, 0)--Jean
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 59, 0, 0) --Gilet Cadet
			SetPedComponentVariation(ped, 11, 55, 0, 0)--Veste
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 7, 0, 1)--Lunette
		elseif GetEntityModel(ped) == -1667301416 then
			SetPedComponentVariation(ped, 4, 34, 0, 0)--Pantalon
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 36, 0, 0) --Gilet Cadet
			SetPedComponentVariation(ped, 11, 48, 0, 0)--Veste
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 7, 0, 1)--Lunette
		end
	elseif config.Grade == "Sergent" then --Sergent
		if GetEntityModel(ped) == 1885233650 then
			SetPedComponentVariation(ped, 3, 30, 0, 0)--Gants
			SetPedComponentVariation(ped, 4, 35, 0, 0)--Jean
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 58, 0, 0)--mattraque
			SetPedComponentVariation(ped, 11, 55, 0, 0)--Veste
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 7, 0, 1)--Lunette
		elseif GetEntityModel(ped) == -1667301416 then
			SetPedComponentVariation(ped, 4, 34, 0, 0)--Pantalon
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 35, 0, 0)
			SetPedComponentVariation(ped, 11, 48, 0, 0)--Veste
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 7, 0, 1)--Lunette
        end
    elseif config.Grade == "SergentChef" then --SergentChef
        if GetEntityModel(ped) == 1885233650 then
			SetPedComponentVariation(ped, 3, 30, 0, 0)--Gants
			SetPedComponentVariation(ped, 4, 35, 0, 0)--Jean
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 58, 0, 0)--mattraque
			SetPedComponentVariation(ped, 11, 55, 0, 0)--Veste
			SetPedComponentVariation(ped, 10, 8, 2, 0)--Grade
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 7, 0, 1)--Lunette
		elseif GetEntityModel(ped) == -1667301416 then
			SetPedComponentVariation(ped, 4, 34, 0, 0)--Pantalon
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 35, 0, 0)
			SetPedComponentVariation(ped, 11, 48, 0, 0)--Veste
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 7, 0, 1)--Lunette
        end
    elseif config.Grade == "Lieutenant" then --Lieutenant
        if GetEntityModel(ped) == 1885233650 then
			SetPedComponentVariation(ped, 3, 30, 0, 0)--Gants
			SetPedComponentVariation(ped, 4, 35, 0, 0)--Jean
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 58, 0, 0)--mattraque
			SetPedComponentVariation(ped, 11, 55, 0, 0)--Veste
			SetPedComponentVariation(ped, 10, 8, 2, 0)--Grade
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 7, 0, 1)--Lunette
		elseif GetEntityModel(ped) == -1667301416 then
			SetPedComponentVariation(ped, 4, 34, 0, 0)--Pantalon
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 35, 0, 0)
			SetPedComponentVariation(ped, 11, 48, 0, 0)--Veste
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 7, 0, 1)--Lunette
        end
    elseif config.Grade == "Capitaine" then --Capitaine
        if GetEntityModel(ped) == 1885233650 then
			SetPedComponentVariation(ped, 3, 30, 0, 0)--Gants
			SetPedComponentVariation(ped, 4, 35, 0, 0)--Jean
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 58, 0, 0)--mattraque
			SetPedComponentVariation(ped, 11, 55, 0, 0)--Veste
			SetPedComponentVariation(ped, 10, 8, 3, 0)--Grade
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 18, 2, 1)--Lunette
		elseif GetEntityModel(ped) == -1667301416 then
			SetPedComponentVariation(ped, 4, 34, 0, 0)--Pantalon
			SetPedComponentVariation(ped, 6, 24, 0, 0)--Chaussure
			SetPedComponentVariation(ped, 8, 35, 0, 0)
			SetPedComponentVariation(ped, 11, 48, 0, 0)--Veste
			SetPedPropIndex(ped, 2, 2, 0, 1)--Oreillete
			SetPedPropIndex(ped, 6, 3, 0, 1)--Montre
			SetPedPropIndex(ped, 1, 7, 0, 1)--Lunette
        end
	end
end)

RegisterNetEvent("GTA_Police:RecevoirArmes")
AddEventHandler("GTA_Police:RecevoirArmes", function(item, qty)
    qty = qty or 1
    TriggerEvent("player:receiveItem", item, qty)
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    for i=1, #Config.Locations do
        local myPeds = Config.Locations[i]["myPedsLocation"]
        exports.nCoreGTA:Ninja_Core_StartAnim(myPeds["entity"], "anim@mp_player_intupperthumbs_up", "enter")
        exports.nCoreGTA:Ninja_Core_PedsText("~r~Armurerie Police ~w~ ~h~: Et voila chef !", 1000)
    end
end)

RegisterNetEvent("GTA_Police:SortirPoliceVeh")
AddEventHandler("GTA_Police:SortirPoliceVeh", function(pVeh)
    local pVeh = GetHashKey(pVeh)

    RequestModel(pVeh)
    while not HasModelLoaded(pVeh) do
        RequestModel(pVeh)
        Citizen.Wait(0)
    end
    local veh = CreateVehicle(pVeh, 463.499, -1019.33, 28.1039, 90.89, true, false)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleNumberPlateText(veh, "LSPD911")
    for i=1, #Config.Locations do
        local myPeds = Config.Locations[i]["myPedsLocation"]
        exports.nCoreGTA:Ninja_Core_StartAnim(myPeds["entity"], "gestures@f@standing@casual", "gesture_hello")
        exports.nCoreGTA:Ninja_Core_PedsText("~b~Garage Police ~w~: ~h~Votre véhicule de patrouille vous attend au garage !", 3000)
    end
end)


RegisterNetEvent("GTA_Police:RentrerPoliceVeh")
AddEventHandler("GTA_Police:RentrerPoliceVeh", function(entity)
    SetEntityAsMissionEntity(entity,true,true)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end)


---> Thread :
--------------> POLICE REQUETE : 
Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(Duree)
        target, distance = GetClosestPlayer()
        
        if requestAmende then
            DrawRect(0.912000000000001, 0.292, 0.185, 0.205, 0, 0, 0, 150)
			DrawAdvancedText(0.966000000000001, 0.220, 0.005, 0.0028, 0.7, "Amende ~b~Police", 255, 255, 255, 255, 1, 1)
			DrawAdvancedText(0.924000000000001, 0.278, 0.005, 0.0028, 0.4, "Montant ~g~"..amendeMontant .. "$", 255, 255, 255, 255, 6, 1)
			DrawAdvancedText(0.924000000000001, 0.322, 0.005, 0.0028, 0.4, raisonAmende, 255, 255, 255, 255, 6, 1)
        end
        
		------> Identiter : 
		if IsControlJustPressed(1, 246) and requestIdentiter then --Y
			if(distance ~= -1 and distance < 3) then
				requestIdentiter = false
				TriggerServerEvent("GTA:MontrerSonIdentiter", GetPlayerServerId(target))
			else
                exports.nCoreGTA:nNotificationMain({
                    text = "~r~Aucune personne proche de vous.",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
            end
		Duree = 1000
		elseif IsControlJustPressed(1, 182) and requestIdentiter then --L
			if(distance ~= -1 and distance < 3) then
				TriggerServerEvent("GTA_Requete:NotifRefuser", GetPlayerServerId(target))
			else
                exports.nCoreGTA:nNotificationMain({
                    text = "~r~Aucune personne proche de vous.",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
			end
            requestIdentiter = false
		    Duree = 1000
		end
		------> Inventaire : 
		if IsControlJustPressed(1, 246) and requestInventaire then --Y
			if(distance ~= -1 and distance < 3) then
				requestInventaire = false
				TriggerServerEvent("GTA_Police:OpenTargetInventaire", GetPlayerServerId(target))
            else
                exports.nCoreGTA:nNotificationMain({
                    text = "~r~Aucune personne proche de vous.",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
            end
            Duree = 1000
		elseif IsControlJustPressed(1, 182) and requestInventaire then --L
			if(distance ~= -1 and distance < 3) then
				TriggerServerEvent("GTA_Requete:NotifRefuser", GetPlayerServerId(target))
			else
                exports.nCoreGTA:nNotificationMain({
                    text = "~r~Aucune personne proche de vous.",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
			end
            requestInventaire = false
            Duree = 1000
		end

		------> Amende : 
		if IsControlJustPressed(1, 246) and requestAmende then --Y
			if(distance ~= -1 and distance < 3) then
				requestAmende = false
				TriggerServerEvent("GTA_Police:AmendeAutoriser", GetPlayerServerId(target), tonumber(amendeMontant))
			else
                exports.nCoreGTA:nNotificationMain({
                    text = "~r~Aucune personne proche de vous.",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
            end
            Duree = 1000
        elseif IsControlJustPressed(1, 182) and requestAmende then --L
            if(distance ~= -1 and distance < 3) then
				TriggerServerEvent("GTA_Requete:NotifRefuser", GetPlayerServerId(target))
			else
                exports.nCoreGTA:nNotificationMain({
                    text = "~r~Aucune personne proche de vous.",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
			end
            requestAmende = false
            Duree = 1000
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if not changed then
            ped = PlayerPedId()
            local IsCuffed = IsPedCuffed(ped) 
            if IsCuffed and not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) then
                Citizen.Wait(500)
                TaskPlayAnim(ped, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
            end
        else
            changed = false
        end
    end
end)

Citizen.CreateThread(function()
    for i = 1, 12 do
        Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if cuffed then
            DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
            DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
            DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
            DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
            DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
            DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
            DisableControlAction(0, 257, true) -- INPUT_ATTACK2
            DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
            DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
            DisableControlAction(0, 24, true) -- INPUT_ATTACK
            DisableControlAction(0, 25, true) -- INPUT_AIM
            DisableControlAction(0, 23, true)
            DisableControlAction(0, 75,  true) -- Leave Vehicle
        end
    end
end)