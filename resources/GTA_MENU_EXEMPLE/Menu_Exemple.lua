--||@SuperCoolNinja.||--
local function ShowNotification(text)
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
	DrawNotification( false, false )
end

-->Variable :
local menuConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/ConfigMenu.json')) --> Give the access to change the colours font for users.
local scaleform = nil

--> MENU :
local menuEg = {
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
		["main"] = { --> Main menu
			title = "Menu A",
			name = "main",
			buttons = {
				{name = "SubMenu" , action = "subMenu"},
				{name = "Second SubMenu", action = "subMenu2"},
			}
		},

        ["SubMenu"] = { --> First Sub Menu.
            title = "Title SubMenu",
            name = "SubMenu",
            buttons = {
                {name = "ActionButon", action = "firstAction"},
                {name = "Second ActionButon", action = "secondAction"},
            }
        },

        ["subMenu2"] = { --> Second SubMenu.
            title = "Title SubMenu 2",
            name = "subMenu2",
            buttons = {
                {name = "ActionButon", action = "firstAction"},
                {name = "Second ActionButon", action = "secondAction"},
            }
        },

  	}
}


----------------------------> [CONTROLS] :
local backlock = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        --> Check if the player press E to open the menu :
        if IsControlJustReleased(0, 38) then
			if not menuEg.opened then --> Check if the menu is not open then we do open.
				OpenMainMenu()
			end
		end

        if menuEg.opened then
            
            --> DISABLE THE PUNCH BUTTON B TO NOT HAVE CONFLIT WITH GAMEPLAY LIKE PUNCHING WHEN PRESSING B WHILE THE MENU IS OPEN :
            DisableControlAction(0, 140, true) 

			local menu = menuEg.menu[menuEg.currentmenu]
			drawMenuTitle(menu.title, menuEg.menu.x,menuEg.menu.y + 0.08)
			local y = menuEg.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				if i >= menuEg.menu.from and i <= menuEg.menu.to then
					if i == menuEg.selectedbutton then
						selected = true
					else
						selected = false
					end
				drawMenuButton(button,menuEg.menu.x,y + 0.02 + 0.003,selected)
				y = y + 0.04
					if selected and IsControlJustPressed(1,201) then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
						ButtonSelected(button)
					end
				end
			end
		end

        if menuEg.opened then
            --> Check if the ENTER button is pressed : 
			if IsControlJustPressed(1,202) then 
				Back()
            end
            
            --> Check if the UP button is pressed : 
			if IsControlJustPressed(1,188) then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if menuEg.selectedbutton > 1 then
					menuEg.selectedbutton = menuEg.selectedbutton -1
					if buttoncount > 10 and menuEg.selectedbutton < menuEg.menu.from then
						menuEg.menu.from = menuEg.menu.from -1
						menuEg.menu.to = menuEg.menu.to - 1
					end
				end
            end
            
             --> Check if the DOWN button is pressed : 
			if IsControlJustPressed(1,187)then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if menuEg.selectedbutton < buttoncount then
					menuEg.selectedbutton = menuEg.selectedbutton +1
					if buttoncount > 10 and menuEg.selectedbutton > menuEg.menu.to then
						menuEg.menu.to = menuEg.menu.to + 1
						menuEg.menu.from = menuEg.menu.from + 1
					end
				end
			end
		end
    end
end)


--> Controls of Action menu/subMenu... :
function ButtonSelected(button)
    local this = menuEg.currentmenu  --> this return the actual menu.
	local btnAction = button.action --> btnAction return the action.

    --> Main Menu :
    if this == "main" then
        if btnAction == "subMenu" then
			OpenMenu("SubMenu")
        elseif btnAction == "subMenu2" then
			OpenMenu("subMenu2")
        end

    --> First SubMenu :
	elseif this == "SubMenu" then 
        if btnAction == "firstAction" then
            ShowNotification("✅ ~g~First Action Check.")
        elseif btnAction == "secondAction" then
            ShowNotification("✅ ~g~Second Action Check.")
        end

    --> Second SubMenu :
    elseif this == "subMenu2" then
        if btnAction == "firstAction" then
            ShowNotification("✅ ~g~First Action Check.")
        elseif btnAction == "secondAction" then
            ShowNotification("✅ ~g~Second Action Check.")
        end
	end 
end



--> Function Back is used to let the player control the return back button.
--> [menuEg.currentmenu] = actual menu.
function Back() 
	if menuEg.currentmenu == "main" then 
        CloseMenu()
	elseif menuEg.currentmenu == "SubMenu" then
        OpenMainMenu()
    elseif menuEg.currentmenu == "subMenu2" then 
        OpenMenu("SubMenu")
	end
end



--> This is used to open the main menu :
function OpenMainMenu()
    if not HasStreamedTextureDictLoaded("commonmenu") then
        RequestStreamedTextureDict("commonmenu", true)
    end

    scaleform = RequestScaleformMovie("mp_menu_glare")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "initScreenLayout")
    PopScaleformMovieFunctionVoid()
    
    menuEg.currentmenu = "main"
    menuEg.opened = true
    menuEg.selectedbutton = 1
end


 ---> this is used to open an menu wanted : 
function OpenMenu(menu)
	menuEg.lastmenu = menuEg.currentmenu
	menuEg.menu.from = 1
	menuEg.menu.to = 10
	menuEg.selectedbutton = 1
	menuEg.currentmenu = menu
end


 ---> This is used to close the menu
function CloseMenu()
    Citizen.CreateThread(function()
        menuEg.opened = false
        menuEg.menu.from = 1
        menuEg.menu.to = 10
    end)
end
 
 

function drawMenuButton(button,x,y,selected)
    local menu = menuEg.menu
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
    local menu = menuEg.menu
    SetTextFont(0)
    SetTextScale(0.4 + 0.008, 0.4 + 0.008)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString(txt)
    DrawRect(x,y,menu.width,menu.height + 0.04 + 0.007, 0, 0, 0, 0)
    DrawTextMenu(1, txt, 0.8,menu.width - 0.4 / 2 + 0.1 + 0.005, y - menu.height/2 + 0.01, 255, 255, 255)
    DrawSprite("commonmenu", "interaction_bgd", x,y, menu.width,menu.height + 0.04 + 0.007, .0, 255, 255, 255, 255)
    DrawScaleformMovie(scaleform, 0.42 + 0.003,0.45, 0.9,0.9)
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