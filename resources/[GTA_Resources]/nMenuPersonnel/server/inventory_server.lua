-----------||Inventaire||-----------
local items = {}
RegisterServerEvent("item:getItems")
AddEventHandler("item:getItems", function()
	items = {}
	local source = source	
	local player = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_name` = `items`.`libelle` WHERE license=@username", { ['@username'] = player}, function(result)
		if (result) then
			for k,v in ipairs(result) do
				t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle, ["isUsable"] = v.isUsable, ["type"] = v.type }
				items[v.item_name] = t
			end
		end
		TriggerClientEvent("gui:getItems", source, items)
	end)
end)

RegisterServerEvent("item:setItem")
AddEventHandler("item:setItem", function(item, quantity)
	local source = source	
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("SELECT * FROM user_inventory WHERE license = @username AND item_name = @item", {['@username'] = license, ['@item'] = item}, function(result)
		--print(json.encode(result[1]))
		if(result[1] ~= nil) then
			--print(result[1].id)
			exports.ghmattimysql:execute("UPDATE user_inventory SET ? WHERE ?", { {['quantity'] = quantity}, {['id'] = result[1].id} })
		else
			exports.ghmattimysql:execute('INSERT INTO user_inventory SET ?', { {['license'] = license, ['item_name'] = item, ['quantity'] = quantity} })
		end
	end)
end)

RegisterServerEvent("item:reset")
AddEventHandler("item:reset", function()
	local source = source	
	local player = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE user_inventory SET quantity=@quantity WHERE license=@username", {['@username'] = player, ['@quantity'] = 0})
end)

RegisterServerEvent("item:updateQuantity")
AddEventHandler("item:updateQuantity", function(qty, id)
	local source = source	
	local player = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE user_inventory SET ? WHERE ? AND ?", { {['quantity'] = qty}, {['license'] = player}, {['item_name'] = id}})
end)


RegisterServerEvent("item:sell")
AddEventHandler("item:sell", function(id, quantity, price)
	local source = source	
	local player = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE user_inventory SET quantity=@quantity WHERE license=@username AND item_name=@id", {['@username'] = player, ['@quantity'] = tonumber(quantity), ['@id'] = tostring(id)})
	player.addMoney(tonumber(price))
end)


RegisterServerEvent("player:giveItem")
AddEventHandler("player:giveItem", function(NearestPlayerSID, item, id, quantity)
    local mysource = source
    local targetid = getPlayerID(NearestPlayerSID)
    local quantity = math.floor(tonumber(quantity))
    exports.ghmattimysql:execute("SELECT SUM(quantity) FROM user_inventory WHERE license = @username", { ['@username'] = targetid }, function(result)
        if quantity < 101 then --Limit item max pour l'inventaire'
			TriggerClientEvent("player:looseItem", mysource, item, quantity)
			TriggerClientEvent("player:receiveItem", NearestPlayerSID, item, quantity)
			TriggerClientEvent('nMenuNotif:showNotification', mysource, "Vous avez donné ~b~" .. quantity .. "~s~ ~g~" .. id)
			TriggerClientEvent('nMenuNotif:showNotification', NearestPlayerSID, "Une personne vous a donner ~b~" .. quantity)
		else
			TriggerClientEvent('nMenuNotif:showNotification', NearestPlayerSID, "Cette Personne ne peut pas transporter plus d'item.")
			TriggerClientEvent('nMenuNotif:showNotification', NearestPlayerSID, "Vous ne pouvez pas porter plus d'item sur vous ! ~b~")
        end
    end)
end)