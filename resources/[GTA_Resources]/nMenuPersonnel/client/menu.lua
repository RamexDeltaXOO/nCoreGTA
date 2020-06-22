--||@SuperCoolNinja.||--


-->Variable :
local menuConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/ConfigMenu.json'))
local active, Cashactive = false, false
local isHautRetirer, isBasRetirer, isChaussureRetirer, isChapeauRetirer = false, false, false, false
local RequestStreamedTextureDict = RequestStreamedTextureDict
local SetStreamedTextureDictAsNoLongerNeeded = SetStreamedTextureDictAsNoLongerNeeded
local drawSprite = DrawSprite
local color_white = {255, 255, 255}
local scaleform = nil


-->Event :
RegisterNetEvent("GTA:UpdateDirtyCash")
AddEventHandler("GTA:UpdateDirtyCash", function(dirtycash)
	dirtyMoney = dirtycash
end)

RegisterNetEvent('GTA:RegarderIdentiter')
AddEventHandler('GTA:RegarderIdentiter', function(pNom, pPrenom, pTravail, pAge, pOrigine)
	active = true
	playerInfo.nom = tostring(pNom)
	playerInfo.prenom = tostring(pPrenom)
	playerInfo.metiers = tostring(pTravail)
	playerInfo.age = tonumber(pAge)
	playerInfo.origine = tostring(pOrigine)
end)


RegisterNetEvent('GTA:UpdateCash')
AddEventHandler('GTA:UpdateCash', function(argentSale, argentPropre)
	Cashactive = true
	playerInfo.argentPropre = tonumber(argentPropre)
	playerInfo.argentSale = tonumber(argentSale)
end)

RegisterNetEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
    TriggerServerEvent("bank:givecash", toPlayer, tonumber(amount))
end)


RegisterNetEvent('bank:givesale')
AddEventHandler('bank:givesale', function(toPlayer, amount)
  if(IsNearPlayer(toPlayer) == true) then
    local player2 = GetPlayerFromServerId(toPlayer)
    local playing = IsPlayerPlaying(player2)
    if (playing ~= false) then
      TriggerServerEvent("bank:givesale", toPlayer, tonumber(amount))
    else
		exports.nCoreGTA:nNotificationMain({
			text = "~r~ Aucune personne devant vous ~w~.",
			type = 'basGauche',
			nTimeNotif = 6000,
		})
    end
  end
end)

---> Function :
function DrawAdvancedText2(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end

local function RenderCarte()
	DrawRect(0.883000000000001, 0.37, 0.190, 0.325, 0, 0, 0, 220)
	DrawAdvancedText2(0.975000000000001, 0.239, 0.005, 0.0028, 0.5, "Carte d'identité", 255, 255, 255, 255, 0, 0)
	
	DrawAdvancedText2(0.897000000000001, 0.290, 0.005, 0.0028, 0.3, "Nom :~b~ "..playerInfo.nom, 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.897000000000001, 0.320, 0.005, 0.0028, 0.3, "Prénom :~b~ "..playerInfo.prenom, 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.897000000000001, 0.350, 0.005, 0.0028, 0.3, "Âge :~b~ "..playerInfo.age.."~w~ ans", 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.897000000000001, 0.380, 0.005, 0.0028, 0.3, "Métier :~b~ "..playerInfo.metiers, 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.897000000000001, 0.410, 0.005, 0.0028, 0.3, "Origine : ~b~ "..playerInfo.origine, 255, 255, 255, 255, 0, 1)
end


local function RenderMoneyCarte()
	DrawRect(0.875000000000001, 0.440, 0.185, 0.330, 0, 0, 0, 200)
	DrawAdvancedText2(0.928000000000001, 0.300, 0.005, 0.0028, 0.5, "Mon Argent :", 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.889000000000001, 0.360, 0.005, 0.0028, 0.4, "Argent ~g~Propre~w~ : ~g~"..playerInfo.argentPropre.."$", 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.889000000000001, 0.400, 0.005, 0.0028, 0.4, "Argent ~r~Sale~w~ : ~r~"..playerInfo.argentSale.. "$", 255, 255, 255, 255, 0, 1)
end


local function RequestToSave()
	LastPosX, LastPosY, LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	TriggerServerEvent("GTA:SAVEPOS", LastPosX , LastPosY , LastPosZ)
	exports.nCoreGTA:nNotificationMain({
		text = "~g~ Position Sauvegarder ~w~.",
		type = 'basGauche',
		nTimeNotif = 6000,
	})
end

--> MENU :
local menuPerso = {
	opened = false,
	title = "",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
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
		font = 0, --> Police d'écriture.
		["main"] = { --> Menu Principale
			title = "Menu Personnel",
			name = "main",
			buttons = {
				{name = "Inventaire", description = "", action = ""},
				{name = "Tenue", description = "", action = ""},
				{name = "Mon Portefeuille", description = "", action = ""},
				{name = "Mon Identité", description = "", action = ""},
				{name = "Hud", description = "", action = ""},
				{name = "~g~Sauvegarder ma position", description = "", action = ""},
			}
		},

		["Inventaire"] = { --> Menu Inventaire.
			title = "Inventaire" ,
			name = "Inventaire",
			buttons = inventory_item
		},

		["Tenue"] = { --> Menu Tenues Joueur.
			title = "Tenue" ,
			name = "Tenue",
			buttons = {}
		},

		["ItemUtilisable"] = { --> Sous Menu Inventaire(Item Utilisable)
			title = "Inventaire",
			name = "ItemUtilisable",
			buttons = {
				{title = "~b~Utiliser", name = "utiliser"},
				{title = "~g~Donner", name = "donner"},
				{title = "~r~Detruire", name = "jeter"},
			}
		},


		["ItemNonUtilisable"] = { --> Sous Menu Inventaire(Item Non-Utilisable)
			title = "Inventaire",
			name = "ItemNonUtilisable",
			buttons = {
				{title = "~g~Donner", name = "donner"},
				{title = "~r~Detruire", name = "jeter"},
			}
		},

		["Mon Portefeuille"] = { --> Menu Portefeuille
			title = "Mon Portefeuille",
			name = "Mon Portefeuille",
			buttons = {
				{name = "Donner de ~g~l'argent propre"},
				{name = "Donner de ~r~l'argent sale"},
				{name = "Regarder son portefeuille"},
			}
		},

		["Mon Identité"] = { --> Menu Identité
			title = "Mon Identiter",
			name = "Mon Identité",
			buttons = {
				{name = "Regarder son identité"},
				{name = "Montrer son identité"},
			}
		},

		["Hud"] = { --> Menu Jobs
			title = "Hud",
			name = "Hud",
			buttons = {
				{name = "Afficher/Cacher Faim/Soif"},
			}
		},

  	}
}


RegisterNetEvent("GTA:TenueMenu")
AddEventHandler("GTA:TenueMenu", function()
	TriggerServerEvent("GTA:GetPlayerSex")

	menuPerso.currentmenu = "Tenue"
	menuPerso.opened = true
	menuPerso.menu["Tenue"].buttons = {}
	
	if (isHautRetirer == true) then
    	table.insert(menuPerso.menu["Tenue"].buttons, {title = "Mettre votre haut", 	 name = "Mettre votre haut"})
	else
		table.insert(menuPerso.menu["Tenue"].buttons, {title = "Retirer votre haut", 	 name = "Retirer votre haut"})
	end

	if (isBasRetirer == true) then 
		table.insert(menuPerso.menu["Tenue"].buttons, {title = "Mettre votre bas",  name = "Mettre votre bas"})
	else
		table.insert(menuPerso.menu["Tenue"].buttons, {title = "Retirer votre bas",  name = "Retirer votre bas"})
	end

	if (isChaussureRetirer == true) then 
		table.insert(menuPerso.menu["Tenue"].buttons, {title = "Mettre vos chaussures",  name = "Mettre vos chaussures"})
	else
		table.insert(menuPerso.menu["Tenue"].buttons, {title = "Retirer vos chaussures",  name = "Retirer vos chaussures"})
	end

	if (isChapeauRetirer == true) then 
		table.insert(menuPerso.menu["Tenue"].buttons, {title = "Mettre votre bonnet",  name = "Mettre votre bonnet"})
	else
		table.insert(menuPerso.menu["Tenue"].buttons, {title = "Retirer votre bonnet",  name = "Retirer votre bonnet"})
	end
end)

--Function :
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
	
	menuPerso.currentmenu = "main"
	menuPerso.opened = true
	menuPerso.selectedbutton = 1
end

function CloseMainMenu()
	Citizen.CreateThread(function()
		menuPerso.opened = false
		menuPerso.menu.from = 1
		menuPerso.menu.to = 10
	end)
end

function drawMenuButton(button,x,y,selected)
	local menu = menuPerso.menu
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

function drawMenuTitle(txt,x,y)
	local menu = menuPerso.menu
	SetTextFont(0)
	SetTextScale(0.4 + 0.008, 0.4 + 0.008)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height + 0.04 + 0.007, 0, 0, 0, 0)
	DrawTextMenu(1, txt, 0.8,menu.width - 0.4 / 2 + 0.1 + 0.005, y - menu.height/2 + 0.01, 255, 255, 255)
	drawSprite("ninja_source", "interaction_bgd", x,y, menu.width,menu.height + 0.04 + 0.007, .0, 255, 255, 255, 255)
	DrawScaleformMovie(scaleform, 0.42 + 0.003,0.45, 0.9,0.9)
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do 
		count = count + 1 
	end
	return count
end

local backlock = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
      
		if IsControlJustReleased(0, 244) then 
			if not menuPerso.opened then
				OpenMainMenu()
				TriggerServerEvent("item:getItems")
			end
		end

		if menuPerso.opened then
			DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
			DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT
			local ped = LocalPed()
			local menu = menuPerso.menu[menuPerso.currentmenu]
			drawMenuTitle(menu.title, menuPerso.menu.x,menuPerso.menu.y + 0.08)
			local y = menuPerso.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				if i >= menuPerso.menu.from and i <= menuPerso.menu.to then
					if i == menuPerso.selectedbutton then
						selected = true
					else
						selected = false
					end
				drawMenuButton(button,menuPerso.menu.x,y + 0.02 + 0.003,selected)
				y = y + 0.04
					if selected and IsControlJustPressed(1,201) then
						PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
						ButtonSelected(button)
					end
				end
			end
		end

		if menuPerso.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustPressed(1,188) then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if menuPerso.selectedbutton > 1 then
					menuPerso.selectedbutton = menuPerso.selectedbutton -1
					if buttoncount > 10 and menuPerso.selectedbutton < menuPerso.menu.from then
						menuPerso.menu.from = menuPerso.menu.from -1
						menuPerso.menu.to = menuPerso.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if menuPerso.selectedbutton < buttoncount then
					menuPerso.selectedbutton = menuPerso.selectedbutton +1
					if buttoncount > 10 and menuPerso.selectedbutton > menuPerso.menu.to then
						menuPerso.menu.to = menuPerso.menu.to + 1
						menuPerso.menu.from = menuPerso.menu.from + 1
					end
				end
			end
		end
    end
end)


function OpenMenu(menu)
	menuPerso.lastmenu = menuPerso.currentmenu
	menuPerso.menu.from = 1
	menuPerso.menu.to = 10
	menuPerso.selectedbutton = 1
	menuPerso.currentmenu = menu
end

local itemSelected = 0
local itemIDSelected = 0
local itemQty = 0
local itemName = ""
function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = menuPerso.currentmenu
	local btn = button.name
	local btnAction = button.action
	local btnTypeItem = button.itemType

    if this == "main" then --> Menu Principale
        if btn == "Inventaire" then
			OpenMenu("Inventaire")
		elseif btn == "Tenue" then
			TriggerEvent("GTA:TenueMenu")
			OpenMenu("Tenue")
		elseif btn == "Mon Portefeuille" then
			OpenMenu("Mon Portefeuille")
		elseif btn == "Mon Identité" then
			OpenMenu("Mon Identité")
		elseif btn == "Hud" then
			OpenMenu("Hud")
		elseif btn == "~g~Sauvegarder ma position" then
			RequestToSave()
			CloseMainMenu()
		end
	elseif this == "Inventaire" then --> Menu Inventaire
		if tonumber(btnTypeItem) == 1 then
			OpenMenu('ItemUtilisable')
			itemSelected = button.itemType
			itemName = button.itemName
			itemIDSelected = button.iteamID
			itemQty = button.itemqty
		elseif tonumber(btnTypeItem) == 2 then
			OpenMenu('ItemUtilisable')
			itemSelected = button.itemType
			itemName = button.itemName
			itemIDSelected = button.iteamID
			itemQty = button.itemqty
		elseif tonumber(btnTypeItem) == 3 then
			OpenMenu('ItemNonUtilisable')
			itemSelected = button.itemType
			itemName = button.itemName
			itemIDSelected = button.iteamID
			itemQty = button.itemqty
		end
	elseif this == "Tenue" then --> Menu Tenue
		if btn == "Mettre votre haut" then
			isHautRetirer = not isHautRetirer
			TriggerEvent("GTA:TenueMenu")
			TriggerServerEvent("GTA:GetHautJoueur")
		elseif btn == "Retirer votre haut" then
			isHautRetirer = not isHautRetirer
			TriggerEvent("GTA:TenueMenu")
			TriggerEvent("GTA:RetirerHautJoueur")
		elseif btn == "Mettre votre bas" then 
			isBasRetirer = not isBasRetirer
			TriggerEvent("GTA:TenueMenu")
			TriggerServerEvent("GTA:GetBasJoueur")
		elseif btn == "Retirer votre bas" then 
			isBasRetirer = not isBasRetirer
			TriggerEvent("GTA:TenueMenu")
			TriggerEvent("GTA:RetirerBasJoueur")
		elseif btn == "Mettre vos chaussures" then
			isChaussureRetirer = not isChaussureRetirer
			TriggerEvent("GTA:TenueMenu")
			TriggerServerEvent("GTA:GetChaussureJoueur")
		elseif btn == "Retirer vos chaussures" then 
			isChaussureRetirer = not isChaussureRetirer
			TriggerEvent("GTA:TenueMenu")
			TriggerEvent("GTA:RetirerChaussureJoueur")
		elseif btn == "Mettre votre bonnet" then
			isChapeauRetirer = not isChapeauRetirer
			TriggerEvent("GTA:TenueMenu")
			TriggerServerEvent("GTA:GetBonnetJoueur")
		elseif btn == "Retirer votre bonnet" then
			isChapeauRetirer = not isChapeauRetirer
			TriggerEvent("GTA:TenueMenu")
			TriggerEvent("GTA:RetirerBonnetJoueur")
		end
	elseif this == "ItemUtilisable" then --> Sous menu Inventaire (Item Utilisable)
		if btn == "utiliser" then
			OpenMenu("Inventaire")
			use(itemIDSelected,1)
			exports.nCoreGTA:nNotificationMain({
			text = "~h~Vous avez utilisé ~b~x1 ~g~"..itemName,
			type = 'basGauche',
			nTimeNotif = 1000,
		})
		elseif btn == "donner" then
			local ClosestPlayerSID = GetPlayerServerId(GetClosestPlayer())
			if ClosestPlayerSID ~= 0 then
				local result = KeyboardInput("Somme d'item à donner :", "", 4)
				total_items = tonumber(result)

				if tonumber(total_items) == nil then
					exports.nCoreGTA:nNotificationMain({
						text = "Veuillez inserer un nombre correct !",
						type = 'basGauche',
						nTimeNotif = 1000,
					})
					return nil
				end

				if tonumber(itemQty) >= tonumber(total_items) and tonumber(total_items) > 0 then
					OpenMenu("Inventaire")
					TriggerServerEvent('player:giveItem',ClosestPlayerSID,itemIDSelected,itemName,tonumber(total_items))
				else
					exports.nCoreGTA:nNotificationMain({
						text = "~r~Vous n'avez pas assez d'items.",
						type = 'basGauche',
						nTimeNotif = 1000,
					})
				end
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
			end

		elseif btn == "jeter" then
			local result = KeyboardInput("Somme d'item à jeter :", "", 4)

			if tonumber(result) == nil then
				exports.nCoreGTA:nNotificationMain({
					text = "Veuillez inserer un nombre correct !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
				return nil
			end

			if tonumber(itemQty) >= tonumber(result) and tonumber(result) > 0 then
				OpenMenu("Inventaire")
				TriggerEvent('player:looseItem',itemIDSelected,tonumber(result))

				exports.nCoreGTA:nNotificationMain({
					text = "~h~Vous avez ~r~jeter ~b~ x".. tonumber(result) .. " "..itemName,
					type = 'basGauche',
					nTimeNotif = 1000,
				})
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~r~Vous n'avez pas tout ça sur vous d'items.",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
			end
		end
	elseif this == "ItemNonUtilisable" then --> Sous menu Inventaire (Item Non-Utilisable)
		if btn == "donner" then
			local ClosestPlayerSID = GetPlayerServerId(GetClosestPlayer())
			if ClosestPlayerSID ~= 0 then
				local result = KeyboardInput("Somme d'item à donner :", "", 4)
				total_items = tonumber(result)


				if tonumber(total_items) == nil then
					exports.nCoreGTA:nNotificationMain({
						text = "Veuillez inserer un nombre correct !",
						type = 'basGauche',
						nTimeNotif = 1000,
					})
					return nil
				end

				if tonumber(itemQty) >= tonumber(total_items) and tonumber(total_items) > 0 then
					OpenMenu("Inventaire")
					TriggerServerEvent('player:giveItem',ClosestPlayerSID,itemIDSelected,itemName,tonumber(total_items))
				else
					exports.nCoreGTA:nNotificationMain({
						text = "~r~Vous n'avez pas assez d'items.",
						type = 'basGauche',
						nTimeNotif = 1000,
					})
				end
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
			end

		elseif btn == "jeter" then
			OpenMenu("Inventaire")
			local result = KeyboardInput("Somme d'item à jeter :", "", 4)

			if tonumber(result) == nil then
				exports.nCoreGTA:nNotificationMain({
					text = "Veuillez inserer un nombre correct !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
				return nil
			end
			if tonumber(itemQty) >= tonumber(result) and tonumber(result) > 0 then
				OpenMenu("Inventaire")
				TriggerEvent('player:looseItem',itemIDSelected,tonumber(result))

				exports.nCoreGTA:nNotificationMain({
					text = "~h~Vous avez ~r~jeter ~b~ x".. tonumber(result) .. " "..itemName,
					type = 'basGauche',
					nTimeNotif = 1000,
				})
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~r~Vous n'avez pas tout ça sur vous d'items.",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
			end
		end
	elseif this == "Mon Portefeuille" then
		if btn == "Donner de ~g~l'argent propre" then
			local ClosestPlayerSID = GetPlayerServerId(GetClosestPlayer())
			if ClosestPlayerSID ~= 0 then
				local result = KeyboardInput("Somme à donner :", "", 4)
				total_items = tonumber(result)

				if tonumber(total_items) == nil then
					exports.nCoreGTA:nNotificationMain({
						text = "Veuillez inserer un nombre correct !",
						type = 'basGauche',
						nTimeNotif = 1000,
					})
					return nil
				end
				CloseMainMenu()
				TriggerServerEvent("nArgent:DonnerArgentPropre", ClosestPlayerSID, tonumber(total_items)) --A TESTER
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
				CloseMainMenu()
			end
		elseif btn == "Donner de ~r~l'argent sale" then
			local ClosestPlayerSID = GetPlayerServerId(GetClosestPlayer())
			if ClosestPlayerSID ~= 0 then
				local result = KeyboardInput("Somme à donner :", "", 4)
				total_items = tonumber(result)

				if tonumber(total_items) == nil then
					exports.nCoreGTA:nNotificationMain({
						text = "Veuillez inserer un nombre correct !",
						type = 'basGauche',
						nTimeNotif = 1000,
					})
					return nil
				end

				CloseMainMenu()
				TriggerServerEvent("GTA:DonnerArgentSale", ClosestPlayerSID, tonumber(total_items)) --A TESTER
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
				CloseMainMenu()
			end
		elseif btn == "Regarder son portefeuille" then
			TriggerServerEvent("GTA:RegardeSonArgent")
			CloseMainMenu()
		end
	elseif this == "Mon Identité" then
		if btn == "Regarder son identité" then
			CloseMainMenu()
			TriggerServerEvent("GTA:ChercherSonIdentiter")
		elseif btn == "Montrer son identité"then
			local ClosestPlayerSID = GetPlayerServerId(GetClosestPlayer())
			if ClosestPlayerSID ~= 0 then
				CloseMainMenu()
				TriggerServerEvent("GTA:MontrerSonIdentiter", ClosestPlayerSID)
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
				CloseMainMenu()
			end
		end
	elseif this == "Hud" then
		if btn == "Afficher/Cacher Faim/Soif" then
			TriggerEvent("EnableDisableHUDFS")
			CloseMainMenu()
		end
	end 
end

function Back() --> Option Retour
	if menuPerso.currentmenu == "main" then
		CloseMainMenu()
	elseif menuPerso.currentmenu == "Inventaire" then
		OpenMenu("main")
	elseif menuPerso.currentmenu == "Tenue" then
		OpenMenu("main")
	elseif menuPerso.currentmenu == "Mon Portefeuille" then
		OpenMenu("main")
	elseif menuPerso.currentmenu == "ItemUtilisable" then
		OpenMenu("main")
	elseif menuPerso.currentmenu == "ItemNonUtilisable" then
		OpenMenu("main")
	elseif menuPerso.currentmenu == "Mon Identité" then
		OpenMenu("main")
	elseif menuPerso.currentmenu == "Hud" then
		OpenMenu("main")
	elseif menuPerso.currentmenu == "Action Medic" then
		OpenMenu("main") --> Retour au menu Action Police
	end
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end


function table.HasValue( t, val )
	for k, v in pairs( t ) do
		if ( v == val ) then return true end
	end
	return false
end

--> Check si la carte d'identié est ouvert, on la ferme aprés 20 seconde :
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if active then
			RenderCarte()
		elseif Cashactive then
			RenderMoneyCarte()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if active then
			Wait(5000) --Permet l'affichage pendant 20 secondes
			active = false
		elseif Cashactive then
			Wait(5000) --Permet l'affichage pendant 20 secondes
			Cashactive = false
		end
	end
end)