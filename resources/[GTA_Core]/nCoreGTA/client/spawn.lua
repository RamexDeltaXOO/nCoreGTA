--@Super.Cool.Ninja
local firstTick = false
local firstspawn = 0
local cam = nil
local cam2 = nil
local isPlayerSpawn = false

RegisterNetEvent("GTA:LASTPOS")
AddEventHandler("GTA:LASTPOS", function(PosX, PosY, PosZ)
	--Definit la position du joueur : 
	SetEntityCoords(GetPlayerPed(-1), tonumber(PosX), tonumber(PosY), tonumber(PosZ) + 0.0, 1, 0, 0, 1)
	NetworkResurrectLocalPlayer(tonumber(PosX), tonumber(PosY), tonumber(PosZ) + 0.0, 0, true, true, false)
	SetTimecycleModifier('default')
end)

RegisterNetEvent("GTA:NewPlayerPosition")
AddEventHandler("GTA:NewPlayerPosition", function(PosX, PosY, PosZ)
	--> On charge les donné du player : 
	exports.rprogress:Custom({
		Label = "Chargement de votre position",
		Duration = 1000,
		LabelPosition = "right",
		Color = "rgba(255, 255, 255, 0.5)",
		BGColor = "rgba(0, 0, 0, 0.8)"
	})
	
	Citizen.Wait(1000)
	
	--Definit la position du joueur : 
	SetEntityCoords(GetPlayerPed(-1), tonumber(PosX), tonumber(PosY), tonumber(PosZ) + 0.0, 1, 0, 0, 1)
	NetworkResurrectLocalPlayer(tonumber(PosX), tonumber(PosY), tonumber(PosZ) + 0.0, 0, true, true, false)
	SetTimecycleModifier('default')

	--> On ajoute une cam de départ : 
	cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
	PointCamAtCoord(cam2, PosX,PosY,PosZ+200)
	SetCamActiveWithInterp(cam2, cam, 900, true, true)
	
	Citizen.Wait(900)

	--> On ajoute une cam de fin avec une interpolation sur le joueur :
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PosX,PosY,PosZ+200, 300.00,0.00,0.00, 100.00, false, 0)
	PointCamAtCoord(cam, PosX,PosY,PosZ+2)
	SetCamActiveWithInterp(cam, cam2, 3700, true, true)
	
	Citizen.Wait(3700)
	

	PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
	RenderScriptCams(false, true, 500, true, true)
	PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)

	--> On charge les donné du player : 
	exports.rprogress:Custom({
		Label = "Chargement de votre personnage",
		Duration = 1700,
		LabelPosition = "right",
		Color = "rgba(255, 255, 255, 0.5)",
		BGColor = "rgba(0, 0, 0, 0.8)"
	})

	TriggerServerEvent("GTA_Notif:OnPlayerJoin")
	TriggerServerEvent("GTA:CreationPersonnage")
	TriggerServerEvent('GTA:LoadArgent')
	TriggerEvent("GTA:LoadWeaponPlayer")
	Citizen.Wait(1700)

	--> on detruit la cam puis rend controlable notre player :
	SetCamActive(cam, false)
	DestroyCam(cam, true)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityVisible(PlayerPedId(), true, 0)
	DisplayRadar(true)
	DisplayHud(true)
	TriggerEvent('EnableDisableHUDFS', true)
end)

--> Executer une Une fois la ressource start : 
AddEventHandler('onClientResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
	  return
	end
  
	Citizen.CreateThread(function()
		if not firstTick then		
			while not NetworkIsGameInProgress() and IsPlayerPlaying(PlayerId()) do
				Wait(800)
			end
			
			TriggerEvent('EnableDisableHUDFS', false)

			DisplayHud(false)
			DisplayRadar(false)
	
			SetTimecycleModifier('hud_def_blur')
			FreezeEntityPosition(GetPlayerPed(-1), true)
			cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
			SetCamActive(cam, true)
			RenderScriptCams(true, false, 1, true, true)
	
			if not IsPlayerSwitchInProgress() then
				SetEntityVisible(PlayerPedId(), false, 0)
				TriggerServerEvent('GTA:LoadArgent')
			end
		end
	end)
end)

--> Executer une fois la ressource restart : 
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
	end
	
	isPlayerSpawn = false
    PlaySoundFrontend(-1, "Whistle", "DLC_TG_Running_Back_Sounds", 0)
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(config.savePosTime)
		if isPlayerSpawn == true then 
			LastPosX, LastPosY, LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			TriggerServerEvent("GTA:SAVEPOS", LastPosX , LastPosY , LastPosZ)
			exports.nCoreGTA:ShowNotification("✅ ~g~Position synchronisée")
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if isPlayerSpawn == false then 
			PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
			TriggerServerEvent("GTA:SPAWNPLAYER")
			firstTick = true
			exports.spawnmanager:setAutoSpawn(false)
			isPlayerSpawn = true
			break
		end
	end
end)

AddEventHandler('playerSpawned', function()
	TriggerServerEvent("GTA:SetPositionPlayer")
end)