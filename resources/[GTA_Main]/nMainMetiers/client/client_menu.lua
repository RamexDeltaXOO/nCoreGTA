mainMenu = RageUI.CreateMenu("Emplois",  "Voici la liste des jobs disponible.")
local Duree = 0
local listEmploi = {}

local Ninja_Core__DisplayHelpAlert = function(msg)
	BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(msg);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end

RegisterNetEvent("GTA:ListEmploi")
AddEventHandler("GTA:ListEmploi", function(jobsDispo)
	for k in pairs(listEmploi) do
		listEmploi[k] = nil
	end

	for _, v in pairs(jobsDispo) do
		table.insert(listEmploi, v.jobName)
	end
end)

Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(mainMenu, function()
            for _, v in pairs(listEmploi) do
                RageUI.Button(v, "", {}, true, {onSelected = function()
                    TriggerServerEvent("GTA:UpdateJob", v)
                    TriggerServerEvent("GTA:LoadJobsJoueur")
                    exports.nCoreGTA:ShowNotification("Vous voici avec votre nouveau job ~b~"..v)
                    RageUI.CloseAll(true)
                end});
            end
        end, function()end)
    Citizen.Wait(Duree)
    end
end)

Citizen.CreateThread(function()
    while true do
        Duree = 250
        for i = 1, #Config.Locations do
           local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
           local dist = GetDistanceBetweenCoords(plyCoords, Config.Locations[i]["x"], Config.Locations[i]["y"], Config.Locations[i]["z"], true)
            if dist <= 5.0 then
                Duree = 0
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_PICKUP~ pour ~b~intéragir")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~b~intéragir")
                end
           
               if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then 
                    TriggerServerEvent("GTA:GetJobsList")
                    Wait(150)
                    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
               end
            end
        end

        if RageUI.Visible(mainMenu) == true then 
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
            DisableControlAction(0, 172, true) --DESACTIVE CONTROLL HAUT  
        end
       Citizen.Wait(Duree)
   end
end)


Citizen.CreateThread(function()
    for i = 1, #Config.Locations do
        blip = AddBlipForCoord(Config.Locations[i]["x"], Config.Locations[i]["y"], Config.Locations[i]["z"])

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