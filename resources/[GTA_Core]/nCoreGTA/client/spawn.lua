--@Super.Cool.Ninja
local firstTick = false
local firstspawn = 0
local cam = nil
local cam2 = nil
local isPlayerSpawn = false


local function showLoadingPromt(label, time)
    Citizen.CreateThread(function()
        BeginTextCommandBusyString(tostring(label))
        EndTextCommandBusyString(3)
        Citizen.Wait(time)
        RemoveLoadingPrompt()
    end)
end

function DrawMissionText(m_text, showtime)
    ClearPrints()
	SetTextScale(0.5, 0.5)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(m_text)
	DrawText(0.5, 0.9)
end

function LocalPlayerPed()
	return PlayerPedId()
end

RegisterNetEvent("GTA:LASTPOS")
AddEventHandler("GTA:LASTPOS", function(PosX, PosY, PosZ)
	SetEntityCoords(GetPlayerPed(-1), tonumber(PosX), tonumber(PosY), tonumber(PosZ) + 0.0, 1, 0, 0, 1)
	NetworkResurrectLocalPlayer(tonumber(PosX), tonumber(PosY), tonumber(PosZ) + 0.0, 0, true, true, false)
	SetTimecycleModifier('default')
	DoScreenFadeIn(500)
	Citizen.Wait(500)
	cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
	PointCamAtCoord(cam2, PosX,PosY,PosZ+200)
	SetCamActiveWithInterp(cam2, cam, 900, true, true)
	Citizen.Wait(900)

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PosX,PosY,PosZ+200, 300.00,0.00,0.00, 100.00, false, 0)
	PointCamAtCoord(cam, PosX,PosY,PosZ+2)
	SetCamActiveWithInterp(cam, cam2, 3700, true, true)
	Citizen.Wait(3700)
	PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
	RenderScriptCams(false, true, 500, true, true)
	PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityVisible(PlayerPedId(), true, 0)
	Citizen.Wait(500)
	SetCamActive(cam, false)
	DestroyCam(cam, true)
	DisplayHud(true)
	DisplayRadar(true)
	TriggerServerEvent("GTA_Notif:OnPlayerJoin") --> Notif qui affiche le nom du player vient de rejoindre/quitter la ville.
	TriggerServerEvent("GTA:CreationPersonnage")
	TriggerEvent("GTA:LoadWeaponPlayer")
	TriggerEvent('EnableDisableHUDFS', true)
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(config.savePosTime)
		if isPlayerSpawn == true then 
			LastPosX, LastPosY, LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			TriggerServerEvent("GTA:SAVEPOS", LastPosX , LastPosY , LastPosZ)
			exports.nCoreGTA:nNotificationMain({
				text = "✅ ~g~Position synchronisée",
				type = 'basGauche',
				nTimeNotif = 6000,
			})
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustPressed(0, 20) then
			ShowHudComponentThisFrame(3)
			ShowHudComponentThisFrame(4)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if isPlayerSpawn == false then 
			if GetLastInputMethod(0) then
				DrawMissionText("~h~APPUYER SUR~g~ ENTRER ~w~ POUR REJOINDRE LA VILLE.")
			else
				DrawMissionText("~h~APPUYER SUR~r~ A ~w~ POUR REJOINDRE LA VILLE.")
			end

			if IsControlJustPressed(0, 18) then
				TriggerServerEvent("GTA:SPAWNPLAYER")
				firstTick = true
				exports.spawnmanager:setAutoSpawn(false)
				isPlayerSpawn = true
				break
			end
		end
	end
end)

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

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
	end
	
	isPlayerSpawn = false
    PlaySoundFrontend(-1, "Whistle", "DLC_TG_Running_Back_Sounds", 0)
end)