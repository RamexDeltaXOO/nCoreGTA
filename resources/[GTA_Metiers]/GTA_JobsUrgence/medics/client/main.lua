--> Variable : 
local ped = PlayerPedId()
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local requestFacture = false
local factureMontant = 0
local raisonFacture = ""
local Duree = 1000

RegisterNetEvent("GTA_Medic:RequeteFactureTarget")
AddEventHandler("GTA_Medic:RequeteFactureTarget", function(montant, raison)
	requestFacture = true
    factureMontant = montant
    raisonFacture = raison
    PlaySound(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
    exports.nCoreGTA:nNotificationMain({
        text = "~y~ Y ~w~pour ~g~payer~w~ votre facture ~r~L ~w~ pour ~r~refuser",
        type = 'milieuGauche',
        nTimeNotif = 15000,
    })
    Duree = 0
end)


--Check si il est Policier, on affiche les blips :
RegisterNetEvent("GTA_Medic:AfficherBlipsPoint")
AddEventHandler('GTA_Medic:AfficherBlipsPoint', function ()
    --Sortie des veh :
    PoliceSortieVeh = AddBlipForCoord(1157.5, -1597.98, 34.69)
    SetBlipSprite(PoliceSortieVeh,225)		
    SetBlipColour(PoliceSortieVeh, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('SORTIE VEHICULE') 
	EndTextCommandSetBlipName(PoliceSortieVeh)
	
	--Rentrer veh :
	PoliceDeleteVeh = AddBlipForCoord(1141.03, -1602.0, 34.69)
	SetBlipSprite(PoliceDeleteVeh,225)		
	SetBlipColour(PoliceDeleteVeh, 69)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('RANGER VEHICULE')
	EndTextCommandSetBlipName(PoliceDeleteVeh)
end)

RegisterNetEvent("GTA_Medic:RetirerBlipsPoint")
AddEventHandler("GTA_Medic:RetirerBlipsPoint", function ()
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

RegisterNetEvent("GTA_Medic:onServiceMedic")
AddEventHandler("GTA_Medic:onServiceMedic", function()
    local ped = GetPlayerPed(-1)
    if config.Job ~= "Medic" then
        return
    end
	if config.Service then
		TriggerServerEvent("GTA:LoadVetement")
		
		exports.nCoreGTA:nNotificationMain({
            text = "~h~Fin de ~r~service.",
            type = 'basGauche',
            nTimeNotif = 1000,
        })

		TriggerServerEvent("player:serviceOff", "medic") --> On lui retire le service pour  ne plus recevoir les appel d'urgence.
		TriggerEvent("GTA_Medic:RetirerBlipsPoint") --> On retire les blips 
	else
        exports.nCoreGTA:nNotificationMain({
            text = "~h~Prise de ~g~service.",
            type = 'basGauche',
            nTimeNotif = 1000,
		})
	
		TriggerServerEvent("player:serviceOn", "medic") --> On lui give le service pour recevoir les appel d'urgence.
		TriggerEvent("GTA_Medic:AfficherBlipsPoint")  --> On ajoute les blips.
	end

    config.Service = not config.Service

	if config.Grade == "Stagiaire" then
		if GetEntityModel(ped) == 1885233650 then --> Homme
			SetPedComponentVariation(ped, 11, 13, 3, 2)
			SetPedComponentVariation(ped, 8, 15, 0, 2)
			SetPedComponentVariation(ped, 4, 9, 3, 2)
			SetPedComponentVariation(ped, 3, 92, 0, 2)
			SetPedComponentVariation(ped, 6, 25, 0, 2)
			SetPedComponentVariation(ped, 10, 57, 0, 2)
		elseif GetEntityModel(ped) == -1667301416 then --> Femme
			SetPedComponentVariation(ped, 11, 9, 2, 2)
			SetPedComponentVariation(ped, 8, 15, 0, 2)
			SetPedComponentVariation(ped, 4, 3, 3, 2)
			SetPedComponentVariation(ped, 3, 98, 0, 2)
			SetPedComponentVariation(ped, 6, 27, 0, 2)
			SetPedComponentVariation(ped, 10, 57, 0, 2)
		end
	elseif config.Grade == "Medecin" then
		if GetEntityModel(ped) == 1885233650 then --> Homme
			SetPedComponentVariation(ped, 11, 13, 3, 2)
			SetPedComponentVariation(ped, 8, 15, 0, 2)
			SetPedComponentVariation(ped, 4, 9, 3, 2)
			SetPedComponentVariation(ped, 3, 92, 0, 2)
			SetPedComponentVariation(ped, 6, 25, 0, 2)
			SetPedComponentVariation(ped, 10, 8, 1, 2)
		elseif GetEntityModel(ped) == -1667301416 then --> Femme
			SetPedComponentVariation(ped, 11, 9, 2, 2)
			SetPedComponentVariation(ped, 8, 15, 0, 2)
			SetPedComponentVariation(ped, 4, 3, 3, 2)
			SetPedComponentVariation(ped, 3, 98, 0, 2)
			SetPedComponentVariation(ped, 6, 27, 0, 2)
			SetPedComponentVariation(ped, 10, 7, 1, 2)
        end
	end
end)

RegisterNetEvent("GTA_Medic:RecevoirItemsMedical")
AddEventHandler("GTA_Medic:RecevoirItemsMedical", function(item)
    TriggerEvent("player:receiveItem", item, 1)
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
end)

RegisterNetEvent("GTA_Medic:SortirVeh")
AddEventHandler("GTA_Medic:SortirVeh", function(pVeh)
    local pVeh = GetHashKey(pVeh)

    RequestModel(pVeh)
    while not HasModelLoaded(pVeh) do
        RequestModel(pVeh)
        Citizen.Wait(0)
    end

    local veh = CreateVehicle(pVeh, 1149.96, -1611.23, 34.69, 281.25, true, false)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleNumberPlateText(veh, "URGENCE")
    for i=1, #Config.Locations do
        local myPeds = Config.Locations[i]["myPedsLocation"]
        exports.nCoreGTA:Ninja_Core_StartAnim(myPeds["entity"], "gestures@f@standing@casual", "gesture_hello")
        exports.nCoreGTA:Ninja_Core_PedsText("~b~Garage Medic ~w~: ~h~Votre véhicule de service vous attend au garage !", 3000)
    end
end)


RegisterNetEvent("GTA_Police:RentrerPoliceVeh")
AddEventHandler("GTA_Police:RentrerPoliceVeh", function(entity)
    SetEntityAsMissionEntity(entity,true,true)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end)


RegisterNetEvent("GTA_Medic:TargetSoigner")
AddEventHandler("GTA_Medic:TargetSoigner", function()
	local ped = GetPlayerPed(-1)
    SetEntityHealth(ped, 200)
	exports.nCoreGTA:nNotificationMain({
		text = "~g~Vous êtes soigner !",
		type = 'basGauche',
		nTimeNotif = 1000,
	})
end)

RegisterNetEvent('GTA_Medic:TargetReanimer')
AddEventHandler('GTA_Medic:TargetReanimer',function()
    local ped = GetPlayerPed(-1)
	exports.nCoreGTA:nNotificationMain({
		text = "~g~Vous voila de retour parmis nous !",
		type = 'basGauche',
		nTimeNotif = 1000,
	})
	local pos = GetEntityCoords(ped)
	local h = GetEntityHeading(ped)
	ResurrectPed(ped)
	SetEntityHealth(ped, 200)
	ClearPedTasksImmediately(ped)
	NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.0, h, true, true, false)
end)

---> Thread :
--------------> MEDIC REQUETE : 
Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(Duree)
        target, distance = GetClosestPlayer()
        
        if requestFacture then
            DrawRect(0.912000000000001, 0.292, 0.185, 0.205, 0, 0, 0, 150)
			DrawAdvancedText(0.966000000000001, 0.220, 0.005, 0.0028, 0.7, "Facture ~b~Medic", 255, 255, 255, 255, 1, 1)
			DrawAdvancedText(0.924000000000001, 0.278, 0.005, 0.0028, 0.4, "Montant ~g~"..factureMontant .. "$", 255, 255, 255, 255, 6, 1)
			DrawAdvancedText(0.924000000000001, 0.322, 0.005, 0.0028, 0.4, raisonFacture, 255, 255, 255, 255, 6, 1)
        end
        
		------> Amende : 
		if IsControlJustPressed(1, 246) and requestFacture then --Y
			if(distance ~= -1 and distance < 3) then
				requestFacture = false
				TriggerServerEvent("GTA_Medic:FactureAutoriser", GetPlayerServerId(target), tonumber(factureMontant))
			else
                exports.nCoreGTA:nNotificationMain({
                    text = "~r~Aucune personne proche de vous.",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
            end
            Duree = 1000
        elseif IsControlJustPressed(1, 182) and requestFacture then --L
            if(distance ~= -1 and distance < 3) then
				TriggerServerEvent("GTA_Requete:NotifRefuser", GetPlayerServerId(target))
			else
                exports.nCoreGTA:nNotificationMain({
                    text = "~r~Aucune personne proche de vous.",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
			end
            requestFacture = false
            Duree = 1000
        end
	end
end)

RequestIpl('Coroner_Int_on') --> Morgue