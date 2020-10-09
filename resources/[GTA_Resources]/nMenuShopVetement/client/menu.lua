tShirtMenu = RageUI.CreateMenu("T-Shirt",  "Magasin de vetement.")
local prix = 0
local itemName = " "
local Duree = 0
local index_tShirt = 1

Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(tShirtMenu, function()
			for i = 1, #Config.Locations do
                local tShirtPos = Config.Locations[i]["MagasinDeVetement"]["TShirtPos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, tShirtPos["x"], tShirtPos["y"], tShirtPos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Haut', indexii, index_tShirt, "", {}, true, {
                        onListChange = function(Index, Item)
                         index_tShirt = Index;
                            
                        end,
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)

Citizen.CreateThread(function()
    while true do
        Duree = 250
        if IsNearOfZones() then
            Duree = 0
            
            if GetLastInputMethod(0) then
                Ninja_Core__DisplayHelpAlert("~INPUT_PICKUP~ pour ~b~intéragir")
            else
                Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~b~intéragir")
            end
        end

        if GetNearZone() == "TshirtMenu" then 
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
               RageUI.Visible(tShirtMenu, not RageUI.Visible(tShirtMenu))
           end
        end

        if RageUI.Visible(tShirtMenu) == true then 
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
            DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT  
        end
       Citizen.Wait(Duree)
   end
end)