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
    noclipActive = not noclipActive
    local playerPed = PlayerPedId()
    if(noclipActive == true)then
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

conf = {
    controls = {
        goUp = 85, -- [[Q]]
        goDown = 48, -- [[Z]]
        turnLeft = 34, -- [[A]]
        turnRight = 35, -- [[D]]
        goForward = 32,  -- [[W]]
        goBackward = 33, -- [[S]]
        changeSpeed = 21, -- [[L-Shift]]
    },

    speeds = {
        -- [[If you wish to change the speeds or labels there are associated with then here is the place.]]
        { label = "Escargot", speed = 0},
        { label = "Doucement", speed = 0.5},
        { label = "Normal", speed = 2},
        { label = "Rapide", speed = 4},
        { label = "Trop Rapide", speed = 6},
        { label = "Flash", speed = 10},
        { label = "Flash V2", speed = 20},
        { label = "Vitesse Max", speed = 25}
    },

    offsets = {
        y = 0.5, -- [[How much distance you move forward and backward while the respective button is pressed]]
        z = 0.2, -- [[How much distance you move upward and downward while the respective button is pressed]]
        h = 3, -- [[How much you rotate. ]]
    },
}

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, conf.controls.goUp, true))
    ButtonMessage("Monter")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, conf.controls.goDown, true))
    ButtonMessage("Descendre")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(1, conf.controls.turnRight, true))
    Button(GetControlInstructionalButton(1, conf.controls.turnLeft, true))
    ButtonMessage("Tourner Gauche/Droite")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(1, conf.controls.goBackward, true))
    Button(GetControlInstructionalButton(1, conf.controls.goForward, true))
    ButtonMessage("Avancer/Reculer")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, conf.controls.changeSpeed, true))
    ButtonMessage("Changer la vitesse ("..conf.speeds[index].label..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(255)
    PopScaleformMovieFunctionVoid()

    return scaleform
end


--==--==--==--
-- End Of Config
--==--==--==--

noclipActive = false -- [[Wouldn't touch this.]]

index = 1 -- [[Used to determine the index of the speeds table.]]

Citizen.CreateThread(function()

    buttons = setupScaleform("instructional_buttons")

    currentSpeed = conf.speeds[index].speed

    while true do
        Citizen.Wait(1)

        

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
        else
            noclipEntity = PlayerPedId()
        end

        SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
        FreezeEntityPosition(noclipEntity, noclipActive)
        SetEntityInvincible(noclipEntity, noclipActive)
        SetVehicleRadioEnabled(noclipEntity, not noclipActive) -- [[Stop radio from appearing when going upwards.]]

        if noclipActive then
            DrawScaleformMovieFullscreen(buttons)

            local yoff = 0.0
            local zoff = 0.0

            if IsControlJustPressed(1, conf.controls.changeSpeed) then
                if index ~= 8 then
                    index = index+1
                    currentSpeed = conf.speeds[index].speed
                else
                    currentSpeed = conf.speeds[1].speed
                    index = 1
                end
                setupScaleform("instructional_buttons")
            end

			if IsControlPressed(0, conf.controls.goForward) then
                yoff = conf.offsets.y
			end
			
            if IsControlPressed(0, conf.controls.goBackward) then
                yoff = -conf.offsets.y
			end
			
            if IsControlPressed(0, conf.controls.turnLeft) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+conf.offsets.h)
			end
			
            if IsControlPressed(0, conf.controls.turnRight) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)-conf.offsets.h)
			end
			
            if IsControlPressed(0, conf.controls.goUp) then
                zoff = conf.offsets.z
			end
			
            if IsControlPressed(0, conf.controls.goDown) then
                zoff = -conf.offsets.z
			end
			
            local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
            local heading = GetEntityHeading(noclipEntity)
            SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
            SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
            SetEntityHeading(noclipEntity, heading)
            SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
        end
    end
end)