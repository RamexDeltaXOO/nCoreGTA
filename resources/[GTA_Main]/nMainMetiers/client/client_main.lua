--> Function : 
Ninja_Core__DisplayHelpAlert = function(msg)
	BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(msg);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end

_RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end

DeleteCashier = function()
    for i=1, #Config.Locations do
        local sPed = Config.Locations[i]["sPed"]
        if DoesEntityExist(sPed["entity"]) then
            DeletePed(sPed["entity"])
            SetPedAsNoLongerNeeded(sPed["entity"])
        end
    end
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

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end
 
 function LocalPed()
     return GetPlayerPed(-1)
 end

Citizen.CreateThread(function()
    local defaultHash = 416176080
    for i=1, #Config.Locations do
        local sPed = Config.Locations[i]["sPed"]
        if sPed then
            sPed["hash"] = sPed["hash"] or defaultHash
            _RequestModel(sPed["hash"])
            if not DoesEntityExist(sPed["entity"]) then
                sPed["entity"] = CreatePed(4, sPed["hash"], sPed["x"], sPed["y"], sPed["z"], sPed["h"])
                SetEntityAsMissionEntity(sPed["entity"])
                SetBlockingOfNonTemporaryEvents(sPed["entity"], true)
                FreezeEntityPosition(sPed["entity"], true)
                SetEntityInvincible(sPed["entity"], true)
            end
            SetModelAsNoLongerNeeded(sPed["hash"])
        end
    end
end)


Citizen.CreateThread(function()
    for shop = 1, #Config.Locations do
        local blip = Config.Locations[shop]["sPed"]
        blip = AddBlipForCoord(blip["x"], blip["y"], blip["z"])

        SetBlipSprite(blip, 408)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 57)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Emplois")
        EndTextCommandSetBlipName(blip)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeleteCashier()
    end
end)