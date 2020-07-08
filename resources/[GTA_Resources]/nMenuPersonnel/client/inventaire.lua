----------------------||Inventaire||--------------------
inventory_item = {}
ITEMS = {}
NewItems = {}
local maxCapacity = 100 -->Max the slot dans votre inventaire par item

--[[INFO : TYPE 1 = SOIF, TYPE 2 = FOOD, TYPE 3 = OBJECT,  TYPE 4 = UTILISATION OBJET POUR TARGET]]

--nCoreGTA
RegisterNetEvent("item:reset")
RegisterNetEvent("item:getItems")
RegisterNetEvent("item:sell")

RegisterNetEvent("gui:getItems")
AddEventHandler("gui:getItems", function(THEITEMS)
	ITEMS = {}
	ITEMS = THEITEMS
  	InventaireRefreshMenu()
end)

function getPods()
	local pods = 0
	for _, v in pairs(ITEMS) do
		pods = pods + v.quantity
	end
	return pods
end

function notFull()
	local pods = 0
	for _, v in pairs(ITEMS) do
		pods = pods + v.quantity
	end
	if (pods <= (maxCapacity-1)) then return true end
end

RegisterNetEvent("player:receiveItem")
AddEventHandler("player:receiveItem", function(item_name, quantity)
	if (getPods() + quantity <= maxCapacity) then
		item_name = tostring(item_name)
		if (ITEMS[item_name] == nil) then
			new(item_name, quantity)
		else
			add({ item_name, quantity })
		end
		exports.nCoreGTA:nNotificationMain({
            text = "Vous avez reçu ~g~x"..tonumber(quantity).."~b~ "..item_name,
            type = 'basGauche',
            nTimeNotif = 6000,
        })
	else
		exports.nCoreGTA:nNotificationMain({
			text =  "~r~Quantité trop grande ou\nInventaire rempli.",
			type = 'basGauche',
			nTimeNotif = 2000,
		})
	end
end)


RegisterNetEvent("player:looseItem")
AddEventHandler("player:looseItem", function(item, quantity)
	item = tostring(item)
	if (ITEMS[item].quantity >= quantity) then
		delete({ item, quantity })
	end
end)

RegisterNetEvent("player:sellItem")
AddEventHandler("player:sellItem", function(item, price)
	item = tostring(item)
	if (ITEMS[item].quantity > 0) then
		sell(item, price)
	end
end)

RegisterNetEvent("farm:updateQuantity")
AddEventHandler("farm:updateQuantity", function(qty, id)
	ITEMS[id].quantity = qty
end)

AddEventHandler("player:resetItem", function(item)
	item = tostring(item)
	delete({ item, ITEMS[item].quantity })
end)

function sell(itemName, price)
	local item = ITEMS[itemName]
	item.quantity = item.quantity - 1
	NewItems[itemName] = item.quantity
	TriggerServerEvent("item:sell", itemName, item.quantity, price)
  	InventaireRefreshMenu()
end

function delete(arg)
	local itemName = tostring(arg[1])
	local qty = arg[2]
	local item = ITEMS[itemName]
	item.quantity = item.quantity - qty
	NewItems[itemName] = item.quantity
	TriggerServerEvent("item:updateQuantity", item.quantity, itemName)
	TriggerEvent("farm:updateQuantity", item.quantity, itemName)
  	InventaireRefreshMenu()
end

function add(arg)
	local itemName = tostring(arg[1])
	local qty = arg[2]
	local item = ITEMS[itemName]
	item.quantity = item.quantity + qty
	NewItems[itemName] = item.quantity
	TriggerServerEvent("item:updateQuantity", item.quantity, itemName)
	TriggerEvent("farm:updateQuantity", item.quantity, itemName)
  	InventaireRefreshMenu()
end

function new(item_name, quantity)
	TriggerServerEvent("item:setItem", item_name, quantity)
	TriggerServerEvent("item:getItems")
end

function updateQuantities()
    for item, quantity in pairs(NewItems) do
        TriggerServerEvent("item:updateQuantity", quantity, item)
    end
end

function getQuantity(itemName)
    if ITEMS[tostring(itemName)] ~= nil then
        return ITEMS[tostring(itemName)].quantity
    end
    return 0
end


AddEventHandler("player:getQuantity", function(item, call)
	 call({count=getQuantity(item)})
end)

function use(itemName, quantity)
	if ITEMS[tostring(itemName)].type == 1 then
	  	TriggerEvent("nAddSoif", 25) --> Nombre d'ajout au moment ou il boit
	elseif ITEMS[tostring(itemName)].type == 2 then
		TriggerEvent("nAddFaim", 25)  --> Nombre d'ajout au moment ou il mange
	elseif ITEMS[tostring(itemName)].type == 4 then --> Seringue d'adrenaline.
		local target = GetPlayerServerId(GetClosestPlayer())
		if target ~= 0 then
			TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
			Citizen.Wait(8000)
			ClearPedTasks(GetPlayerPed(-1));
			TriggerServerEvent('GTA_Medic:ReanimerTarget', target)
			exports.nCoreGTA:nNotificationMain({
				text =  "~h~Vous avez soigné une personne.",
				type = 'basGauche',
				nTimeNotif = 6000,
			})
			TriggerEvent('player:looseItem',itemName,1)
		else
			exports.nCoreGTA:nNotificationMain({
				text = "~y~ Aucune personne devant vous !",
				type = 'basGauche',
				nTimeNotif = 1000,
			})
		end
	end
	TriggerEvent('player:looseItem', itemName, quantity)
end

function round(n)
	return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

function InventaireRefreshMenu()
	TriggerEvent("GTA:LoadWeaponPlayer")

	for k,v in pairs(inventory_item) do
		inventory_item[k] = nil
  	end
  
	for k, v in pairs(ITEMS) do
		if (v.quantity > 0) then
			table.insert(inventory_item, {name = tostring(v.libelle).. " "..tonumber(round(v.quantity)), itemType = tostring(v.type), itemName = tostring(v.libelle), iteamID = tostring(k), itemqty = tonumber(round(v.quantity))})
		end
  	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        if NewItems then
            updateQuantities()
        end
        NewItems = {}
    end
end)

AddEventHandler("playerSpawned", function()
  TriggerServerEvent("item:getItems")
  TriggerEvent("GTA:LoadWeaponPlayer")
end)

AddEventHandler("playerDropped", function()
    updateQuantities()
end)