local EarlyRespawnTimer = 60000 * 1 --> 60 SECONDES
local BleedoutTimer = 60000 * 10
local UI = { 
	x =  0.000,
	y = -0.001,
}
local IsPedDead = false
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local posTenuePlayer = {x = 342.803,y = -1397.99,z = 32.5092}

local square = math.sqrt
local function getDistance(a, b) 
  local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
  return square(x*x+y*y+z*z)
end

local function Ninja_Core__DisplayHelpAlert(msg)
	BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(msg);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = GetPlayerPed(-1)
		local posPed = GetEntityCoords(playerPed)
		local distance = getDistance(posPed, posTenuePlayer)

		if distance < 25 then
			DrawMarker(0, posTenuePlayer.x, posTenuePlayer.y, posTenuePlayer.z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 255, 0, 255)

			if distance < 2 then
				if GetLastInputMethod(0) then
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ~b~récuperer votre tenue")
				else
					Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour ~b~récuperer votre tenue")
				end

				if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
					TriggerServerEvent("GTA:LoadVetement")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		if IsEntityDead(playerPed) and not IsPedDead then
			IsPedDead = true
			_nBeginDeadTimer()
			_nSendSignal()
		elseif not IsEntityDead(playerPed) then
			IsPedDead = false
		end
	end
end)

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

HideHUDThisFrame = function()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(17)
	HideHudComponentThisFrame(20)
end

DrawGenericTextThisFrame = function()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

secondsToClock = function(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

__RoundNumber = function(value, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

__nSaveNewPosition = function()
	LastPosX, LastPosY, LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	local LastPosH = GetEntityHeading(GetPlayerPed(-1))
	TriggerServerEvent("GTA:SAVEPOS", LastPosX , LastPosY , LastPosZ, LastPosH)
end

_nSendSignal = function()
	Citizen.CreateThread(function()
		local timer = BleedoutTimer

		while timer > 0 and IsPedDead do
			Citizen.Wait(2)
			timer = timer - 30

			SetTextFont(4)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			if config.utilisationJobMedic == true then
				if GetLastInputMethod(0) then
					AddTextComponentSubstringPlayerName("~b~ G ~w~ ~h~ pour envoyer un signal de détresse.")
				else
					AddTextComponentSubstringPlayerName("~b~ GAUCHE ~w~ ~h~ pour envoyer un signal de détresse")
				end
				EndTextCommandDisplayText(0.175, 0.805)
			
				if IsControlPressed(0, Keys['G']) then
					__nSaveNewPosition()
					local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
					TriggerServerEvent("call:makeCall", "medic", {x=plyPos.x,y=plyPos.y,z=plyPos.z}, "~h~[URGENCE] Une personne à été signalé au sol, inconscient !")

					Citizen.CreateThread(function()
						Citizen.Wait(1000 * 60 * 5)
						if IsPedDead then
							_nSendSignal()
						end
					end)
					break
				end
			end
		end
	end)
end

_nStartEffect = function()
	local playerPed = PlayerPedId()
	DoScreenFadeOut(500)
	TriggerServerEvent("item:reset")
	NetworkResurrectLocalPlayer(339.089, -1396.08, 32.5092, 0.0, true, false) --> nouvel coord aprés le respawn.
	ClearPedBloodDamage(playerPed)
	ClearPedWetness(playerPed)

	--> Tenue une fois spawn a l'hosto :
	if GetEntityModel(playerPed) == 1885233650 then --GOOD
		SetPedComponentVariation(GetPlayerPed(-1), 11,114,0,0)
		SetPedComponentVariation(GetPlayerPed(-1), 4,56,0,1)
		SetPedComponentVariation(GetPlayerPed(-1), 3,14,0,1)
		SetPedComponentVariation(GetPlayerPed(-1), 6,34,0,1)
		SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 1, 0)
	elseif GetEntityModel(playerPed) == -1667301416 then
		SetPedComponentVariation(GetPlayerPed(-1), 11,105,0,0)
		SetPedComponentVariation(GetPlayerPed(-1), 4,57,0,1)
		SetPedComponentVariation(GetPlayerPed(-1), 3,0,0,1)
		SetPedComponentVariation(GetPlayerPed(-1), 6,35,0,1)
		SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)
	end
	
	SetTimecycleModifier("Drunk")
	SetPedMotionBlur(playerPed, true)
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
	Citizen.Wait(0)
	end
	SetPedMovementClipset(playerPed, "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(playerPed, true)	 
	Citizen.Wait(1000)	
	DoScreenFadeIn(5000)
	
	Citizen.Wait(35000) --> Time Effect
	
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)			
	ClearTimecycleModifier()
	ResetPedMovementClipset(playerPed, 0)
	SetPedIsDrunk(playerPed, false)
	SetPedMotionBlur(playerPed, false)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	TriggerEvent("nResetStatsFood")
end

_nBeginDeadTimer = function()
	local earlySpawnTimer = __RoundNumber(EarlyRespawnTimer / 1000)
	local bleedoutTimer = __RoundNumber(BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		while earlySpawnTimer > 0 and IsPedDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		while bleedoutTimer > 0 and IsPedDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		while earlySpawnTimer > 0 and IsPedDead do --> temps que le temps de spawn est sup a 0 et que le player est dead on affiche le timer.
			Citizen.Wait(0)
			drawRct(UI.x + 0.0,UI.y + 0.0, 1.0,1.0,0,0,0,255) -- Top Bar
			drawRct(UI.x + 5.0,UI.y + 0.85, 1.0,0.50,0,0,0,255) -- Bottom Bar
			maxvalue = 0.001
			width = 0.2
			height = 0.025
			xvalue = 0.38
			yvalue = 0.05
			outlinecolour = {0, 0, 0, 150}
			barcolour = {0, 0, 0}
			DrawRect(xvalue + (width/2), yvalue, width + 0.004, height + 0.006705, outlinecolour[1], outlinecolour[2], outlinecolour[3], outlinecolour[4]) -- Box that creates outline
			drawHelpTxt(xvalue + (((maxvalue/2)/((maxvalue/2)/width))/2), yvalue , 0.15, 0.05, 0.5, "~r~réapparition ~w~possible dans ~g~"..tonumber(__RoundNumber(earlySpawnTimer)).." ~w~secondes ~w~.", 255, 255, 255, 255, 6) -- Text display of timer
			DrawRect(xvalue + (width/2), yvalue, width, height, barcolour[1], barcolour[2], barcolour[3], 255) --  Static full bar
			DrawRect(xvalue + ((maxvalue/width)/2), yvalue, (maxvalue/width), height, barcolour[1], barcolour[2], barcolour[3], 255)
			_nDrawComa()
			HideHUDThisFrame()
		end

		while bleedoutTimer > 0 and IsPedDead do
			Citizen.Wait(0)
	
			_nDrawRea()

			if IsControlPressed(0, Keys['E']) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
				_nStartEffect()
				break
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		if bleedoutTimer < 1 and isDead then
			_nStartEffect()
		end
	end)
end