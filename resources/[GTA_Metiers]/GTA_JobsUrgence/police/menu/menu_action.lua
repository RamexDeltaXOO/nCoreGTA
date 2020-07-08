--||@SuperCoolNinja.||--

-->Variable :
local menuConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'configuration_jobs/json/ConfigMenu.json')) --> Give the access to change the colours font for users.
local scaleform = nil
local menuMainPolice = {}
local inventory_suspect = {}

--> MENU :
local menuPolice = {
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
		scale = 0.3 + 0.05,
		font = 0,
		["main"] = { 
			title = "Menu Police",
			name = "main",
			buttons = menuMainPolice
		},

        ["civilMenu"] = { 
            title = "Intéraction Citoyen",
            name = "civilMenu",
            buttons = {
                {name = "Menotter/Démenotter", action = "mdCivil"},
                {name = "Demander Identité", action = "demanderIdent"},
                {name = "Prendre l'identité de force", action = "demanderIdentforce"},
                {name = "Mettre le suspect dans le véhicule", action = "civilInVeh"},
                {name = "Fouiller le suspect", action = "fouiller"},
                {name = "Mettre une amende", action = "amendeJoueur"},
            }
        },

        ["vehMenu"] = { 
            title = "Intéraction Véhicule",
            name = "vehMenu",
            buttons = {
                {name = "Crocheter", action = "crocheterVeh"},
                {name = "Vérifier la plaque", action = "checkPlaque"},
            }
        },

        ["gestGrade"] = { 
            title = "~r~Gestion ~b~Grade",
            name = "gestGrade",
            buttons = {
                {name = "~r~Rétrograder", action = "retro"},
                {name = "~g~Promouvoir", action = "promou"},
            }
        },

        ["subRetro"] = { 
            title = "~r~Gestion ~b~Grade",
            name = "subRetro",
            buttons = {
                {name = "Rétrograder en Cadet", action = "retroCadet", grade = "Cadet"},
                {name = "Rétrograder en Sergent", action = "retroSergent", grade = "Sergent"},
                {name = "Rétrograder en SergentChef", action = "retroSergentChef", grade = "SergentChef"},
                {name = "Rétrograder en Lieutenant", action = "retroLieutenant", grade = "Lieutenant"},
            }
        },

        ["subPromou"] = { 
            title = "~r~Gestion ~b~Grade",
            name = "subPromou",
            buttons = {
                {name = "Promouvoir en sergent", action = "promouSergent", grade = "Sergent"},
                {name = "Promouvoir en SergentChef", action = "promouSergentChef", grade = "SergentChef"},
                {name = "Promouvoir en Lieutenant", action = "promouLieutenant", grade = "Lieutenant"},
                {name = "Promouvoir en Capitaine", action = "promouCapitaine", grade = "Capitaine"},
            }
        },

        ["gestEmployer"] = { 
            title = "~r~Gestion ~b~Employé",
            name = "gestEmployer",
            buttons = {
                {name = "Recruter", action = "recruterPolice"},
                {name = "Virer", action = "virerPolice"},
            }
        },

        ["InventaireSuspect"] = { --> Menu Inventaire.
            title = "Inventaire du suspect" ,
            name = "InventaireSuspect",
            buttons = inventory_suspect
        },

		["InventaireSuspectChoix"] = { --> Menu Identité
			title = "Inventaire du suspect",
			name = "InventaireSuspectChoix",
			buttons = {
				{name = "~r~Confisqué", action = "confisqué"},
			}
        },
        
        ["Amende"] = {
            title = "Amende",
            name = "Amende",
            buttons = {
                {name = "Amende non prédéfinis", action = "payerAmendes"},
                {name = "Rappel à la loi simple", action = "amende1", prix = 150, raison = "Rappel à la loi simple"},
                {name = "Rappel à la loi grave", action = "amende2",prix = 350, raison = "Rappel à la loi grave"},
                {name = "Insulte à agent", action = "amende3",prix = 300, raison = "Insulte à agent"},
                {name = "Conduite sans permis", action = "amende3",prix = 5000, raison = "Conduite sans permis"},
                {name = "Vol de véhicule", action = "amende4",prix = 6500, raison = "Vol de véhicule"},
                {name = "Coups et blessures", action = "amende5",prix = 250, raison = "Coups et blessures"},
                {name = "Port d'arme sans permis", action = "amende6",prix = 17000, raison = "Port d'arme sans permis"},
                {name = "Agression à main armée", action = "amende7",prix = 12500, raison = "Agression à main armée"},
                {name = "Tentative de vol à main armée", action = "amende8",prix =  3000, raison = "Tentative de vol à main armée"},
                {name = "Délit de fuite", action = "amende9",prix = 1500, raison = "Délit de fuite"},
                {name = "Vol à main armée", action = "amende10",prix =  19000, raison = "Vol à main armée"},
                {name = "Tentative de meurtre", action = "amende11",prix =  30000, raison = "Tentative de meurtre"},
                {name = "Homicide volontaire", action = "amende12",prix =  55000, raison = "Homicide volontaire"},
                {name = "Transport de substance illégale", action = "amende13",prix = 25000, raison = "Transport de substance illégale"},
            }
        },
  	}
}


RegisterNetEvent("GTA_Police:MenuPolice")
AddEventHandler("GTA_Police:MenuPolice", function()
	for k, v in pairs(menuMainPolice) do
		menuMainPolice[k] = nil
	end

    if config.Grade == "Capitaine" then
        table.insert(menuMainPolice, {name = "~r~Gestion ~b~Grade", action = "gGrade"})
        table.insert(menuMainPolice, {name = "~r~Gestion ~br~Employé", action = "gEmployer"})
        table.insert(menuMainPolice, {name = "---------------------------------------------------------"})
    end

    table.insert(menuMainPolice, {name = "Intéraction~g~ Citoyen", action = "interC"})
    table.insert(menuMainPolice, {name = "Intéraction~g~ Véhicule", action = "interV"})
end)

RegisterNetEvent("GTA_Police:OuvrirInventaireSuspect")
AddEventHandler("GTA_Police:OuvrirInventaireSuspect", function()
	for k,v in pairs(inventory_suspect) do
		inventory_suspect[k] = nil
  	end
  
	for k, v in pairs(ITEMS) do
		if (v.quantity > 0) then
			table.insert(inventory_suspect, {name = tostring(v.libelle).. " "..tonumber(round(v.quantity)), itemType = tostring(v.type), itemName = tostring(v.libelle), iteamNameSelected = tostring(k), itemqty = tonumber(round(v.quantity))})
		end
    end
end)


local function DrawTextMenu(fonteP, stringT, scale, posX, posY)
    SetTextFont(fonteP)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(stringT)
    DrawText(posX, posY)
end
 
local function drawMenuTitle(txt,x,y)
    local menu = menuPolice.menu
    SetTextFont(0)
    SetTextScale(0.4 + 0.008, 0.4 + 0.008)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString(txt)
    DrawRect(x,y,menu.width,menu.height + 0.04 + 0.007, 0, 0, 0, 0)
    DrawTextMenu(1, txt, 0.8,menu.width - 0.4 / 2 + 0.1 + 0.005, y - menu.height/2 + 0.01, 255, 255, 255)
    DrawSprite("background", "interaction_bgd", x,y, menu.width,menu.height + 0.04 + 0.007, .0, 255, 255, 255, 255)
    DrawScaleformMovie(scaleform, 0.42 + 0.003,0.45, 0.9,0.9)
end

local function drawMenuRight(txt,x,y,selected)
	local menu = menuPolice.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawTextMenu(0, txt, 0.4, menu.width - 0.4 / 2 + 0.1 + 0.09, y - menu.height/2 + 0.03 + 0.003, 255, 255, 255)
end

local function drawMenuButton(button,x,y,selected)
    local menu = menuPolice.menu
    SetTextFont(menu.font)
    SetTextProportional(0)
    SetTextScale(menu.scale, menu.scale)
    SetTextCentre(0)
    SetTextEntry("STRING")
    AddTextComponentString(button.name)

    for i=1, #menuConfig do 
        if selected then
            SetTextColour(menuConfig[i].colorTextSelectMenu.r, menuConfig[i].colorTextSelectMenu.g, menuConfig[i].colorTextSelectMenu.b, menuConfig[i].colorTextSelectMenu.a)
        else
            SetTextColour(menuConfig[i].colorTextMenu.r, menuConfig[i].colorTextMenu.g, menuConfig[i].colorTextMenu.b, menuConfig[i].colorTextMenu.a)
        end

        if selected then
            DrawRect(x,y,menu.width,menu.height,menuConfig[i].colorRectSelectMenu.r,menuConfig[i].colorRectSelectMenu.g,menuConfig[i].colorRectSelectMenu.b,menuConfig[i].colorRectSelectMenu.a)
        else
            DrawRect(x,y,menu.width,menu.height,0,0,0,150)
        end
    end
    DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

 ---> this is used to open an menu wanted : 
 local function OpenMenu(menu)
	menuPolice.lastmenu = menuPolice.currentmenu
	menuPolice.menu.from = 1
	menuPolice.menu.to = 10
	menuPolice.selectedbutton = 1
	menuPolice.currentmenu = menu
end


 ---> This is used to close the menu
local function CloseMenu()
    local target = GetPlayerServerId(GetClosestPlayer())
    if target ~= 0 then
        TriggerServerEvent("item:getItemsTarget", target)
    end

    Citizen.CreateThread(function()
        menuPolice.opened = false
        menuPolice.menu.from = 1
        menuPolice.menu.to = 10
    end)
end

--> This is used to open the main menu :
local function OpenMainMenu()
    if not HasStreamedTextureDictLoaded("background") then
        RequestStreamedTextureDict("background", true)
    end

    scaleform = RequestScaleformMovie("mp_menu_glare")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "initScreenLayout")
    PopScaleformMovieFunctionVoid()
    
    menuPolice.currentmenu = "main"
    menuPolice.opened = true
    menuPolice.selectedbutton = 1
end


--> [menuPolice.currentmenu] = actual menu.
local function Back() 
	if menuPolice.currentmenu == "main" then 
        CloseMenu()
    else
        OpenMainMenu()
	end
end




local function CloseAndRefreshMenu(open_menu)
    CloseMenu()
    print(targetPerso)
    Wait(150)

    local target = GetPlayerServerId(GetClosestPlayer())
    if target ~= 0 then
        TriggerServerEvent("item:getItemsTarget", target)
    end

	menuPolice.opened = true
	menuPolice.currentmenu = open_menu
	menuPolice.selectedbutton = 1
end

----------------------------> [CONTROLS] :
local backlock = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

    --> Control pour ouvrir le menu F6 :
    if IsControlJustReleased(0, 167) then
            TriggerServerEvent("GTA:LoadJobsJoueur")
            Wait(100)
            if config.Job == "Police" then
                if not menuPolice.opened then --> Check if the menu is not open then we do open.
                    TriggerEvent("GTA_Police:MenuPolice")
                    Wait(150)
                    OpenMainMenu()
                end
            end
        end

        if menuPolice.opened then
            afficherMarkerTarget()--> affiche le marker en dessous du target le ou les plus proches.

            --> DISABLE THE PUNCH BUTTON B TO NOT HAVE CONFLIT WITH GAMEPLAY LIKE PUNCHING WHEN PRESSING B WHILE THE MENU IS OPEN :
            DisableControlAction(0, 140, true) 

            local menu = menuPolice.menu[menuPolice.currentmenu]
            drawMenuTitle(menu.title, menuPolice.menu.x,menuPolice.menu.y + 0.08)
            local y = menuPolice.menu.y + 0.12
            buttoncount = tablelength(menu.buttons)
            local selected = false
            for i,button in pairs(menu.buttons) do
                if i >= menuPolice.menu.from and i <= menuPolice.menu.to then
                    if i == menuPolice.selectedbutton then
                        selected = true
                    else
                        selected = false
                    end
                    
                    if button.prix ~= nil then
                        drawMenuRight("~g~"..button.prix.."$",menuPolice.menu.x,y,selected)
                    end
                    
                drawMenuButton(button,menuPolice.menu.x,y + 0.02 + 0.003,selected)
                y = y + 0.04
                    if selected and IsControlJustPressed(1,201) then
                        PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
                        gestionPoliceAction(button)
                    end
                end
            end
        end

        if menuPolice.opened then
            --> Check if the SUPR button is pressed : 
            if IsControlJustPressed(1,202) then 
                Back()
            end
            
            --> Check if the UP button is pressed : 
            if IsControlJustPressed(1,188) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                if menuPolice.selectedbutton > 1 then
                    menuPolice.selectedbutton = menuPolice.selectedbutton -1
                    if buttoncount > 10 and menuPolice.selectedbutton < menuPolice.menu.from then
                        menuPolice.menu.from = menuPolice.menu.from -1
                        menuPolice.menu.to = menuPolice.menu.to - 1
                    end
                end
            end
            
            --> Check if the DOWN button is pressed : 
            if IsControlJustPressed(1,187)then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                if menuPolice.selectedbutton < buttoncount then
                    menuPolice.selectedbutton = menuPolice.selectedbutton +1
                    if buttoncount > 10 and menuPolice.selectedbutton > menuPolice.menu.to then
                        menuPolice.menu.to = menuPolice.menu.to + 1
                        menuPolice.menu.from = menuPolice.menu.from + 1
                    end
                end
            end
        end
    end
end)


local itemSelected = 0
local itemsSelected = ""
local itemQty = 0
local itemName = ""
local targetPerso = nil

--> Controls of Action menu/subMenu... :
function gestionPoliceAction(button)
    local this = menuPolice.currentmenu
	local btnAction = button.action
    local btnTypeItem = button.itemType
    
    if this == "main" then
        if btnAction == "interC" then 
            OpenMenu("civilMenu")
        elseif btnAction == "interV" then 
            OpenMenu("vehMenu") 
        elseif btnAction == "gGrade" then
            OpenMenu("gestGrade")
        elseif btnAction == "gEmployer" then
            OpenMenu("gestEmployer")
        end
    elseif this == "civilMenu" then 
        if btnAction == "mdCivil" then 
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                if (exports.nMenuPersonnel:getQuantity(7) > 0) then
                    TriggerServerEvent('GTA_Police:Menotter_DemenotterServer', target)
                else
                    exports.nCoreGTA:nNotificationMain({
                        text = "~r~ Vous n'avez pas de menotte sur vous !",
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
        elseif btnAction == "demanderIdent" then
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent("GTA_Police:Demander_IdentiterServer", target)
                exports.nCoreGTA:nNotificationMain({
                    text = "~b~Vous demander a l'individu son identité",
                    type = 'basGauche',
                    nTimeNotif = 6000,
                })
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        elseif btnAction == "demanderIdentforce" then
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent("GTA_Police:Regarder_IdentiterServer", target)
                exports.nCoreGTA:nNotificationMain({
                    text = "~b~Vous regarder l'identité de l'individu",
                    type = 'basGauche',
                    nTimeNotif = 6000,
                })
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        elseif btnAction == "civilInVeh" then 
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                local v = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                TriggerServerEvent("GTA_Police:MettreJoueurVehicule", target, v)
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        elseif btnAction == "fouiller" then 
            targetPerso = GetPlayerServerId(GetClosestPlayer())
            TriggerServerEvent("item:getItemsTarget", targetPerso)
            if target ~= 0 then
                TriggerServerEvent("GTA_Police:Demander_FouillerIndividu", targetPerso)
                exports.nCoreGTA:nNotificationMain({
                    text = "~b~Vous demander une autorisation a l'individu pour le fouiller.",
                    type = 'basGauche',
                    nTimeNotif = 6000,
                })
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        elseif btnAction == "amendeJoueur" then 
            OpenMenu("Amende")
        end
    elseif this == "InventaireSuspect" then 
        if tonumber(btnTypeItem) == 1 or 2 or 3 then
            OpenMenu('InventaireSuspectChoix')
            itemSelected = button.itemType
			itemName = button.itemName
			itemsSelected = button.iteamNameSelected
			itemQty = button.itemqty
        end
    elseif this == "InventaireSuspectChoix" then 
        if btnAction == "confisqué" then 
            local result = InputNombre("Nombre d'item a confisqué : ")

			if tonumber(result) == nil then
				exports.nCoreGTA:nNotificationMain({
					text = "Veuillez inserer un nombre correct !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
				return nil
            end
            
            if tonumber(itemQty) >= tonumber(result) and tonumber(result) > 0 then
                TriggerServerEvent('item:supprimerItemTarget',targetPerso, itemsSelected,tonumber(result), itemName)
                CloseAndRefreshMenu("InventaireSuspect")
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~r~Vous n'avez pas tout ça sur vous d'items.",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        end
    --------------------------------------------------------------------------------------------------
    -----------------AMENDE:----------------->
    --------------------------------------------------------------------------------------------------
    elseif this == "Amende" then 
        if btnAction == "payerAmendes" then
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                local montant = InputText()
                local raison = InputNombre("Montant :")
    
                if tonumber(montant) == nil then
                    exports.nCoreGTA:nNotificationMain({
                        text = "Veuillez inserer un nombre correct !",
                        type = 'basGauche',
                        nTimeNotif = 1000,
                    })
                    return nil
                end
    
                TriggerServerEvent("GTA_Police:Demander_AutorisationAmende", target, montant, raison)
                
                exports.nCoreGTA:nNotificationMain({
					text = "~w~ Une requete à été envoyé !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        else
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent("GTA_Police:Demander_AutorisationAmende", target, button.prix, button.raison)
                exports.nCoreGTA:nNotificationMain({
					text = "~w~ Une requete à été envoyé !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        end
        --------------------------------------------------------------------------------------------------
        -----------------INTERACTION VEHICULE:----------------->
        --------------------------------------------------------------------------------------------------
    elseif this == "vehMenu" then 
        if btnAction == "crocheterVeh" then 
            TriggerEvent("GTA_Police:CrocheterVehicule")
        elseif btnAction == "checkPlaque" then
            TriggerEvent("GTA_Police:CheckPlaqueImatricule")
        end

        --------------------------------------------------------------------------------------------------
    -----------------INTERACTION GESTION GRADE:----------------->
    --------------------------------------------------------------------------------------------------
    elseif this == "gestGrade" then 
        if btnAction == "retro" then 
            OpenMenu("subRetro")
        elseif btnAction == "promou" then
            OpenMenu("subPromou")
        end
    elseif this == "subRetro" then 
        if btnAction == "RetroTarget" then
        else
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent("GTA:RetroTarget", target, button.grade)
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        end
    elseif this == "subPromou" then
        if btnAction == "Promouvoir" then 
        else
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent("GTA:PromouvoirTarget", target, button.grade)
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        end
    elseif this == "gestEmployer" then 
        if btnAction == "recruterPolice" then 
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent("GTA_Police:RecruterIndividu", target)
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        elseif btnAction == "virerPolice" then 
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent("GTA_Police:VirerIndividu", target)
			else
				exports.nCoreGTA:nNotificationMain({
					text = "~y~ Aucune personne devant vous !",
					type = 'basGauche',
					nTimeNotif = 1000,
				})
            end
        end
	end
end

RegisterNetEvent("GTA_Police:OuvrirInventaireTarget")
AddEventHandler("GTA_Police:OuvrirInventaireTarget", function()
    OpenMenu("InventaireSuspect")
end)
 
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

function tablelength(T)
    local count = 0
    for _ in pairs(T) do 
        count = count + 1 
    end
    return count
end