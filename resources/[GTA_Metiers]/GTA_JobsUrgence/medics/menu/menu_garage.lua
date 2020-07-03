--||@SuperCoolNinja.||--

-->Variable :
local menuConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'configuration_jobs/json/ConfigMenu.json')) --> Give the access to change the colours font for users.
local scaleform = nil

--> MENU :
local menuMedicGarage = {
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
            title = "Garage Medic",
            name = "main",
            buttons = {
                {name = "Ambulance", action = "sortirAmbu", model_vehicule = "Ambulance"},
            }
        },
  	}
}

 ---> This is used to close the menu
local function CloseMenu()
    Citizen.CreateThread(function()
        menuMedicGarage.opened = false
        menuMedicGarage.menu.from = 1
        menuMedicGarage.menu.to = 10
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
    
    menuMedicGarage.currentmenu = "main"
    menuMedicGarage.opened = true
    menuMedicGarage.selectedbutton = 1
end

--> [menuMedicGarage.currentmenu] = actual menu.
local function Back() 
	if menuMedicGarage.currentmenu == "main" then 
        CloseMenu()
    else
        OpenMainMenu()
	end
end

 ---> this is used to open an menu wanted : 
local function OpenMenu(menu)
	menuMedicGarage.lastmenu = menuMedicGarage.currentmenu
	menuMedicGarage.menu.from = 1
	menuMedicGarage.menu.to = 10
	menuMedicGarage.selectedbutton = 1
	menuMedicGarage.currentmenu = menu
end

local function drawMenuButton(button,x,y,selected)
    local menu = menuMedicGarage.menu
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
    local menu = menuMedicGarage.menu
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

local backlock = false
RegisterNetEvent("GTA_Medic:OuvrirGarageMenu")
AddEventHandler("GTA_Medic:OuvrirGarageMenu", function()
    if not menuMedicGarage.opened then
        OpenMainMenu()
    end
end)

----------------------------> [CONTROLS] :
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if menuMedicGarage.opened then
            --> DISABLE THE PUNCH BUTTON B TO NOT HAVE CONFLIT WITH GAMEPLAY LIKE PUNCHING WHEN PRESSING B WHILE THE MENU IS OPEN :
            DisableControlAction(0, 140, true) 

            local menu = menuMedicGarage.menu[menuMedicGarage.currentmenu]
            drawMenuTitle(menu.title, menuMedicGarage.menu.x,menuMedicGarage.menu.y + 0.08)
            local y = menuMedicGarage.menu.y + 0.12
            buttoncount = tablelength(menu.buttons)
            local selected = false
            for i,button in pairs(menu.buttons) do
                if i >= menuMedicGarage.menu.from and i <= menuMedicGarage.menu.to then
                    if i == menuMedicGarage.selectedbutton then
                        selected = true
                    else
                        selected = false
                    end
                    
                drawMenuButton(button,menuMedicGarage.menu.x,y + 0.02 + 0.003,selected)
                y = y + 0.04
                    if selected and IsControlJustPressed(1,201) then
                        PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
                        GestionGarageMedic(button)
                    end
                end
            end
        end

        if menuMedicGarage.opened then
            --> Check if the Back button is pressed : 
            if IsControlJustPressed(1,202) then 
                Back()
            end
            
            --> Check if the UP button is pressed : 
            if IsControlJustPressed(1,188) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                if menuMedicGarage.selectedbutton > 1 then
                    menuMedicGarage.selectedbutton = menuMedicGarage.selectedbutton -1
                    if buttoncount > 10 and menuMedicGarage.selectedbutton < menuMedicGarage.menu.from then
                        menuMedicGarage.menu.from = menuMedicGarage.menu.from -1
                        menuMedicGarage.menu.to = menuMedicGarage.menu.to - 1
                    end
                end
            end
            
            --> Check if the DOWN button is pressed : 
            if IsControlJustPressed(1,187)then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                if menuMedicGarage.selectedbutton < buttoncount then
                    menuMedicGarage.selectedbutton = menuMedicGarage.selectedbutton +1
                    if buttoncount > 10 and menuMedicGarage.selectedbutton > menuMedicGarage.menu.to then
                        menuMedicGarage.menu.to = menuMedicGarage.menu.to + 1
                        menuMedicGarage.menu.from = menuMedicGarage.menu.from + 1
                    end
                end
            end
        end
    end
end)

function GestionGarageMedic(button)
    local this = menuMedicGarage.currentmenu
	local btnAction = button.action
    local btnTypeItem = button.itemType
    local modelVeh = button.model_vehicule

    if this == "main" then
        if btnAction == "SortirVehicule" then
        else
            TriggerEvent("GTA_Medic:SortirVeh",modelVeh)
            CloseMenu()
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