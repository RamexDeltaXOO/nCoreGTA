

local body = {
	scale = 0.3,
	offsetLine = 0.02,
	offsetX = 0.005,
	offsetY = 0.004,
	dict = 'commonmenu',
	sprite = 'gradient_bgd',
	width = 0.14,
	height = 0.012,
	heading = -90.0,
	gap = 0.002,
}

RequestStreamedTextureDict(body.dict)


--> NOTIF SOUND :	PlaySoundFrontend(-1, "Goon_Paid_Small", "GTAO_Boss_Goons_FM_Soundset", 0)
 

local function goDown(v, id) -- Notifications will go under the previous notifications
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y + (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 + body.gap
		end
	end
end

local function goUp(v, id) -- Notifications will go above the previous notifications
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y - (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 - body.gap
		end
	end
end

local function centeredDown(v, id) -- Notification will stay centered from the default position and new notification will go at the bottom
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y - (body.height + (v[id].lines*2 + 1)*body.offsetLine)/4 - body.gap/2
			v[id].y = v[i].y + (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 + body.gap
		end
	end
end

local function centeredUp(v, id) -- Notification will stay centered from the default position and new notification will go at the top
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y + (body.height + (v[id].lines*2 + 1)*body.offsetLine)/4 + body.gap/2
			v[id].y = v[i].y - (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 - body.gap
		end
	end
end

local function CountLines(v, text)
	BeginTextCommandLineCount("STRING")
    SetTextScale(body.scale, body.scale)
    SetTextWrap(v.x, v.x + body.width - body.offsetX)
	AddTextComponentSubstringPlayerName(text)
	local nbrLines = GetTextScreenLineCount(v.x + body.offsetX, v.y + body.offsetY)
	return nbrLines
end

local function DrawText(v, text)
	SetTextScale(body.scale, body.scale)
    SetTextWrap(v.x, v.x + body.width - body.offsetX)

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(v.x + body.offsetX, v.y + body.offsetY)
end

local function DrawBackground(v)
	DrawSprite(body.dict, body.sprite, v.x + body.width/2, v.y + (body.height + v.lines*body.offsetLine)/2, body.width, body.height + v.lines*body.offsetLine, body.heading, 255, 255, 255, 255)
end

local positions = {
	['centrerDroit'] = { x = 0.85, y = 0.5, notif = {}, offset = centeredUp },
	['centrerGauche'] = { x = 0.01, y = 0.5, notif = {}, offset = centeredUp },
	['hautDroit'] = { x = 0.85, y = 0.015, notif = {}, offset = goDown },
	['hautGauche'] = { x = 0.01, y = 0.015, notif = {}, offset = goDown },
	['milieuDroit'] = { x = 0.85, y = 0.955, notif = {}, offset = goUp },
	['milieuGauche'] = { x = 0.015, y = 0.75, notif = {}, offset = goUp },
	['basGauche'] = { x = 0.16, y = 0.93, notif = {}, offset = goUp },
}

function nNotificationMain(options)
	local text = options.text
	local type = options.type
	local nTimeNotif = options.nTimeNotif

	local p = positions[type]
	local id = #p.notif + 1
	local nbrLines = CountLines(p, text)

	p.notif[id] = {
		x = p.x,
		y = p.y,
		lines = nbrLines, 
		draw = true,
	}

	if id > 1 then
		p.offset(p.notif, id)
	end

	Citizen.CreateThread(function()
		Wait(nTimeNotif)
		p.notif[id].draw = false
	end)

	Citizen.CreateThread(function()
		while p.notif[id].draw do
			Wait(0)
			DrawBackground(p.notif[id])
			DrawText(p.notif[id], text)
		end
	end)
end

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

-----||Notification avec votre t�te||-----
Ninja_Core__ShowNinjaNotification = function(title, subject, msg)
	local mugshot, mugshotStr = Ninja_Core__GetPedMugshot(GetPlayerPed(-1))
    Ninja_Core_ShowAdvancedNotification(title, subject, msg, mugshotStr, 1)
	UnregisterPedheadshot(mugshot)
end
]]

-----||Uniquement utilis� pour l'interaction avec peds||-----
Ninja_Core_PedsText = function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end

-----||Uniquement utilis� pour les start vos anims||-----
Ninja_Core_StartAnim = function(entity, lib, anim)
    RequestAnimDict(lib)
    while not HasAnimDictLoaded(lib) do
        Wait(1000)
    end
	TaskPlayAnim(entity, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
end

-----||Uniquement utiliser pour les Anim Set Attitude (demarche)||-----
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