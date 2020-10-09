Config.Sex = ""
indexii = {}

Ninja_Core__DisplayHelpAlert = function(msg)
	BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(msg);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end

--> No need native to check the distance with this :
square = math.sqrt
function getDistance(a, b) 
  local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
  return square(x*x+y*y+z*z)
end

function LocalPed()
	return GetPlayerPed(-1)
end

RegisterNetEvent("GTA:GetSexPlayer")
AddEventHandler("GTA:GetSexPlayer", function() 
	if IsPedModel(LocalPed(), "mp_m_freemode_01") then
		Config.Sex = "mp_m_freemode_01"
	else
		Config.Sex = "mp_f_freemode_01"
	end
end)

function getSexVetement()
	for i = 1, #Config.Locations do
		if IsPedModel(LocalPed(), "mp_m_freemode_01") then
			return Config.Locations[i]["Homme"]
		else
			return Config.Locations[i]["Femme"]
		end
	end
end

function IsNearOfZones()
    for i = 1, #Config.Locations do
		local tShirtPos = Config.Locations[i]["MagasinDeVetement"]["TShirtPos"]
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local distTShirt = getDistance(plyCoords, tShirtPos, true)

        if (distTShirt <= 2.0) then
            return true
        else
            return false 
        end
    end
end

function GetNearZone()
    for i = 1, #Config.Locations do
		local tShirtPos = Config.Locations[i]["MagasinDeVetement"]["TShirtPos"]
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local distTShirt = getDistance(plyCoords, tShirtPos, true)

        if (distTShirt <= 2.0) then
            return "TshirtMenu"
        else
            return nil 
        end
    end
end

getSexMenu = getSexVetement()

-- Get le nom des tenues : 
function GetLabelTenue()
	for k in pairs(getSexMenu["Tshirt"]) do
		print(k)
		table.insert(indexii, k)
	end
end


local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		TriggerEvent("GTA:GetSexPlayer")
		TriggerEvent("GTA:ShowVetementBlips",true)
		Wait(150)
	 	print(getSexVetement())
        firstspawn = 1
    end
end)


Citizen.CreateThread(function()
	GetLabelTenue()
end)