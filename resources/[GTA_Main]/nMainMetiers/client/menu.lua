--||@SuperCoolNinja.||--
local listEmploi = {}
local menuConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/ConfigMenu.json'))
local scaleform = nil

local actionEmploi = {
	opened = false,
	title = "",
	currentmenu = "actionEmploiMain",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 1,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.1 + 0.03,
		y = 0.0 + 0.03,
		width = 0.2 + 0.02 + 0.005,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.3 + 0.05, --> Taille.
        font = 0,
        
        ["actionEmploiMain"] = {
			title = "Emploi disponible",
			name = "actionEmploiMain",
            buttons = listEmploi
        },
	}
}

RegisterNetEvent("GTA:ListEmploi")
AddEventHandler("GTA:ListEmploi", function(jobsDispo)
	for k, v in pairs(listEmploi) do
		listEmploi[k] = nil
	end

	for k, v in pairs(jobsDispo) do
		table.insert(listEmploi, {title = v.jobName, name = tostring(v.jobName), nomJobs = tostring(v.jobName), idJob = tonumber(k)})
	end
end)

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k,_ in pairs(blips) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, blips[k].x, blips[k].y, blips[k].z)

            if dist <= 3 then
                if GetLastInputMethod(0) then
                    Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour accéder a la recherche ~b~d'emplois")
                else
                    Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour accéder a la recherche ~b~d'emplois")
                end
				
				if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
                    for i=1, #Config.Locations do
						local myPeds = Config.Locations[i]["sPed"]
						
						PlayAmbientSpeech2(myPeds["entity"], "GENERIC_HI", "SPEECH_PARAMS_FORCE_SHOUTED") --> Sert a faire parler le ped plus l'animer.
                        exports.nCoreGTA:Ninja_Core_StartAnim(myPeds["entity"], "gestures@f@standing@casual", "gesture_hand_right")
                        exports.nCoreGTA:Ninja_Core_PedsText("~b~Secrétaire ~w~: ~h~Hey, bien le bonjour !", 5000)
					end
					if actionEmploi.opened == false then
						TriggerServerEvent("GTA:GetJobsList")
						OpenMainMenu()
					else
						CloseMainEmploi()
					end
				end
            end
        end
    end
end)

function LocalPed()
	return GetPlayerPed(-1)
end

function DrawTextMenu(fonteP, stringT, scale, posX, posY)
    SetTextFont(fonteP)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(stringT)
    DrawText(posX, posY)
end

function OpenMainMenu()
    if not HasStreamedTextureDictLoaded("ninja_source") then
        RequestStreamedTextureDict("ninja_source", true)
    end

    scaleform = RequestScaleformMovie("mp_menu_glare")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "initScreenLayout")
    PopScaleformMovieFunctionVoid()
    
    actionEmploi.currentmenu = "actionEmploiMain"
    actionEmploi.opened = true
    actionEmploi.selectedbutton = 1
end

function CloseMainEmploi()
	actionEmploi.opened = false
	actionEmploi.menu.from = 1
	actionEmploi.menu.to = 10
end

function drawMenuButton(button,x,y,selected)
	local menu = actionEmploi.menu

	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)

	for i=1, #menuConfig do 
		if selected then
			SetTextColour(menuConfig[i].couleurTextSelectMenu.r, menuConfig[i].couleurTextSelectMenu.g, menuConfig[i].couleurTextSelectMenu.b, menuConfig[i].couleurTextSelectMenu.a)
		else
			SetTextColour(menuConfig[i].couleurTextMenu.r, menuConfig[i].couleurTextMenu.g, menuConfig[i].couleurTextMenu.b, menuConfig[i].couleurTextMenu.a)
		end

		if selected then
			DrawRect(x,y,menu.width,menu.height,menuConfig[i].couleurRectSelectMenu.r,menuConfig[i].couleurRectSelectMenu.g,menuConfig[i].couleurRectSelectMenu.b,menuConfig[i].couleurRectSelectMenu.a)
		else
			DrawRect(x,y,menu.width,menu.height,0,0,0,150)
		end
	end

	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuTitle(txt,x,y)
    local menu = actionEmploi.menu
    SetTextFont(0)
    SetTextScale(0.4 + 0.008, 0.4 + 0.008)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString(txt)
	for i=1, #menuConfig do 
		DrawRect(x,y,menu.width,menu.height, menuConfig[i].couleurTopMenu.r, menuConfig[i].couleurTopMenu.g, menuConfig[i].couleurTopMenu.b, menuConfig[i].couleurTopMenu.a)
	end
    DrawTextMenu(1, txt, 0.8,menu.width - 0.4 / 2 + 0.1 + 0.005, y - menu.height/2 + 0.01, 255, 255, 255)
    DrawSprite("ninja_source", "interaction_bgd", x,y, menu.width,menu.height + 0.04 + 0.007, .0, 255, 255, 255, 255)
    DrawScaleformMovie(scaleform, 0.42 + 0.003,0.45, 0.9,0.9)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if actionEmploi.opened then
			DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT
			local ped = LocalPed()
			local menu = actionEmploi.menu[actionEmploi.currentmenu]
			drawTxt(actionEmploi.title,1,1,actionEmploi.menu.x,actionEmploi.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, actionEmploi.menu.x,actionEmploi.menu.y + 0.08)
			local y = actionEmploi.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= actionEmploi.menu.from and i <= actionEmploi.menu.to then
					if i == actionEmploi.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,actionEmploi.menu.x,y + 0.02 + 0.003,selected)
					y = y + 0.04
					if selected and IsControlJustPressed(1,201) then --> ENTER
						PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
						ButtonSelectedEmploi(button)
					end
				end
			end
		end
		if actionEmploi.opened then
			if IsControlJustPressed(1,202) then --> BACK
				CloseMainEmploi()
			end
			if IsControlJustPressed(1,188) then --> UP
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if actionEmploi.selectedbutton > 1 then
					actionEmploi.selectedbutton = actionEmploi.selectedbutton -1
					if buttoncount > 10 and actionEmploi.selectedbutton < actionEmploi.menu.from then
						actionEmploi.menu.from = actionEmploi.menu.from -1
						actionEmploi.menu.to = actionEmploi.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then --> DOWN
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if actionEmploi.selectedbutton < buttoncount then
					actionEmploi.selectedbutton = actionEmploi.selectedbutton +1
					if buttoncount > 10 and actionEmploi.selectedbutton > actionEmploi.menu.to then
						actionEmploi.menu.to = actionEmploi.menu.to + 1
						actionEmploi.menu.from = actionEmploi.menu.from + 1
					end
				end
			end
		end

	end
end)

function ButtonSelectedEmploi(button)
	local ped = GetPlayerPed(-1)
	local this = actionEmploi.currentmenu
	local btn = button.action
	local index = button.idJob

	if this == "actionEmploiMain" then
		if button.nomJobs then
			TriggerServerEvent("GTA:UpdateJob", button.nomJobs)
			TriggerServerEvent("GTA:LoadJobsJoueur")
			CloseMainEmploi()
		end
	end
end

function Back()
	CloseMainEmploi()
end