-----------------------------------------------> Variable :
local isPlayerAdmin = false;
local godmode = false;
local qtyArgentPropre = 0;
local isEnablePosition = false

-----------------------------------------------> Function :
local function SaisitNombre(max)
    local text = ""
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TTTIP8", "", " ", "", "", "", max)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(10)
    end
    if (GetOnscreenKeyboardResult()) then
        text = GetOnscreenKeyboardResult()
    end
    return text
end

local function tptop()
	local waypoint = GetFirstBlipInfoId(8)
	if DoesBlipExist(waypoint) then
		local waypointCoords = GetBlipInfoIdCoord(waypoint)

		for height = 1, 1000 do
			SetPedCoordsKeepVehicle(LocalPed(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

			local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

			if foundGround then
				SetPedCoordsKeepVehicle(LocalPed(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
				break
			end
			Citizen.Wait(1)
        end
    else
        exports.nCoreGTA:nNotificationMain({
            text = "~r~Veuillez positionner un marker.",
            type = 'basGauche',
            nTimeNotif = 6000,
        })
    end
end

local function toggleGodmode()
    godmode = not godmode
    SetEntityInvincible(GetPlayerPed(-1), godmode)
    if (godmode == true) then
        exports.nCoreGTA:nNotificationMain({
		    text = "~g~ invincibilité activer.",
		    type = 'basGauche',
		    nTimeNotif = 6000,
	    })
    else
        exports.nCoreGTA:nNotificationMain({
            text = "~r~ invincibilité désactiver.",
            type = 'basGauche',
            nTimeNotif = 6000,
        })
    end
end


local function toggleNoClip()
    noclipActive = not noclipActive
    local playerPed = PlayerPedId()
    if(noclipActive == true)then
        SetEntityCollision(playerPed, false, false)
        SetEntityVisible(playerPed, 0, 0)
        exports.nCoreGTA:nNotificationMain({
            text = "~g~ noclip activer.",
            type = 'basGauche',
            nTimeNotif = 6000,
        })
    else
        exports.nCoreGTA:nNotificationMain({
            text = "~r~ noclip désactiver.",
            type = 'basGauche',
            nTimeNotif = 6000,
        })
        SetEntityCollision(playerPed, true, true)
        SetEntityVisible(playerPed, 1, 1)
    end
end

local function degToRad( degs )
    return degs * 3.141592653589793 / 180
end

local function togglePosition()
    isEnablePosition = not isEnablePosition
    
    if(isEnablePosition == true)then
        exports.nCoreGTA:nNotificationMain({
            text = "~g~ Position afficher.",
            type = 'basGauche',
            nTimeNotif = 6000,
        })
    else
        exports.nCoreGTA:nNotificationMain({
            text = "~r~ Position retirer.",
            type = 'basGauche',
            nTimeNotif = 6000,
        })
    end
end

-----------------------------------------------> EVENT :
RegisterNetEvent("GTA:UpdatePlayerAdmin")
AddEventHandler("GTA:UpdatePlayerAdmin", function(admin)
    isPlayerAdmin = admin
end)


--> Commande pour se tp sur un marker :
--> /tpt 
RegisterCommand("tpt", function()
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)
    
    if (isPlayerAdmin == true) then 
        tptop()
    end
end, false)


--> Commande pour être invincible : 
--> /Invincible
RegisterCommand("Invincible", function()
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)
    
    if (isPlayerAdmin == true) then 
        toggleGodmode()
    end
end, false)


--> Commande pour s'ajouté de l'argent propre :
--> /gap montant 
RegisterCommand("gap", function(source, args, rawCommand)
    qtyArgentPropre = args[1]
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)
    
    if (isPlayerAdmin == true) then
        if (tonumber(qtyArgentPropre) ~= nil) then
            TriggerServerEvent("GTA_Admin:AjoutArgentPropre", tonumber(qtyArgentPropre))
        else
            exports.nCoreGTA:nNotificationMain({
                text = "~r~ Veuillez saisir un nombre correct.",
                type = 'basGauche',
                nTimeNotif = 6000,
            })
        end
    end
end, false)


--> Commande pour s'ajouté de l'argent sale :
--> /gas montant
RegisterCommand("gas", function(source, args, rawCommand)
    qtyArgentPropre = args[1]
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)

    if (isPlayerAdmin == true) then
        if (tonumber(qtyArgentPropre) ~= nil) then
            TriggerServerEvent("GTA_Admin:AjoutArgentSale", tonumber(qtyArgentPropre))
        else
            exports.nCoreGTA:nNotificationMain({
                text = "~r~ Veuillez saisir un nombre correct.",
                type = 'basGauche',
                nTimeNotif = 6000,
            })
        end
    end
end, false)


--> Commande pour s'ajouté de l'argent en banque :
--> /gab montant
RegisterCommand("gab", function(source, args, rawCommand)
    qtyArgentPropre = args[1]
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)

    if (isPlayerAdmin == true) then
        if (tonumber(qtyArgentPropre) ~= nil) then
            TriggerServerEvent("GTA_Admin:AjoutArgentBanque", tonumber(qtyArgentPropre))
        else
            exports.nCoreGTA:nNotificationMain({
                text = "~r~ Veuillez saisir un nombre correct.",
                type = 'basGauche',
                nTimeNotif = 6000,
            })
        end
    end
end, false)


--> Commande pour s'ajouté une arme
--> Pour vous give une arme faite /givepistol (nombre du munition avec)
RegisterCommand("givepistol", function(source, args, rawCommand)
    qtyAmmo = args[1]
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)

    if (isPlayerAdmin == true) then
        if tonumber(qtyAmmo) == nil then
            qtyAmmo = 1
            TriggerEvent("player:receiveItem", "Pistolet", 1)
            TriggerEvent("player:receiveItem", "Munition 9mm", tonumber(qtyAmmo))
        else
            TriggerEvent("player:receiveItem", "Pistolet", 1)
            TriggerEvent("player:receiveItem", "Munition 9mm", tonumber(qtyAmmo))
        end
    end
end, false)



--> Commande pour s'ajouté des menottes
--> Pour vous give des menottes faite /givemenotte
RegisterCommand("givemenotte", function(source, args, rawCommand)
    qty = args[1]
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)

    if (isPlayerAdmin == true) then
        if tonumber(qty) == nil then
            qty = 1
            TriggerEvent("player:receiveItem", "Menotte", tonumber(qty))
        else
            TriggerEvent("player:receiveItem", "Menotte", tonumber(qty))
        end
    end
end, false)


--> Commande pour supprimer un véhicule
--> Pour supprimer un véhicule faite /pv
RegisterCommand("pv", function(source, args, rawCommand)
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)

    if (isPlayerAdmin == true) then
        local playerPed = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(playerPed)
        if IsPedInVehicle(playerPed, veh, false) then
            SetEntityAsMissionEntity(veh, true, true )
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			exports.nCoreGTA:ShowNotification("~g~Véhicule supprimer.")
        else
			exports.nCoreGTA:ShowNotification("~r~Veuillez monter dans un véhicule.")
        end
    end
end, false)


--> Commande pour afficher votre position x,y,z,h
--> Pour afficher votre position faite /pos
RegisterCommand("pos", function(source, args, rawCommand)
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)

    if (isPlayerAdmin == true) then
        togglePosition()
    end
end, false)


--> Commande pour vous give un véhicule
--> Pour vous give un véhicule faite /v
RegisterCommand('v', function(source, args, rawCommand)
    TriggerServerEvent("GTA:CheckAdmin")
    
    Wait(50)

    if (isPlayerAdmin == true) then

        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
        local veh = args[1]
        if veh == nil then exports.nCoreGTA:ShowNotification("~y~Veuillez saisir un nom d'un véhicule.") end
        vehiclehash = GetHashKey(veh)
        RequestModel(vehiclehash)
        
        Citizen.CreateThread(function() 
            local waiting = 0
            while not HasModelLoaded(vehiclehash) do
                waiting = waiting + 100
                Citizen.Wait(100)
                if waiting > 3000 then
                    exports.nCoreGTA:ShowNotification("~r~Veuillez saisir un nom d'un véhicule correct !")
                    break
                end
            end
            CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, 1, 0)
            exports.nCoreGTA:ShowNotification(veh.. " spawn !")
        end)
    end
end)


----------------------------------> AFFICHER POSITION X,Y,Z :
local waitEnablePostition = 1000
Citizen.CreateThread(function () 
    while true do 
        Citizen.Wait(waitEnablePostition)
        if isEnablePosition then
		    waitEnablePostition = 0
            local playerPed = GetPlayerPed(-1)
            local pos = GetEntityCoords(playerPed)
            local posH = GetEntityHeading(playerPed)

            posX = (Floor((pos.x)*100))/100
            posY = (Floor((pos.y)*100))/100
            posZ = (Floor((pos.z)*100))/100
            posH = (Floor((posH)*100))/100

            if posH > 360 then 
                posH = 0.0
            elseif posH < 0 then  
                posH = 360.0
            end

            DrawMissionText("~r~x~w~ = ~r~"..posX.." ~g~y~w~ = ~g~"..posY.." ~b~z~w~ = ~b~"..posZ.." ~w~~h~h = "..posH)
		else
		   waitEnablePostition = 1000
        end
    end 
end)