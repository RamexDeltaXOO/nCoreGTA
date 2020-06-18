--||@SuperCoolNinja.||--
local listEmploi = {}
local menuConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/ConfigMenu.json'))


local actionEmploi = {
	opened = false,
	title = "",
	currentmenu = "actionEmploiMain",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 1,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.9,
		y = 0.26,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
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

        for k in pairs(blips) do
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
						OpenMainEmploi("actionEmploiMain")
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

function OpenMainEmploi(open_menu)
	actionEmploi.currentmenu = open_menu
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
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	for i=1, #menuConfig do 
		DrawRect(x,y,menu.width,menu.height, menuConfig[i].couleurTopMenu.r, menuConfig[i].couleurTopMenu.g, menuConfig[i].couleurTopMenu.b, menuConfig[i].couleurTopMenu.a)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
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
			drawTxt(actionEmploi.selectedbutton.."/"..tablelength(menu.buttons),0,0,actionEmploi.menu.x + actionEmploi.menu.width/2 - 0.0385,actionEmploi.menu.y + 0.067,0.4, 255,255,255,255)
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
					drawMenuButton(button,actionEmploi.menu.x,y,selected)
					y = y + 0.04
					if selected and IsControlJustPressed(1,201) then --> ENTER
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
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