-- Check if player is near another player
playerInfo = {
	sex = "",
	nom = "",
	prenom = "",
	age = "",
	origine = "",
	argentPropre = 0,
	argentSale = 0,
	metiers = {}
}

function LocalPed()
	return GetPlayerPed(-1)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result --Returns the result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function IsNearPlayer(player)
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
    local ply2Coords = GetEntityCoords(ply2, 0)
    local distance = GetDistanceBetweenCoords(ply2Coords["x"], ply2Coords["y"], ply2Coords["z"],  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 5) then
        return true
    end
end


function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if distance < 5 then
				if(closestDistance == -1 or closestDistance > distance) then
					closestPlayer = value
					closestDistance = distance
				end
			end
		end
	end

	return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		players[#players + 1] = player
	end
    return players
end

function playAnim(dict, name)
    local ped = GetPlayerPed(-1)
    loadanimdict(dict)
    TaskPlayAnim(ped, dict, name, 8.0, 1.0, -1, 2, 0, 0, 0, 0)
end

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

Ninja_Core__DisplayHelpAlert = function(msg)
	BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(msg);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end

function SimpleNotify(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

RegisterNetEvent("GTA:GetSexJoueur")
AddEventHandler("GTA:GetSexJoueur", function(sex)
	playerInfo.sex = sex
end)

RegisterNetEvent("GTA:MettreHautJoueur")
AddEventHandler("GTA:MettreHautJoueur", function(args)
	SetPedComponentVariation(LocalPed(-1), args[1], args[2], args[3], 0) --> TopsID
	SetPedComponentVariation(LocalPed(-1), args[4], args[5], args[6], 0) --> Undershirt
	SetPedComponentVariation(LocalPed(-1), args[7], args[8], 0, 0) --> Torsos
end)

RegisterNetEvent("GTA:MettreBasJoueur")
AddEventHandler("GTA:MettreBasJoueur", function(args)
	SetPedComponentVariation(LocalPed(-1), args[1], args[2], args[3], 0) --> Legs
end)

RegisterNetEvent("GTA:MettreChaussureJoueur")
AddEventHandler("GTA:MettreChaussureJoueur", function(args)
	SetPedComponentVariation(LocalPed(-1), args[1], args[2], args[3], 0) --> Shoes
end)

RegisterNetEvent("GTA:MettreBonnetJoueur")
AddEventHandler("GTA:MettreBonnetJoueur", function(args)
	SetPedPropIndex(LocalPed(), args[1], args[2], args[3], 0) --> Hats
end)

RegisterNetEvent("GTA:RetirerHautJoueur")
AddEventHandler("GTA:RetirerHautJoueur", function()
	if playerInfo.sex == "mp_m_freemode_01" then
		SetPedComponentVariation(LocalPed(), 11, 15, 0, 0)
		SetPedComponentVariation(LocalPed(), 8, 15, 0, 0)
		SetPedComponentVariation(LocalPed(), 3, 15, 0, 0)
	else
		SetPedComponentVariation(LocalPed(), 11, 15, 0, 0)
		SetPedComponentVariation(LocalPed(), 8, 2, 0, 0)
		SetPedComponentVariation(LocalPed(), 3, 15, 0, 0)
	end
end)


RegisterNetEvent("GTA:RetirerBasJoueur")
AddEventHandler("GTA:RetirerBasJoueur", function()
	if playerInfo.sex == "mp_m_freemode_01" then
		SetPedComponentVariation(LocalPed(), 4, 14, 0, 0)
	else
		SetPedComponentVariation(LocalPed(), 4, 17, 0, 0)
	end
end)

RegisterNetEvent("GTA:RetirerChaussureJoueur")
AddEventHandler("GTA:RetirerChaussureJoueur", function()
	if playerInfo.sex == "mp_m_freemode_01" then
		SetPedComponentVariation(LocalPed(), 6, 34, 0, 0)
	else
		SetPedComponentVariation(LocalPed(), 6, 35, 0, 0)
	end
end)

RegisterNetEvent("GTA:RetirerBonnetJoueur")
AddEventHandler("GTA:RetirerBonnetJoueur", function()
	if playerInfo.sex == "mp_m_freemode_01" then
		SetPedPropIndex(LocalPed(), 0, 8, 0, 0)
	else
		SetPedPropIndex(LocalPed(), 0, 57, 0, 0)
	end
end)