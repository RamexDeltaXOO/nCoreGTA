----------------------||Inventaire||--------------------
inventory_item = {}
ITEMS = {}
NewItems = {}
local maxCapacity = 100 -->Max the slot dans votre inventaire par item

--[[INFO : TYPE 1 = SOIF, TYPE 2 = FOOD, TYPE 3 = OBJECT]]


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
	if (pods < (maxCapacity-1)) then return true end
end

RegisterNetEvent("player:receiveItem")
AddEventHandler("player:receiveItem", function(item, quantity)
	if (getPods() + quantity < maxCapacity) then
		item = tonumber(item)
		if (ITEMS[item] == nil) then
			new(item, quantity)
		else
			add({ item, quantity })
		end
	end
end)

RegisterNetEvent("player:looseItem")
AddEventHandler("player:looseItem", function(item, quantity)
	item = tonumber(item)
	if (ITEMS[item].quantity >= quantity) then
		delete({ item, quantity })
	end
end)

RegisterNetEvent("player:sellItem")
AddEventHandler("player:sellItem", function(item, price)
	item = tonumber(item)
	if (ITEMS[item].quantity > 0) then
		sell(item, price)
	end
end)

RegisterNetEvent("farm:updateQuantity")
AddEventHandler("farm:updateQuantity", function(qty, id)
	ITEMS[id].quantity = qty
end)

RegisterNetEvent("farm:updateQuantityTarget")
AddEventHandler("farm:updateQuantityTarget", function(qty, id)
	ITEMS[id].quantity = qty
end)

AddEventHandler("player:resetItem", function(item)
	item = tonumber(item)
	delete({ item, ITEMS[item].quantity })
end)

function sell(itemId, price)
	local item = ITEMS[itemId]
	item.quantity = item.quantity - 1
	NewItems[itemId] = item.quantity
	TriggerServerEvent("item:sell", itemId, item.quantity, price)
  	InventaireRefreshMenu()
end

function delete(arg)
	local itemId = tonumber(arg[1])
	local qty = arg[2]
	local item = ITEMS[itemId]
	item.quantity = item.quantity - qty
	NewItems[itemId] = item.quantity
	TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
	TriggerEvent("farm:updateQuantity", item.quantity, itemId)
  	InventaireRefreshMenu()
end

function deleteTargetItem(target, arg)
	local itemId = tonumber(arg[1])
	local qty = arg[2]
	local item = ITEMS[itemId]
	item.quantity = item.quantity - qty
	NewItems[itemId] = item.quantity
	TriggerServerEvent("item:updateQuantityTarget",target, item.quantity, itemId)
	TriggerEvent("farm:updateQuantityTarget", item.quantity, itemId)
  	InventaireRefreshMenu()
end

function add(arg)
	local itemId = tonumber(arg[1])
	local qty = arg[2]
	local item = ITEMS[itemId]
	item.quantity = item.quantity + qty
	NewItems[itemId] = item.quantity
	TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
	TriggerEvent("farm:updateQuantity", item.quantity, itemId)
  	InventaireRefreshMenu()
end

function new(item, quantity)
	TriggerServerEvent("item:setItem", item, quantity)
	TriggerServerEvent("item:getItems")
end

function updateQuantities()
    for item, quantity in pairs(NewItems) do
        TriggerServerEvent("item:updateQuantity", quantity, item)
    end
end

function getQuantity(itemId)
    if ITEMS[tonumber(itemId)] ~= nil then
        return ITEMS[tonumber(itemId)].quantity
    end
    return 0
end


AddEventHandler("player:getQuantity", function(item, call)
	 call({count=getQuantity(item)})
end)

function use(itemId, quantity)
	if ITEMS[tonumber(itemId)].type == 1 then
	  	TriggerEvent("nAddSoif", 25) --> Nombre d'ajout au moment ou il boit
	elseif ITEMS[tonumber(itemId)].type == 2 then
		TriggerEvent("nAddFaim", 25)  --> Nombre d'ajout au moment ou il mange
	elseif ITEMS[tonumber(itemId)].type == 4 then --> Seringue d'adrenaline.
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
			TriggerEvent('player:looseItem',itemId,1)
		else
			exports.nCoreGTA:nNotificationMain({
				text = "~y~ Aucune personne devant vous !",
				type = 'basGauche',
				nTimeNotif = 1000,
			})
		end
	end
	TriggerEvent('player:looseItem', itemId, quantity)
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