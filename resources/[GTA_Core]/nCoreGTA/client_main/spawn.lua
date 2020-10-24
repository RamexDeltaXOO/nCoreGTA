--@Super.Cool.Ninja
local firstTick = false
local isPlayerSpawn = false

function LocalPed()
	return GetPlayerPed(-1)
end

local function spawnPlayerLastPos(PosX, PosY)
	--Definit la position du joueur : 
	for height = 1, 1000 do
		SetPedCoordsKeepVehicle(LocalPed(), tonumber(PosX), tonumber(PosY), height + 0.0)

		local foundGround, zPos = GetGroundZFor_3dCoord(tonumber(PosX), tonumber(PosY), height + 0.0)

		if foundGround then
			SetPedCoordsKeepVehicle(LocalPed(), tonumber(PosX), tonumber(PosY), height + 0.0)
			break
		end
		Citizen.Wait(1)
	end
end


RegisterNetEvent("GTA:LASTPOS")
AddEventHandler("GTA:LASTPOS", function(PosX, PosY, PosZ)
	spawnPlayerLastPos(PosX,PosY) 
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
	

	spawnPlayerLastPos(PosX, PosY) 
	NetworkResurrectLocalPlayer(tonumber(PosX), tonumber(PosY), tonumber(PosZ) + 0.0, 0, true, true, false)

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

	TriggerServerEvent("GTA:CheckAdmin")
	TriggerServerEvent("GTA_Notif:OnPlayerJoin")
	TriggerServerEvent("GTA:CreationPersonnage")
	TriggerServerEvent('GTA:LoadArgent')
	TriggerEvent("GTA:LoadWeaponPlayer")
	Citizen.Wait(1700)

	--> Rend controlable notre player :
	FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityVisible(PlayerPedId(), true, 0)
	DisplayRadar(true)
	DisplayHud(true)
	TriggerEvent('EnableDisableHUDFS', true)
    TriggerServerEvent("GTA:CheckAdmin")
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