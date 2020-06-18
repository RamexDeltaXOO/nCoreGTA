--||@SuperCoolNinja.||--

local mainTenue = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/ConfigTenue.json'))

local menuCreationPerso = {
	opened = false,
	title = "",
	currentmenu = "mainSex",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 1,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.8 + 0.07,
		y = 0.05,
		width = 0.2 + 0.05,
		height = 0.04,
		buttons = 20,
		from = 1,
		to = 20,
		scale = 0.4,
        font = 0,
        
        ["mainSex"] = {
			title = "Sex",
			name = "mainSex",
            buttons = {
				{name = "Homme", action = "homme", sex = "mp_m_freemode_01"},
				{name = "Femme", action = "femme", sex = "mp_f_freemode_01"},
			}
        },

        ["mainVisageHomme"] = {
			title = "Visage",
			name = "mainVisageHomme",
            buttons = { 
				{name = "#1 Visage fin", description = "", slot = "0", drawHomme = "0", tex = "0", pal = "0"}, --> Maigre
				{name = "#1 Visage gros", description = "", slot = "0", drawHomme = "1", tex = "0", pal = "0"}, --> Gros
				{name = "#2 Visage fin", description = "", slot = "0", drawHomme = "4", tex = "0", pal = "0"}, --> Maigre
				{name = "#2 Visage gros", description = "", slot = "0", drawHomme = "5", tex = "0", pal = "0"}, --> Gros
				{name = "#3 Visage fin", description = "", slot = "0", drawHomme = "10", tex = "0", pal = "0"},--> Maigre
				{name = "#3 Visage gros", description = "", slot = "0", drawHomme = "11", tex = "0", pal = "0"}, --> Gros
			}
        },

        ["mainVisageFemme"] = {
			title = "Visage",
			name = "mainVisageFemme",
            buttons = { 
				{name = "#1 Visage fin", description = "", slot = "0", drawFemme = "18", tex = "0", pal = "0"}, --> Maigre
				{name = "#1 Visage gros", description = "", slot = "0", drawFemme = "20", tex = "0", pal = "0"}, --> Gros
				{name = "#2 Visage fin", description = "", slot = "0", drawFemme = "40", tex = "0", pal = "0"}, --> Maigre
                {name = "#2 Visage gros", description = "", slot = "0", drawFemme = "41", tex = "0", pal = "0"}, --> Gros
				{name = "#3 Visage fin", description = "", slot = "0", drawFemme = "33", tex = "0", pal = "0"}, --> Maigre
				{name = "#3 Visage gros", description = "", slot = "0", drawFemme = "32", tex = "0", pal = "0"},--> Gros
			}
        },

        ["mainCouleurPeau"] = {
			title = "Couleur de peau",
			name = "mainCouleurPeau",
            buttons = { 
				{name = "#1 Couleur", description = "", cpeau = "0"}, 
				{name = "#2 Couleur", description = "", cpeau = "1"}, 
				{name = "#3 Couleur", description = "", cpeau = "2"}, 
				{name = "#4 Couleur", description = "", cpeau = "3"}, 
				{name = "#5 Couleur", description = "", cpeau = "4"},
                {name = "#6 Couleur", description = "", cpeau = "5"}, 
                {name = "#7 Couleur", description = "", cpeau = "6"}, 
                {name = "#8 Couleur", description = "", cpeau = "7"}, 
                {name = "#9 Couleur", description = "", cpeau = "8"}, 
                {name = "#10 Couleur", description = "", cpeau = "9"},
			}
        },

        ["mainCheveux"] = {
			title = "Cheveux",
			name = "mainCheveux",
            buttons = { 
				{name = "#1  Cheveux", description = "", idCheveux = "0", couleur = "0"},
				{name = "#2  Cheveux", description = "", idCheveux = "1", couleur = "0"},
				{name = "#3  Cheveux", description = "", idCheveux = "2", couleur = "0"},
				{name = "#4  Cheveux", description = "", idCheveux = "3", couleur = "0"},
				{name = "#5  Cheveux", description = "", idCheveux = "4", couleur = "0"},
				{name = "#6  Cheveux", description = "", idCheveux = "5", couleur = "0"},
				{name = "#7  Cheveux", description = "", idCheveux = "6", couleur = "0"},
				{name = "#8  Cheveux", description = "", idCheveux = "7", couleur = "0"},
				{name = "#9  Cheveux", description = "", idCheveux = "8", couleur = "0"},
                {name = "#10 Cheveux", description = "", idCheveux = "9", couleur = "0"},
			}
        },

        ["mainCouleursCheveux"] = {
			title = "Couleur Cheveux",
			name = "mainCouleursCheveux",
            buttons = { 
				{name = "Noir", description = "", couleur = "0"},
				{name = "Châtain clair", description = "", couleur = "2"},
				{name = "Marron", description = "", couleur = "3"},
				{name = "Brun", description = "", couleur = "4"},
				{name = "Blond", description = "", couleur = "10"},
				{name = "Roux", description = "", couleur = "19"},
				{name = "Châtain", description = "", couleur = "17"},
				{name = "Bleu", description = "", couleur = "38"},
				{name = "Rose", description = "", couleur = "34"},
				{name = "Vert", description = "", couleur = "39"},
				{name = "Rouge", description = "", couleur = "54"},
				{name = "Orange", description = "", couleur = "50"},
			}
		},
		
		["mainValiderPerso"] = {
			title = "Valider votre personnage",
			name = "mainValiderPerso",
            buttons = { 
				{name = "~g~Valider votre personnage", description = ""},
				{name = "~r~Reprendre de zéro", description = ""},
			}
		},

        ["mainTenue"] = {
			title = "Tenue d'arrivant",
			name = "mainTenue",
            buttons = tenues_list
		},

		["mainValiderTenu"] = {
			title = "Valider votre tenue",
			name = "mainValiderTenu",
            buttons = { 
				{name = "~g~Valider votre tenue", description = ""},
				{name = "changer de tenue", description = ""},
				{name = "réinitialiser votre personnage", description = ""},
			}
		},
		
		["mainIdentiter"] = {
			title = "Votre Identiter",
			name = "mainIdentiter",
			buttons = {}
        },
	}
}

local function UpdatePosPlayer()
	SetEntityCoordsNoOffset(PlayerPedId(), 403.006225894, -996.8715, -99.00)
	SetEntityHeading(PlayerPedId(), 182.65637207031)
end

local function GetPlayerModel(modelhash)
	local playerPed = PlayerPedId()

	if IsModelValid(modelhash) then
		if not IsPedModel(playerPed, modelHash) then
			RequestModel(modelhash)
			while not HasModelLoaded(modelhash) do
				Wait(500)
			end

			SetPlayerModel(PlayerId(), modelhash)
		end

		SetPedHeadBlendData(PlayerPedId(), 0, math.random(45), 0,math.random(45), math.random(5), math.random(5),1.0,1.0,1.0,true)
		SetPedHairColor(PlayerPedId(), math.random(1, 4), 1)
		
		if IsPedMale(PlayerPedId()) then
			SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 7, 0, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)		
		else
			SetPedComponentVariation(PlayerPedId(), 8, 2, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 7, 0, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)
		end

		SetModelAsNoLongerNeeded(modelhash)
	end
end

local function deletePedPreview()
	if DoesEntityExist(config.pedPreview) then
		DeletePed(config.pedPreview)
	end
end

function BeginEditeur()
	if IsPlayerSwitchInProgress() then
		DisplayRadar(false)
		interior = GetInteriorAtCoordsWithType(399.9, -998.7, -100.0, "v_mugshot")
		LoadInterior(interior)
		while not IsInteriorReady(interior) do
			Wait(500)
		end

		config.cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

		while not DoesCamExist(config.cam) do
			Wait(500)
		end

		if DoesCamExist(config.cam) then
			SetCamCoord(config.cam, 402.7553, -1000.55, -98.48412)
			SetCamRot(config.cam, -3.589798, 0.0, -0.276381, 2)
			SetCamFov(config.cam, 37.95373)
			RenderScriptCams(true, false, 3000, 1, 0, 0)
		end
		
		if not DoesEntityExist(config.pedPreview) then
			DeletePed(config.pedPreview)
			config.pedPreview = CreatePed(25, config.Sex, 403.006225894, -996.8715, -99.00, 182.65637207031)
		end

		Visible()
		Wait(3500)
		OpenMainPersonnage("mainSex")
		config.MenuOpen = true
	end
end

RegisterNetEvent("GTA:OpenMenuCreation")
AddEventHandler("GTA:OpenMenuCreation", function()
	BeginEditeur()
end)

RegisterNetEvent("GTA:TenueVetement")
AddEventHandler("GTA:TenueVetement", function()
	for k, v in pairs(tenues_list) do
		tenues_list[k] = nil
	end

	for k, v in pairs(GetPersonnageModel()) do
		table.insert(tenues_list, {title = v.typeDeTenue, name = tostring(v.typeDeTenue), tenueType = tostring(v.typeDeTenue), idTenue = tostring(k)})
	end
end)

RegisterNetEvent("GTA:IdentiterMenu")
AddEventHandler("GTA:IdentiterMenu", function(argentPropre,argentSale)
	menuCreationPerso.currentmenu = "mainIdentiter"
	menuCreationPerso.opened = true
    menuCreationPerso.menu["mainIdentiter"].buttons = {}
    table.insert(menuCreationPerso.menu["mainIdentiter"].buttons, {title = "Nom : ", 	 name = "Nom : ~b~" ..tostring(config.Nom)})
    table.insert(menuCreationPerso.menu["mainIdentiter"].buttons, {title = "Prénom : ",  name = "Prénom : ~b~"..tostring(config.Prenom)})
	table.insert(menuCreationPerso.menu["mainIdentiter"].buttons, {title = "Age : ", 	 name = "Âge : ~b~" ..tonumber(config.Age)})
    table.insert(menuCreationPerso.menu["mainIdentiter"].buttons, {title = "Taille : ",  name = "Taille : ~b~"..tonumber(config.Taille) })
	table.insert(menuCreationPerso.menu["mainIdentiter"].buttons, {title = "Origine : ", name = "Origine : ~b~"..tostring(config.Origine)})
    table.insert(menuCreationPerso.menu["mainIdentiter"].buttons, {title = "Valider : ", name = "~g~Valider votre identité"})
end)


function OpenMainPersonnage(open_menu)
	menuCreationPerso.currentmenu = open_menu
	menuCreationPerso.opened = true
	menuCreationPerso.selectedbutton = 1
end

function CloseMainPersonnage()
	menuCreationPerso.opened = false
	menuCreationPerso.menu.from = 1
	menuCreationPerso.menu.to = 20
end

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

function drawMenuButton(button,x,y,selected)
	local menu = menuCreationPerso.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
		
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)	
end

function drawMenuTitle(txt,x,y)
local menu = menuCreationPerso.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)	
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function GetPersonnageModel()
	for k, _ in pairs(mainTenue) do
		if config.Sex == 'mp_m_freemode_01' then
			return mainTenue[k].TenueHomme
		else
			return mainTenue[k].TenueFemme
		end
	end
end


local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if menuCreationPerso.opened then
			DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT
			local menu = menuCreationPerso.menu[menuCreationPerso.currentmenu]
			drawTxt(menuCreationPerso.title,1,1,menuCreationPerso.menu.x,menuCreationPerso.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, menuCreationPerso.menu.x,menuCreationPerso.menu.y + 0.08)
			drawTxt(menuCreationPerso.selectedbutton.."/"..tablelength(menu.buttons),0,0,menuCreationPerso.menu.x + menuCreationPerso.menu.width/2 - 0.0385,menuCreationPerso.menu.y + 0.067,0.4, 255,255,255,255)
			local y = menuCreationPerso.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				for _,v in pairs(mainTenue) do
					if i >= menuCreationPerso.menu.from and i <= menuCreationPerso.menu.to then
						if i == menuCreationPerso.selectedbutton then
							selected = true
							
							if menuCreationPerso.currentmenu == "mainCouleurPeau" then
								SetPedHeadBlendData(LocalPed(), tonumber(config.Visage), tonumber(config.Visage), tonumber(config.Visage), tonumber(button.cpeau), tonumber(button.cpeau), tonumber(button.cpeau), 1.0, 1.0, 1.0, true)
							end

							if menuCreationPerso.currentmenu == "mainCheveux"  then
								SetPedComponentVariation(LocalPed(), 2,tonumber(button.idCheveux),2,10)
							end

							if menuCreationPerso.currentmenu == "mainCouleursCheveux" then
								SetPedComponentVariation(LocalPed(), 2,tonumber(config.Cheveux),2,10)
								SetPedHairColor(LocalPed(),tonumber(button.couleur))
							elseif menuCreationPerso.currentmenu == "mainCheveux" then
								SetPedComponentVariation(LocalPed(), 2,tonumber(button.idCheveux),2,10)
							end

							if config.Sex == "mp_m_freemode_01" then
								if menuCreationPerso.currentmenu == "mainVisageHomme" then
									SetPedHeadBlendData(LocalPed(), tonumber(button.drawHomme), tonumber(button.drawHomme), tonumber(button.drawHomme), 0, 0, 0, 1.0, 1.0, 1.0, true)
								end
							else
								if menuCreationPerso.currentmenu == "mainVisageFemme" then
									SetPedHeadBlendData(LocalPed(), tonumber(button.drawFemme), tonumber(button.drawFemme), tonumber(button.drawFemme), 0, 0, 0, 1.0, 1.0, 1.0, true)
								end

								if menuCreationPerso.currentmenu == "mainTenue" then
									SetPedComponentVariation(LocalPed(), 2,tonumber(config.Cheveux),2,10)
								end
							end
						else
							selected = false
						end
						drawMenuButton(button,menuCreationPerso.menu.x,y,selected)
						y = y + 0.04
						if selected and IsControlJustPressed(1,201) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
							ButtonSelectedPersonnage(button)
						end
					end
				end
			end
		end
		if menuCreationPerso.opened then
			if IsControlJustPressed(1,188) then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if menuCreationPerso.selectedbutton > 1 then
					menuCreationPerso.selectedbutton = menuCreationPerso.selectedbutton -1
					if buttoncount > 20 and menuCreationPerso.selectedbutton < menuCreationPerso.menu.from then
						menuCreationPerso.menu.from = menuCreationPerso.menu.from -1
						menuCreationPerso.menu.to = menuCreationPerso.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if menuCreationPerso.selectedbutton < buttoncount then
					menuCreationPerso.selectedbutton = menuCreationPerso.selectedbutton +1
					if buttoncount > 20 and menuCreationPerso.selectedbutton > menuCreationPerso.menu.to then
						menuCreationPerso.menu.to = menuCreationPerso.menu.to + 1
						menuCreationPerso.menu.from = menuCreationPerso.menu.from + 1
					end
				end
			end
		end
	end
end)

local Tops
local backlock = false
function ButtonSelectedPersonnage(button)
	local ped = LocalPed()
	local this = menuCreationPerso.currentmenu
    local btn = button.action
	local btname = button.name

	if this == "mainSex" then
		if btn == "homme" then
			deletePedPreview()
            TriggerServerEvent("GTA:UpdateSexPersonnage", button.sex)
            GetPlayerModel(button.sex)
            UpdatePosPlayer()
            OpenMainPersonnage("mainVisageHomme")
		elseif btn == "femme" then
			deletePedPreview()
            TriggerServerEvent("GTA:UpdateSexPersonnage",button.sex)
            GetPlayerModel(button.sex)
            UpdatePosPlayer()
            OpenMainPersonnage("mainVisageFemme")
        end
	elseif this == "mainVisageHomme" then
        if btname == "visage" then
		else
            TriggerServerEvent("GTA:UpdateVisage", tonumber(button.drawHomme))
            OpenMainPersonnage("mainCouleurPeau")
        end
    elseif this == "mainVisageFemme" then
        if btname == "visage" then
        else
            TriggerServerEvent("GTA:UpdateVisage", tonumber(button.drawFemme))
            OpenMainPersonnage("mainCouleurPeau")
        end
    elseif this == "mainCouleurPeau" then
        if btname == "peau" then
        else
            TriggerServerEvent("GTA:UpdateCouleurPeau", tonumber(button.cpeau))
            OpenMainPersonnage("mainCheveux")
        end
    elseif this == "mainCheveux" then
        if btname == "cheveux" then
        else
            TriggerServerEvent("GTA:UpdateCheveux", button.idCheveux)
            OpenMainPersonnage("mainCouleursCheveux")
        end
    elseif this == "mainCouleursCheveux" then
        if btname == "cheveuxC" then
        else
            TriggerServerEvent("GTA:UpdateCouleurCheveux", button.couleur)
			TriggerEvent("GTA:TenueVetement")
			Wait(250)
            OpenMainPersonnage("mainValiderPerso")
		end
	elseif this == "mainValiderPerso" then
		if btname == "~g~Valider votre personnage" then
			OpenMainPersonnage("mainTenue")
		elseif btname == "~r~Reprendre de zéro" then
			OpenMainPersonnage("mainSex")
		end
	elseif this == "mainTenue" then
		for _,v in pairs(mainTenue) do
			if button.tenueType then
				if config.Sex == "mp_m_freemode_01" then
					SetPedComponentVariation(LocalPed(), v.TenueHomme[button.idTenue].Tops.componentId, v.TenueHomme[button.idTenue].Tops.drawableId, v.TenueHomme[button.idTenue].Tops.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueHomme[button.idTenue].Legs.componentId, v.TenueHomme[button.idTenue].Legs.drawableId, v.TenueHomme[button.idTenue].Legs.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueHomme[button.idTenue].Undershirts.componentId, v.TenueHomme[button.idTenue].Undershirts.drawableId, v.TenueHomme[button.idTenue].Undershirts.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueHomme[button.idTenue].Shoes.componentId, v.TenueHomme[button.idTenue].Shoes.drawableId,v.TenueHomme[button.idTenue].Shoes.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueHomme[button.idTenue].Accessories.componentId, v.TenueHomme[button.idTenue].Accessories. drawableId,v.TenueHomme[button.idTenue].Accessories.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueHomme[button.idTenue].Torsos.componentId, v.TenueHomme[button.idTenue].Torsos.drawableId, v.TenueHomme[button.idTenue].Torsos.textureId, 0)
					TriggerServerEvent("GTA:TenueHomme", v.TenueHomme[button.idTenue])
				elseif config.Sex == "mp_f_freemode_01" then
					SetPedComponentVariation(LocalPed(), v.TenueFemme[button.idTenue].Legs.componentId, v.TenueFemme[button.idTenue].Legs.drawableId,v.TenueFemme[button.idTenue].Legs.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueFemme[button.idTenue].Tops.componentId, v.TenueFemme[button.idTenue].Tops.drawableId, v.TenueFemme[button.idTenue].Tops.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueFemme[button.idTenue].Undershirts.componentId, v.TenueFemme[button.idTenue].Undershirts.drawableId, v.TenueFemme[button.idTenue].Undershirts.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueFemme[button.idTenue].Shoes.componentId, v.TenueFemme[button.idTenue].Shoes.drawableId,v.TenueFemme[button.idTenue].Shoes.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueFemme[button.idTenue].Accessories.componentId, v.TenueFemme[button.idTenue].Accessories. drawableId,v.TenueFemme[button.idTenue].Accessories.textureId, 0)
					SetPedComponentVariation(LocalPed(), v.TenueFemme[button.idTenue].Torsos.componentId, v.TenueFemme[button.idTenue].Torsos.drawableId, v.TenueFemme[button.idTenue].Torsos.textureId, 0)
					TriggerServerEvent("GTA:TenueFemme", v.TenueFemme[button.idTenue])
				end
				OpenMainPersonnage("mainValiderTenu")
			end
		end
	elseif this == "mainValiderTenu" then
		if btname == "~g~Valider votre tenue" then
			TriggerEvent("GTA:IdentiterMenu")
			OpenMainPersonnage("mainIdentiter")
		elseif btname == "changer de tenue" then
			OpenMainPersonnage("mainTenue")
		elseif btname == "réinitialiser votre personnage" then
			OpenMainPersonnage("mainSex")
		end
	elseif this == "mainIdentiter" then
		if button.title == "Nom : " then
			config.Nom = SaisitText("", 25)
			if tostring(config.Nom) == nil or tonumber(config.Nom) then
                exports.nCoreGTA:nNotificationMain({
                    text = "Veuillez inserer un nom correct !",
                    type = 'basGauche',
                    nTimeNotif = 6000,
                })
                return nil
            end
			TriggerServerEvent("GTA:UpdateNom", tostring(config.Nom))
			TriggerEvent("GTA:IdentiterMenu")
		elseif button.title == "Prénom : " then
			config.Prenom = SaisitText("", 25)
			if tostring(config.Prenom) == nil or tonumber(config.Prenom) then
                exports.nCoreGTA:nNotificationMain({
                    text = "Veuillez inserer un prénom correct !",
                    type = 'basGauche',
                    nTimeNotif = 6000,
                })
                return nil
            end
			TriggerServerEvent("GTA:UpdatePrenom", tostring(config.Prenom))
			TriggerEvent("GTA:IdentiterMenu")
		elseif button.title == "Age : " then
			config.Age = SaisitText("", 2)
			if tonumber(config.Age) == nil then
                exports.nCoreGTA:nNotificationMain({
                    text = "Veuillez inserer un âge correct !",
                    type = 'basGauche',
                    nTimeNotif = 6000,
                })
                return nil
            end
			TriggerServerEvent("GTA:UpdateAge", tonumber(config.Age))
			TriggerEvent("GTA:IdentiterMenu")
		elseif button.title == "Taille : " then
			config.Taille = SaisitText("", 3)
			if tonumber(config.Taille) == nil then
                exports.nCoreGTA:nNotificationMain({
                    text = "Veuillez inserer une taille correct !",
                    type = 'basGauche',
                    nTimeNotif = 6000,
                })
                return nil
            end
			TriggerServerEvent("GTA:UpdateTaille", tostring(config.Taille))
			TriggerEvent("GTA:IdentiterMenu")
		elseif button.title == "Origine : " then
			config.Origine = SaisitText("", 25)
			if tostring(config.Origine) == nil or tonumber(config.Origine) then
                exports.nCoreGTA:nNotificationMain({
                    text = "Veuillez inserer une origine correct !",
                    type = 'basGauche',
                    nTimeNotif = 6000,
                })
                return nil
            end
			TriggerServerEvent("GTA:UpdateOrigin", tostring(config.Origine))
			TriggerEvent("GTA:IdentiterMenu")
		elseif btname == "~g~Valider votre identité" then
			menuCreationPerso.opened = false
			if DoesCamExist(config.cam) then
            	RenderScriptCams(false, false, 3000, 1, 0, 0)
                FreezeEntityPosition(PlayerPedId(), false)
                SetEntityInvincible(PlayerPedId(), false)
            	DestroyCam(config.cam, true)
			end
			
			if not IsScreenFadedOut() then
                DoScreenFadeOut(400)
                while not IsScreenFadedOut() do
                    Wait(50)
                end
			end
			
			config.MenuOpen = false
			Collision(false)

			Wait(500)
            SetEntityCoords(PlayerPedId(), -491.485, -728.646, 23.9031) --Last pos to join
        	SetEntityHeading(PlayerPedId(), 345.0)        	           
            while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
                Wait(1)
            end

            if IsScreenFadedOut() then
                Wait(500)
                DoScreenFadeIn(300)
                Wait(400)
            end
			DisplayRadar(true)
			SimulatePlayerInputGait(PlayerId(), 1.0, 22500, 1.0, 1, 0)
		end
	end
end

function Collision()
    for _, otherPlayer in ipairs(GetActivePlayers()) do
        SetEntityVisible(GetPlayerPed(otherPlayer), false, false)
        SetEntityVisible(PlayerPedId(), true, true)
    end
end

function Visible()
    while config.MenuOpen == true do
        Citizen.Wait(0)
        Collision()
    end
end