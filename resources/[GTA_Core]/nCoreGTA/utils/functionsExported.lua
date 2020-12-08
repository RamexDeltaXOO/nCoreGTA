-----||Notification utilisé plus souvent coté serveur||-----
function ShowNotification(text)
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
	DrawNotification( false, false )
end

RegisterNetEvent('nMenuNotif:showNotification')
AddEventHandler('nMenuNotif:showNotification', function(msg)
	ShowNotification(msg)
end)

--Notif avec tête :
--[[
    function Ninja_Core__GetPedMugshot(ped) 
        local mugshot = RegisterPedheadshot(ped)
        while not IsPedheadshotReady(mugshot) do
            Citizen.Wait(0)
        end
        return mugshot, GetPedheadshotTxdString(mugshot)
    end

    Ninja_Core_ShowAdvancedNotification = function(title, subject, msg, icon, iconType) 
        AddTextEntry('Ninja_Core_ShowAdvancedNotification', msg)
        SetNotificationTextEntry('Ninja_Core_ShowAdvancedNotification')
        SetNotificationMessage(icon, icon, false, iconType, title, subject)
        DrawNotification(false, false)
    end

    -----||Notification avec votre tête||-----
    Ninja_Core__ShowNinjaNotification = function(title, subject, msg)
        local mugshot, mugshotStr = Ninja_Core__GetPedMugshot(GetPlayerPed(-1))
        Ninja_Core_ShowAdvancedNotification(title, subject, msg, mugshotStr, 1)
        UnregisterPedheadshot(mugshot)
    end
]]

-----||Interaction avec peds||-----
Ninja_Core_PedsText = function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end

-----||Start vos anims||-----
Ninja_Core_StartAnim = function(entity, lib, anim)
    RequestAnimDict(lib)
    while not HasAnimDictLoaded(lib) do
        Wait(1000)
    end
	TaskPlayAnim(entity, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
end

-----||Anim Set Attitude (demarche)||-----
Ninja_Core_nRequestAnimSet = function(lib, animSet)
	if not HasAnimSetLoaded(animSet) then
		RequestAnimSet(animSet)

		while not HasAnimSetLoaded(animSet) do
			Citizen.Wait(1)
		end
		SetPedMotionBlur(GetPlayerPed(-1), true)
		SetPedMovementClipset(GetPlayerPed(-1), animSet, true)
	end
end

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


function progression(time) 
	SendNUIMessage({
		type = "ui",
		display = true,
		time = time
	})
end

TextHeight = GetTextScaleHeight(config.Scale, config.Font)
function GetCharacterCount(string)
    local len = 0
    for c in string:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
        len = len + 1
    end
    return len
end

function GetLineCount(Text, X, Y, X1, X2)
    SetTextFont(config.Font)
    SetTextScale(config.Scale, config.Scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextWrap(X1, X2)

    BeginTextCommandLineCount("STRING")

    local chars = GetCharacterCount(Text)
    if chars < 100 then
        AddTextComponentSubstringPlayerName(Text)
    else
        local len = (chars % 100 == 0) and chars / 100 or (chars / 100) + 1
        for i = 0, len do
            AddTextComponentSubstringPlayerName(Text:sub(i * 100, (i * 100) + 100))
        end
    end

    return EndTextCommandGetLineCount(X, Y)
end

function GetMessageHeight(Message, X, Y)
    local Lines = GetLineCount(Message.Message,
        X,
        Y,
        (config.Positions[config.Position].x - (config.Width / 2)) + config.Padding, 
        (config.Positions[config.Position].x + (config.Width / 2)) - config.Padding                            
    ) 

    Message.Lines = Lines  

    return (TextHeight * Lines) + (config.Padding * 2)
end

function RenderText(Text, X, Y, A, X1, X2)
    SetTextWrap(X1, X2)
    SetTextFont(config.Font)
    SetTextProportional(true)
    SetTextScale(config.Scale, config.Scale)
    SetTextColour(255, 255, 255, A)
    SetTextDropShadow(0, 0, 0, 0, A)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, A)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentSubstringPlayerName(Text)
    DrawText(X, Y)
end

function showLoadingPromt(label, time)
    Citizen.CreateThread(function()
        BeginTextCommandBusyString(tostring(label))
        EndTextCommandBusyString(3)
        Citizen.Wait(time)
        RemoveLoadingPrompt()
    end)
end

function DrawMissionText(m_text, showtime)
    ClearPrints()
	SetTextScale(0.5, 0.5)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(m_text)
	DrawText(0.5, 0.9)
end