--||@SuperCoolNinja.||--

-->Variable :
local menuConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'configuration_jobs/json/ConfigMenu.json')) --> Give the access to change the colours font for users.
local scaleform = nil
local menuMainMedic = {}

--> MENU :
local menuMedic = {
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
			title = "Menu Medic",
			name = "main",
			buttons = menuMainMedic
		},

        ["civilMenu"] = { 
            title = "Intéraction Citoyen",
            name = "civilMenu",
            buttons = {
                {name = "Soigner", action = "healhCivil"},
                {name = "Réanimer", action = "reviveCivil"},
                {name = "Facture", action = "factureCivil"},
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
                {name = "Rétrograder en Stagiaire", action = "RetroTarget", grade = "Stagiaire"},
            }
        },

        ["subPromou"] = { 
            title = "~r~Gestion ~b~Grade",
            name = "subPromou",
            buttons = {
                {name = "Promouvoir en medecin", action = "promouMedecin", grade = "Medecin"},
            }
        },

        ["gestEmployer"] = { 
            title = "~r~Gestion ~b~Employé",
            name = "gestEmployer",
            buttons = {
                {name = "Recruter", action = "recruter"},
                {name = "Virer", action = "virer"},
            }
        },

        ["Factures"] = {
            title = "Factures",
            name = "Factures",
            buttons = {
                {name = "Factures non prédéfinis", action = "payerFactures"},
            }
        },
  	}
}

RegisterNetEvent("GTA_Medic:MenuMedic")
AddEventHandler("GTA_Medic:MenuMedic", function()
	for k, v in pairs(menuMainMedic) do
		menuMainMedic[k] = nil
	end

    if config.Grade == "Medecin" then
        table.insert(menuMainMedic, {name = "~r~Gestion ~b~Grade", action = "gGrade"})
        table.insert(menuMainMedic, {name = "~r~Gestion ~br~Employé", action = "gEmployer"})
        table.insert(menuMainMedic, {name = "---------------------------------------------------------"})
    end

    table.insert(menuMainMedic, {name = "Intéraction~g~ Citoyen", action = "interC"})
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
    local menu = menuMedic.menu
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

local function drawMenuButton(button,x,y,selected)
    local menu = menuMedic.menu
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
	menuMedic.lastmenu = menuMedic.currentmenu
	menuMedic.menu.from = 1
	menuMedic.menu.to = 10
	menuMedic.selectedbutton = 1
	menuMedic.currentmenu = menu
end


 ---> This is used to close the menu
local function CloseMenu()
    Citizen.CreateThread(function()
        menuMedic.opened = false
        menuMedic.menu.from = 1
        menuMedic.menu.to = 10
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
    
    menuMedic.currentmenu = "main"
    menuMedic.opened = true
    menuMedic.selectedbutton = 1
end

--> [menuMedic.currentmenu] = actual menu.
local function Back() 
	if menuMedic.currentmenu == "main" then 
        CloseMenu()
    else
        OpenMainMenu()
	end
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
            if config.Job == "Medic" then
                if not menuMedic.opened then
                    TriggerEvent("GTA_Medic:MenuMedic")
                    Wait(125)
                    OpenMainMenu()
                end
            end
        end

        if menuMedic.opened then
            afficherMarkerTarget()--> affiche le marker en dessous du target le ou les plus proches.

            --> DISABLE THE PUNCH BUTTON B TO NOT HAVE CONFLIT WITH GAMEPLAY LIKE PUNCHING WHEN PRESSING B WHILE THE MENU IS OPEN :
            DisableControlAction(0, 140, true) 

            local menu = menuMedic.menu[menuMedic.currentmenu]
            drawMenuTitle(menu.title, menuMedic.menu.x,menuMedic.menu.y + 0.08)
            local y = menuMedic.menu.y + 0.12
            buttoncount = tablelength(menu.buttons)
            local selected = false
            for i,button in pairs(menu.buttons) do
                if i >= menuMedic.menu.from and i <= menuMedic.menu.to then
                    if i == menuMedic.selectedbutton then
                        selected = true
                    else
                        selected = false
                    end
                    
                drawMenuButton(button,menuMedic.menu.x,y + 0.02 + 0.003,selected)
                y = y + 0.04
                    if selected and IsControlJustPressed(1,201) then
                        PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
                        gestionMedicAction(button)
                    end
                end
            end
        end

        if menuMedic.opened then
            --> Check if the SUPR button is pressed : 
            if IsControlJustPressed(1,202) then 
                Back()
            end
            
            --> Check if the UP button is pressed : 
            if IsControlJustPressed(1,188) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                if menuMedic.selectedbutton > 1 then
                    menuMedic.selectedbutton = menuMedic.selectedbutton -1
                    if buttoncount > 10 and menuMedic.selectedbutton < menuMedic.menu.from then
                        menuMedic.menu.from = menuMedic.menu.from -1
                        menuMedic.menu.to = menuMedic.menu.to - 1
                    end
                end
            end
            
            --> Check if the DOWN button is pressed : 
            if IsControlJustPressed(1,187)then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                if menuMedic.selectedbutton < buttoncount then
                    menuMedic.selectedbutton = menuMedic.selectedbutton +1
                    if buttoncount > 10 and menuMedic.selectedbutton > menuMedic.menu.to then
                        menuMedic.menu.to = menuMedic.menu.to + 1
                        menuMedic.menu.from = menuMedic.menu.from + 1
                    end
                end
            end
        end
    end
end)


--> Controls of Action menu/subMenu... :
function gestionMedicAction(button)
    local this = menuMedic.currentmenu
	local btnAction = button.action

    if this == "main" then
        if btnAction == "interC" then 
            OpenMenu("civilMenu")
        elseif btnAction == "gGrade" then
            OpenMenu("gestGrade")
        elseif btnAction == "gEmployer" then
            OpenMenu("gestEmployer")
        end
    elseif this == "civilMenu" then
        if btnAction == "healhCivil" then 
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                Citizen.Wait(8000)
                ClearPedTasks(GetPlayerPed(-1));
                TriggerServerEvent('GTA_Medic:SoignerTarget',target)
                exports.nCoreGTA:nNotificationMain({
                    text =  "~h~Vous avez soigné une personne.",
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
    elseif btnAction == "reviveCivil" then
        if(exports.nMenuPersonnel:getQuantity(17) > 0) then
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent('GTA_Medic:ReanimerTarget', target)
            else
                exports.nCoreGTA:nNotificationMain({
                    text = "~y~ Aucune personne devant vous !",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
            end
        else
            exports.nCoreGTA:nNotificationMain({
                text = "~r~ Il vous faut une seringue d'adrénaline !",
                type = 'basGauche',
                nTimeNotif = 6000,
            })
        end
    elseif btnAction == "factureCivil" then
            OpenMenu("Factures")
        end
    elseif this == "Factures" then
        if btnAction == "payerFactures" then
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                local montant = InputNombre("Montant :")
                local raison = InputText()

                if tonumber(montant) == nil then
                    exports.nCoreGTA:nNotificationMain({
                        text = "Veuillez inserer un nombre correct !",
                        type = 'basGauche',
                        nTimeNotif = 1000,
                    })
                    return nil
                end
    
                TriggerServerEvent("GTA_Medic:Demander_AutorisationFacture", target, montant, raison)
                
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
    elseif this == "gestGrade" then 
        if btnAction == "retro" then 
            OpenMenu("subRetro")
        elseif btnAction == "promou" then
            OpenMenu("subPromou")
        end
    elseif this == "subRetro" then 
        if btnAction == "RetroTarget" then
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
        if btnAction == "promouMedecin" then
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
        if btnAction == "recruter" then
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent("GTA_Medic:RecruterIndividu", target)
            else
                exports.nCoreGTA:nNotificationMain({
                    text = "~y~ Aucune personne devant vous !",
                    type = 'basGauche',
                    nTimeNotif = 1000,
                })
            end
        elseif btnAction == "virer" then 
            local target = GetPlayerServerId(GetClosestPlayer())
            if target ~= 0 then
                TriggerServerEvent("GTA_Medic:VirerIndividu", target)
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