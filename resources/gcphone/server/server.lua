--====================================================================================
-- #Author: Jonathan D @Gannon
-- #Version 2.0
--====================================================================================
function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

--====================================================================================
--  Gestion des appels
--====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall (num)
    local result = exports.ghmattimysql:execute("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120", {
        ['@num'] = num
    })
    return result
end

function sendHistoriqueCall (src, num) 
    local histo = getHistoriqueCall(num)
    TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

function getSourceFromIdentifier(identifier, cb) --> A REWORK.
    TriggerEvent('GTA:GetGlobaleJoueurs', function(joueurs)
        for _,v in pairs(joueurs) do
            print(v.serverid)
            if (v.license ~= nil and v.license == identifier) or (v.license == identifier) then
                print("ID RETURN")
                cb(v.serverid)
                return
            end
        end
    end)
    print("ID NOT FOUND")
    cb(nil)
end

--[[
    function getSourceFromIdentifier(identifier, cb)
    local xPlayers = GetPlayers()
    for i=1, #xPlayers, 1 do
        local array = xPlayers[i]
        print(array)
        TriggerEvent('GTA:GetGlobaleJoueurs', function(array)
            print(array)
            for _,v in pairs(array) do
                print(i)
                print(v.license)
                if(v.license ~= nil and v.license == identifier) or (v.license == identifier) then
                    print("INDEX SOURCE :", i)
                    print("LICENSE : ", v.license)
                    cb(i)
                    return
                end
            end
        end)
    end 
    cb(nil)
end
]]

function getIdentifierByPhoneNumber(phone_number) 
    exports.ghmattimysql:scalar("SELECT license FROM gta_joueurs WHERE ?", {{['phone_number'] = phone_number}}, function(res)
       if res ~= nil then
        print("License :", res)
        return res
       end
    end)
end

function addContact(source, identifier, number, display)
    exports.ghmattimysql:execute("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)", {
        ['@identifier'] = identifier,
        ['@number'] = number,
        ['@display'] = display,
    },function()
        print("Contact ajouter : ", source, identifier)
        notifyContactChange(source, identifier)
    end)
end

function updateContact(source, identifier, id, number, display)
    exports.ghmattimysql:execute("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id", { 
        ['@number'] = number,
        ['@display'] = display,
        ['@id'] = id,
    },function()
        notifyContactChange(source, identifier)
    end)
end

function deleteContact(source, identifier, id)
    exports.ghmattimysql:execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id", {
        ['@identifier'] = identifier,
        ['@id'] = id,
    })
    notifyContactChange(source, identifier)
end

function deleteAllContact(identifier)
    exports.ghmattimysql:execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier", {
        ['@identifier'] = identifier
    })
end

function notifyContactChange(source, identifier)
    print("-****notifyContactChange--**")
    print(source)
    print("IDENTIFIER", identifier)
    if source ~= nil then 
        print("source est different de nil")
        
        exports.ghmattimysql:execute("SELECT * FROM phone_users_contacts WHERE identifier = @identifier", { ['@identifier'] = identifier}, function(res2)
            TriggerClientEvent("gcPhone:contactList", source, res2)
        end)
    end
end


RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber)
    local source = source
	local license = GetPlayerIdentifiers(source)[1]
    addContact(source, license, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber)
    local source = source
	local license = GetPlayerIdentifiers(source)[1]
    updateContact(source, license, id, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
    local source = source
	local license = GetPlayerIdentifiers(source)[1]
    deleteContact(source, license, id)
end)

RegisterServerEvent('gcPhone:_internalAddMessage')
AddEventHandler('gcPhone:_internalAddMessage', function(transmitter, receiver, message, owner, cb)
    cb(_internalAddMessage(transmitter, receiver, message, owner))
end)

function _internalAddMessage(transmitter, receiver, message, owner)
    local Query = "INSERT INTO phone_messages SET ?"
    local Query2 = 'SELECT * from phone_messages WHERE ?'
    local Parameters = {
        ['transmitter'] = transmitter,
        ['receiver'] = receiver,
        ['message'] = message,
        ['isRead'] = owner,
        ['owner'] = owner
    }
    local res = exports.ghmattimysql:executeSync(Query, { Parameters })
    local id = res['insertId']
    return exports.ghmattimysql:executeSync(Query2, {{
        ['id'] = id
    }})[1]
end

function addMessage(source, identifier, phone_number, message)
    print("Numero target :", phone_number)

    exports.ghmattimysql:scalar("SELECT license FROM gta_joueurs WHERE ?", {{['phone_number'] = phone_number}}, function(myPhone_number)
        print("License :", myPhone_number)
        if myPhone_number ~= nil then 
            exports.ghmattimysql:scalar("SELECT phone_number FROM gta_joueurs WHERE ?", {{['license'] = identifier}}, function(myPhone)
                local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
                getSourceFromIdentifier(myPhone_number, function(osou)
                    if tonumber(osou) ~= nil then 
                        TriggerClientEvent("gcPhone:receiveMessage", tonumber(osou), tomess)
                    end
                end) 
                local memess = _internalAddMessage(phone_number, myPhone, message, 1)
                TriggerClientEvent("gcPhone:receiveMessage", source, memess)
            end)
        end
    end)
end

function setReadMessageNumber(identifier, num)
    exports.ghmattimysql:scalar("SELECT phone_number FROM gta_joueurs WHERE ?", {{['license'] = identifier}}, function(getNumberPhone)
        exports.ghmattimysql:execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter", { 
            ['@receiver'] = getNumberPhone,
            ['@transmitter'] = num
        })
    end)
end

function deleteMessage(msgId)
    exports.ghmattimysql:execute("DELETE FROM phone_messages WHERE `id` = @id", {
        ['@id'] = msgId
    })
end

function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
    local source = source
    local identifier = identifier
    exports.ghmattimysql:scalar("SELECT phone_number FROM gta_joueurs WHERE ?", {{['license'] = identifier}}, function(mePhoneNumber)
        exports.ghmattimysql:execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {['@mePhoneNumber'] = mePhoneNumber,['@phone_number'] = phone_number})
    end)
end

function deleteAllMessage(identifier)
    exports.ghmattimysql:scalar("SELECT phone_number FROM gta_joueurs WHERE ?", {{['license'] = identifier}}, function(mePhoneNumber)
        exports.ghmattimysql:execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {
            ['@mePhoneNumber'] = mePhoneNumber
        })
    end)
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
    local source = source
	local license = GetPlayerIdentifiers(source)[1]
    addMessage(source, license, phoneNumber, message)
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
    deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
    local source = source
	local license = GetPlayerIdentifiers(source)[1]
    deleteAllMessageFromPhoneNumber(source,license, number)
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
    local source = source
	local license = GetPlayerIdentifiers(source)[1]
    deleteAllMessage(license)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
    local source = source
	local license = GetPlayerIdentifiers(source)[1]
    setReadMessageNumber(license, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
    local source = source
	local license = GetPlayerIdentifiers(source)[1]
    deleteAllMessage(license)
    deleteAllContact(license)
    appelsDeleteAllHistorique(license)
    TriggerClientEvent("gcPhone:contactList", source, {})
    TriggerClientEvent("gcPhone:allMessage", source, {})
    TriggerClientEvent("appelsDeleteAllHistorique", source, {})
end)

--====================================================================================
--  Gestion des appels
--====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall (num)
    local result = exports.ghmattimysql:execute("SELECT * FROM phone_calls WHERE owner = @num ORDER BY time DESC LIMIT 120", {
        ['@num'] = num
    })
    return result
end

function sendHistoriqueCall (src, num) 
    local histo = getHistoriqueCall(num)
    TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

function saveAppels (appelInfo)
    if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
        exports.ghmattimysql:execute("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.transmitter_num,
            ['@num'] = appelInfo.receiver_num,
            ['@incoming'] = 1,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            notifyNewAppelsHisto(appelInfo.transmitter_src, appelInfo.transmitter_num)
        end)
    end
    if appelInfo.is_valid == true then
        local num = appelInfo.transmitter_num
        if appelInfo.hidden == true then
            mun = "###-####"
        end
        exports.ghmattimysql:execute("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.receiver_num,
            ['@num'] = num,
            ['@incoming'] = 0,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            if appelInfo.receiver_src ~= nil then
                notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
            end
        end)
    end
end

function notifyNewAppelsHisto (src, num) 
    sendHistoriqueCall(src, num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall', function()
    local source = source
    sendHistoriqueCall(source, num)
end)

RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall', function(source, phone_number, rtcOffer, extraData)
    if FixePhone[phone_number] ~= nil then
        onCallFixePhone(source, phone_number, rtcOffer, extraData)
        return
    end
    
    local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then 
        print('BAD CALL NUMBER IS NIL')
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local source = source
	local license = GetPlayerIdentifiers(source)[1]

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        exports.ghmattimysql:scalar("SELECT phone_number FROM gta_joueurs WHERE ?", {{['license'] = license}}, function(getNumberPhone)
            srcPhone = getNumberPhone
        end)
    end
    local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local is_valid = destPlayer ~= nil and destPlayer ~= license
    
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = source,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }

    if is_valid == true then
        getSourceFromIdentifier(destPlayer, function (srcTo)
            if srcTo ~= nill then
                AppelsEnCours[indexCall].receiver_src = srcTo
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', source, AppelsEnCours[indexCall], true)
                TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false)
            else
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', source, AppelsEnCours[indexCall], true)
            end
        end)
    else
        TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
        TriggerClientEvent('gcPhone:waitingCall', source, AppelsEnCours[indexCall], true)
    end
end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
    TriggerEvent('gcPhone:internal_startCall',source, phone_number, rtcOffer, extraData)
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates', function (callId, candidates)
    -- print('send cadidate', callId, candidates)
    if AppelsEnCours[callId] ~= nil then
        local source = source
        local to = AppelsEnCours[callId].transmitter_src
        if source == to then 
            to = AppelsEnCours[callId].receiver_src
        end
        -- print('TO', to)
        TriggerClientEvent('gcPhone:candidates', to, candidates)
    end
end)

RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, rtcAnswer)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onAcceptFixePhone(source, infoCall, rtcAnswer)
            return
        end
        AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
            AppelsEnCours[id].is_accepts = true
            AppelsEnCours[id].rtcAnswer = rtcAnswer
            TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
	    SetTimeout(1000, function() -- change to +1000, if necessary.
       		TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
	    end)
            saveAppels(AppelsEnCours[id])
        end
    end
end)

RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function (infoCall)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onRejectFixePhone(source, infoCall)
            return
        end
        if AppelsEnCours[id].transmitter_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
        end
        if AppelsEnCours[id].receiver_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].receiver_src)
        end

        if AppelsEnCours[id].is_accepts == false then 
            saveAppels(AppelsEnCours[id])
        end
        TriggerEvent('gcPhone:removeCall', AppelsEnCours)
        AppelsEnCours[id] = nil
    end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique', function (numero)
    local source = source
	local license = GetPlayerIdentifiers(source)[1]

    exports.ghmattimysql:scalar("SELECT phone_number FROM gta_joueurs WHERE ?", {{['license'] = license}}, function(getNumberPhone)
        exports.ghmattimysql:execute("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num", {
            ['@owner'] = getNumberPhone,
            ['@num'] = numero
        })
    end)
end)

function appelsDeleteAllHistorique(srcIdentifier)
    exports.ghmattimysql:scalar("SELECT phone_number FROM gta_joueurs WHERE ?", {{['license'] = srcIdentifier}}, function(getNumberPhone)
        exports.ghmattimysql:execute("DELETE FROM phone_calls WHERE `owner` = @owner", {
            ['@owner'] = getNumberPhone
        })
    end)
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique', function ()
    local source = source
	local license = GetPlayerIdentifiers(source)[1]
    appelsDeleteAllHistorique(license)
end)

--====================================================================================
--  OnLoad
--====================================================================================

RegisterServerEvent("GTA:TelephoneLoaded")
AddEventHandler("GTA:TelephoneLoaded",function()
    local source = source
	local license = GetPlayerIdentifiers(source)[1]

    exports.ghmattimysql:scalar("SELECT phone_number FROM gta_joueurs WHERE ?", {{['license'] = license}}, function(Myphone_number)
		if Myphone_number then
            TriggerClientEvent("gcPhone:myPhoneNumber", source, Myphone_number)
            
            exports.ghmattimysql:execute("SELECT * FROM phone_users_contacts WHERE identifier = @identifier", { ['@identifier'] = license}, function(res2)
                TriggerClientEvent("gcPhone:contactList", source, res2)
            end)

            exports.ghmattimysql:execute("SELECT phone_messages.* FROM phone_messages LEFT JOIN gta_joueurs ON gta_joueurs.license = @identifier WHERE phone_messages.receiver = gta_joueurs.phone_number", { ['@identifier'] = license}, function(result)
                if (result) then
                    TriggerClientEvent("gcPhone:allMessage", source, result)
                end
            end)
            
			sendHistoriqueCall(source, Myphone_number)

            print("NUMBER LOADED !")
        end
	end)
end)

function onCallFixePhone (source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        exports.ghmattimysql:scalar("SELECT phone_number FROM gta_joueurs WHERE ?", {{['license'] = srcIdentifier}}, function(getNumberPhone)
            srcPhone = getNumberPhone
        end)
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData,
        coords = FixePhone[phone_number].coords
    }
    
    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
end

function onAcceptFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    
    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
        TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
	SetTimeout(1000, function() -- change to +1000, if necessary.
       	TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
	end)
        saveAppels(AppelsEnCours[id])
    end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    PhoneFixeInfo[id] = nil
    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
    if AppelsEnCours[id].is_accepts == false then
        saveAppels(AppelsEnCours[id])
    end
    AppelsEnCours[id] = nil 
end