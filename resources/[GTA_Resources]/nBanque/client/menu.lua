--> MENU :
local menuConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/ConfigMenu.json'))
local atmMenu = {
	opened = false,
	title = "",
	currentmenu = "atmMenuMain",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.8 + 0.07,
		y = 0.05,
		width = 0.2 + 0.05,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["atmMenuMain"] = {
			title = "ATM",
			name = "atmMenuMain",
			buttons = {
			
				{name = "Retirer", action = "Retirer"},
				{name = "Deposer", action = "Deposer"},
				{name = "Solde", action = "Solde"},
            }
    	},
  	}
}

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

function LocalPed()
	return GetPlayerPed(-1)
end

function OpenCreator()
	boughtcar = false
	local ped = LocalPed()
	atmMenu.currentmenu = "atmMenuMain"
	atmMenu.opened = true
	atmMenu.selectedbutton = 1
end

function CloseCreator()
	Citizen.CreateThread(function()
		atmMenu.opened = false
		atmMenu.menu.from = 1
		atmMenu.menu.to = 10
	end)
end

function drawMenuButton(button,x,y,selected)
	local menu = atmMenu.menu

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
	local menu = atmMenu.menu
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
	for _ in pairs(T) do 
		count = count + 1 
	end
	return count
end

local backlock = false
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	for _, item in pairs(atms) do
		local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance <= 3) then
			
			if GetLastInputMethod(0) then
				Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ~b~intéragir")
			else
				Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_RIGHT~ pour ~b~intéragir")
			end
			
			if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
				OpenCreator()
			end


			if atmMenu.opened then
				DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT
				local ped = LocalPed()
				local menu = atmMenu.menu[atmMenu.currentmenu]
				drawMenuTitle(menu.title, atmMenu.menu.x,atmMenu.menu.y + 0.08)
				local y = atmMenu.menu.y + 0.12
				buttoncount = tablelength(menu.buttons)
				local selected = false
				for i,button in pairs(menu.buttons) do
					if i >= atmMenu.menu.from and i <= atmMenu.menu.to then
						if i == atmMenu.selectedbutton then
							selected = true
						else
							selected = false
						end
					drawMenuButton(button,atmMenu.menu.x,y,selected)
					y = y + 0.04
						if selected and IsControlJustPressed(1,201) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
							ButtonSelected(button)
						end
					end
				end
			end

			if atmMenu.opened then
				if IsControlJustPressed(1,202) then
					Back()
				end
				if IsControlJustReleased(1,202) then
					backlock = false
				end
				if IsControlJustPressed(1,188) then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
					if atmMenu.selectedbutton > 1 then
						atmMenu.selectedbutton = atmMenu.selectedbutton -1
						if buttoncount > 10 and atmMenu.selectedbutton < atmMenu.menu.from then
							atmMenu.menu.from = atmMenu.menu.from -1
							atmMenu.menu.to = atmMenu.menu.to - 1
						end
					end
				end
				if IsControlJustPressed(1,187)then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
					if atmMenu.selectedbutton < buttoncount then
						atmMenu.selectedbutton = atmMenu.selectedbutton +1
						if buttoncount > 10 and atmMenu.selectedbutton > atmMenu.menu.to then
							atmMenu.menu.to = atmMenu.menu.to + 1
							atmMenu.menu.from = atmMenu.menu.from + 1
						end
					end
				end
			end
		end
	 end
   end
end)

function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = atmMenu.currentmenu
    local btn = button.name

	if this == "atmMenuMain" then
		if btn == "Retirer" then
			local quantityMoneyitems = KeyboardInput("Somme d'argent à retirer :", "", 6)
			if tonumber(quantityMoneyitems) == nil then
				exports.nCoreGTA:nNotificationMain({
					text = "Veuillez inserer un nombre correct !",
					type = 'basGauche',
					nTimeNotif = 6000,
				})
                return nil
			end
			TriggerServerEvent("nBanqueSolde:PermissionRABanque", quantityMoneyitems)
			CloseCreator()
		elseif btn == "Deposer" then
			local quantityMoneyBanqueitems = KeyboardInput("Somme d'argent à déposer :", "", 6)
			if tonumber(quantityMoneyBanqueitems) == nil then
				exports.nCoreGTA:nNotificationMain({
					text = "Veuillez inserer un nombre correct !",
					type = 'basGauche',
					nTimeNotif = 6000,
				})
                return nil
			end
			TriggerServerEvent("nBanqueSolde:PermissionDABanque", quantityMoneyBanqueitems)
			CloseCreator()
		elseif btn == "Solde" then
			TriggerServerEvent("nBanqueSolde:SRender")
			CloseCreator()
		end
	end
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if atmMenu.currentmenu == "atmMenuMain" then
		CloseCreator()
	elseif atmMenu.currentmenu == "atmMenupersonnel" then
		OpenMenu("atmMenuMain")
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