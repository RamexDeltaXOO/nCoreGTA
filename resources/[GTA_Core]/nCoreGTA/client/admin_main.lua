-----------------------------------------------> Variable :
local isPlayerAdmin = false;
local godmode = false;
local qtyArgentPropre = 0;

-----------------------------------------------> Function :
function LocalPed()
	return GetPlayerPed(-1)
end

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
    isNoClip = not isNoClip
    local playerPed = PlayerPedId()
    if(isNoClip == true)then
        local x, y, z = table.unpack( GetEntityCoords( playerPed, false ) )
        curLocation = { x = x, y = y, z = z }
        curRotation = GetEntityRotation( playerPed, false )
        curHeading = GetEntityHeading( playerPed )
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
        SetEntityVisible(playerPed, 1, 1)
    end
end

local function degToRad( degs )
    return degs * 3.141592653589793 / 180
end


-----------------------------------------------> EVENT :
TriggerServerEvent("GTA:CheckAdmin")

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


--> Commande pour se mettre en No-Clip : 
--> /nc
RegisterCommand("nc", function()
    TriggerServerEvent("GTA:CheckAdmin")
    Wait(50)
    
    if (isPlayerAdmin == true) then 
        toggleNoClip()
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
            exports.nCoreGTA:nNotificationMain({
                text = "Vous avez reçu un ~g~pistolet~w~ avec : ~b~" ..tonumber(qtyAmmo) .. "~w~ munitions.",
                type = 'basGauche',
                nTimeNotif = 6000,
            })
            TriggerEvent("player:receiveItem", 1, 1)
            TriggerEvent("player:receiveItem", 2, tonumber(qtyAmmo))
        else
            TriggerEvent("player:receiveItem", 1, 1)
            TriggerEvent("player:receiveItem", 2, tonumber(qtyAmmo))
            exports.nCoreGTA:nNotificationMain({
                text = "Vous avez reçu un ~g~pistolet~w~ avec : ~b~" ..tonumber(qtyAmmo) .. "~w~ munitions.",
                type = 'basGauche',
                nTimeNotif = 6000,
            })
        end
    end
end, false)


-----------------------------------------------> THREAD :
Citizen.CreateThread( function()
    local rotationSpeed = 2.0
    local forwardPush = 0.7

    local moveUpKey = 44      -- Q
    local moveDownKey = 46    -- E
    local moveForwardKey = 32 -- W
    local moveBackKey = 33    -- S
    local rotateLeftKey = 34  -- A
    local rotateRightKey = 35 -- D

    -- Updates the players position
    function handleMovement(xVect,yVect)
        if IsControlPressed( 1, moveUpKey) then
            curLocation.z = curLocation.z + forwardPush
        elseif IsControlPressed( 1, moveDownKey) then
            curLocation.z = curLocation.z - forwardPush
        end

        if IsControlPressed( 1, moveForwardKey) then
            curLocation.x = curLocation.x + xVect
            curLocation.y = curLocation.y + yVect
        elseif IsControlPressed( 1, moveBackKey) then
            curLocation.x = curLocation.x - xVect
            curLocation.y = curLocation.y - yVect
        end

        if IsControlPressed( 1, rotateLeftKey) then
            curHeading = curHeading + rotationSpeed
        elseif IsControlPressed( 1, rotateRightKey) then
            curHeading = curHeading - rotationSpeed
        end
    end
     while true do
        Citizen.Wait(0)
        if (isNoClip) then
            local playerPed = PlayerPedId()
            target = playerPed

            -- Handle Noclip Movement.
            local inVehicle = IsPedInAnyVehicle( playerPed, true )

            if ( inVehicle ) then
                target = GetVehiclePedIsUsing( playerPed )
            end

            -- Prevent Conflicts/Damage
            local xVect = forwardPush * math.sin(degToRad(curHeading)) * -1.0
            local yVect = forwardPush * math.cos(degToRad(curHeading))

            handleMovement(xVect,yVect)

            -- Update player postion.
            SetEntityCoordsNoOffset( target, curLocation.x, curLocation.y, curLocation.z, true, true, true )
            SetEntityHeading( target, curHeading - rotationSpeed )
        end
     end
end)