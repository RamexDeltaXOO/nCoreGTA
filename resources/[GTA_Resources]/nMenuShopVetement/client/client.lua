Sex = ""

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

function stringstarts(String,Start)
	return string.sub(String,1,string.len(Start))==Start
 end
 
 
 function table.HasValue( t, val )
	 for k, v in pairs( t ) do
		 if ( v == val ) then return true end
	 end
	 return false
 end

RegisterNetEvent("GTA:GetSexPlayer")
AddEventHandler("GTA:GetSexPlayer", function() 
	if IsPedModel(LocalPed(), "mp_m_freemode_01") then
		Sex = "mp_m_freemode_01"
	else
		Sex = "mp_f_freemode_01"
	end
end)


local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		TriggerEvent("GTA:GetSexPlayer")
		TriggerEvent("GTA:ShowVetementBlips",true)
        firstspawn = 1
    end
end)