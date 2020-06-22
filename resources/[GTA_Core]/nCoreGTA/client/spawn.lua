--@Super.Cool.Ninja
local firstTick = false
local firstspawn = 0
IsPedDead = 0

local function showLoadingPromt(label, time)
    Citizen.CreateThread(function()
        BeginTextCommandBusyString(tostring(label))
        EndTextCommandBusyString(3)
        Citizen.Wait(time)
        RemoveLoadingPrompt()
    end)
end

function LocalPlayerPed()
	return PlayerPedId()
end

RegisterNetEvent("GTA:LASTPOS")
AddEventHandler("GTA:LASTPOS", function(PosX, PosY, PosZ)
	SetEntityCoords(GetPlayerPed(-1), tonumber(PosX), tonumber(PosY), tonumber(PosZ), 1, 0, 0, 1)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	SetEntityVisible(LocalPlayerPed(), false, 0)

	Wait(2500)
	
	FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityVisible(LocalPlayerPed(), true, 0)
	TriggerServerEvent("GTA_Notif:OnPlayerJoin") --> Notif qui affiche le nom du player vient de rejoindre/quitter la ville.
	PlaySoundFrontend(-1, "CAM_PAN_DARTS", "HUD_MINI_GAME_SOUNDSET", 1)
end)

Citizen.CreateThread(function()
	if not firstTick then		
		while not NetworkIsGameInProgress() and IsPlayerPlaying(PlayerId()) do
			Wait(800)
		end

		if not IsPlayerSwitchInProgress() then
			SetEntityVisible(PlayerPedId(), false, 0)
			SwitchOutPlayer(PlayerPedId(), 32, 1)
			Wait(3000)

			showLoadingPromt("PCARD_JOIN_GAME", 8000)
			Wait(1000)
			TriggerServerEvent('GTA:LoadArgent')
		end

		TriggerServerEvent("GTA:CreationPersonnage")
		TriggerServerEvent("GTA:SPAWNPLAYER")
		TriggerEvent("GTA:LoadWeaponPlayer")
		
		Wait(5000)

		SwitchInPlayer(PlayerPedId())
		SetEntityVisible(PlayerPedId(), true, 0)

		Wait(5000)		

		exports.spawnmanager:setAutoSpawn(false)
		
		Wait(2000)
		firstTick = true
	end
	local ipls = {'facelobby', 'farm', 'farmint', 'farm_lod', 'farm_props', 
	              'des_farmhouse', 'post_hiest_unload', 'v_tunnel_hole',
	              'rc12b_default', 'refit_unload', 'shr_int'}

	for k,v in pairs(ipls) do
		if not IsIplActive(v) then
			RequestIpl(v)
		end
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(config.savePosTime)
		LastPosX, LastPosY, LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		TriggerServerEvent("GTA:SAVEPOS", LastPosX , LastPosY , LastPosZ)
		exports.nCoreGTA:nNotificationMain({
			text = "✅ ~g~Position synchronisée",
			type = 'basGauche',
			nTimeNotif = 6000,
		})
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local ped = GetPlayerPed(-1)

		if IsControlJustPressed(0, 20) then
			ShowHudComponentThisFrame(3)
			ShowHudComponentThisFrame(4)
		end	

		if IsPedArmed(ped, 6) then --> Anti Coup de cross.
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
		end
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		TriggerServerEvent("GTA:SPAWNPLAYER")
		firstspawn = 1
	end
end)