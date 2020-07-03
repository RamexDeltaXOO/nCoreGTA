--> Event :
ITEMS = {}

RegisterNetEvent("GTA:LoadClientJob")
AddEventHandler("GTA:LoadClientJob", function(newJobName, newService, newGrade)
	config.Grade = newGrade or "Aucun"
	config.Job = newJobName
	config.Service = newService
end)

RegisterNetEvent("gui:getItemsTarget")
AddEventHandler("gui:getItemsTarget", function(THEITEMS)
    ITEMS = {}
	ITEMS = THEITEMS
end)

local square = math.sqrt
function getDistance(a, b) 
    local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
    return square(x*x+y*y+z*z)
end

Ninja_Core__DisplayHelpAlert = function(msg)
	BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(msg);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end

function round(n)
	return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

function InputText()
	local text = ""
	AddTextEntry('textRaison', "Raison : ")
    DisplayOnscreenKeyboard(1, "textRaison", "", "", "", "", "", 120)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(10)
    end
    if (GetOnscreenKeyboardResult()) then
        text = GetOnscreenKeyboardResult()
    end
    return text
end

function InputNombre(reason)
	local text = ""
	AddTextEntry('nombre', reason)
    DisplayOnscreenKeyboard(1, "nombre", "", "", "", "", "", 4)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(10)
    end
    if (GetOnscreenKeyboardResult()) then
        text = GetOnscreenKeyboardResult()
    end
    return text
end

function DrawMissionText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function LocalPed()
    return GetPlayerPed(-1)
end

function GetLocalPed()
    return GetPlayerPed(PlayerId())
end

function deleteCar( entity ) --> Function qui permet de supprimer votre véhicule de service.
	SetEntityAsMissionEntity(entity,true,true)
	Citizen.InvokeNative( 0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized( entity ) )
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for _,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = getDistance(targetCoords, plyCoords, true)
			if distance < 2 then
				if(closestDistance == -1 or closestDistance > distance) then
					closestPlayer = value
					closestDistance = distance
				end
			end
		end
	end
	return closestPlayer, closestDistance
end

function afficherMarkerTarget()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for _,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = getDistance(targetCoords, plyCoords, true)
			if distance < 2 then
				if(closestDistance == -1 or closestDistance > distance) then
					closestPlayer = value
					closestDistance = distance
					DrawMarker(25, targetCoords["x"], targetCoords["y"], targetCoords["z"] - 0.9 - 0.009, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 54, 54, 54, 200, 0, 0, 0, 0)
				end
			end
		end
	end
end

function DrawAdvancedText2(x,y ,w,h,sc, text, r,g,b,a,font,jus, timer)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

function GetPlayers()
    local players = {}
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		players[#players + 1] = player
	end
    return players
end

-- Get le véhicule le plus proche :
function GetVehicleNearOfMe()
    local lPed = GetLocalPed()
    local lPedCoords = GetEntityCoords(lPed, alive)
    local lPedOffset = GetOffsetFromEntityInWorldCoords(lPed, 0.0, 3.0, 0.0)
    local rayHandle = StartShapeTestCapsule(lPedCoords.x, lPedCoords.y, lPedCoords.z, lPedOffset.x, lPedOffset.y, lPedOffset.z, 1.2, 10, lPed, 7)
    local returnValue, hit, endcoords, surface, vehicle = GetShapeTestResult(rayHandle)

    if hit then
        return vehicle
    else
        return false
    end
end



-- Get les portes les plus proches :
function GetClosestVehicleDoor(vehicle)
    local plyCoords = GetEntityCoords(GetLocalPed(), false)
	local backleft = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_dside_r"))
	local backright = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_pside_r"))
	local bldistance = getDistance(backleft, plyCoords, 1)
    local brdistance = getDistance(backright, plyCoords, 1)

    local found_door = false

    if (bldistance < brdistance) then
        found_door = 1
    elseif(brdistance < bldistance) then
        found_door = 2
    end
    return found_door
end

AddEventHandler('onClientResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
		return
	end

	TriggerServerEvent("GTA:LoadJobsJoueur") --> Charge votre job, service, grade.
end)

local blips = {
	{title="Police LSPD", colour=29, id=60, x=450.174, y=-992.276, z=30.6896},
	{title="Hôpital", colour=74, id=61, x=1150.839, y=-1530.355, z=34.38629},
}
  
Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.9)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)


