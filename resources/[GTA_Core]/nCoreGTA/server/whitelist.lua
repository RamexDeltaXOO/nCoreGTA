--@Super.Cool.Ninja

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
    local player = source
    local identifiers = GetPlayerIdentifiers(player)
    local identifiersNum = #GetPlayerIdentifiers(player)
    local allowed = false
    local isBannis = false
    local newInfo = ""
    local oldInfo = ""

    TriggerEvent('GTA:CreationJoueur', source)

    deferrals.defer()
    deferrals.update("")
    Wait(0)

    if config.activerWhitelist then
        for k1, v in pairs(identifiers) do
            for k2, i in ipairs(config.JoueursWhitelist) do
                if string.match(v, i) then
                    if isBannis == true then
                        allowed = false
                    else
                        allowed = true
                    end
                    break
                end
            end
        end

        if allowed then
            exports.ghmattimysql:execute("SELECT * FROM gta_joueurs_banni WHERE license = @username", {['@username'] = license}, function(result)
                if result[1] then
                    deferrals.done("Vous êtes bannis !")
                    isBannis = true
                else
                    deferrals.done()
                end
            end)
            print("Joueur : [ "..GetPlayerName(source).. " ] vient de rejoindre. license : ", license)
        else
            for k1, v in pairs(identifiers) do
                oldInfo = newInfo
                newInfo = string.format("%s\n%s", oldInfo, v)
            end
            file = io.open("LICENSE_NOUVEAU_JOUEURS.txt", "a")
            if file then
                file:write("[ "..GetPlayerName(source).. " ] ", license .."\n")
            end
            file:close()
            print("[ "..GetPlayerName(source).. " ] tente une connexion. license : ", license)
            deferrals.done('Vous n\'êtes pas whitelist, veuillez vous rendre sur le discord : '..config.lienDiscord)
        end
    end
    if not config.activerWhitelist then
        exports.ghmattimysql:scalar("SELECT license FROM gta_joueurs_banni WHERE ?", {{['license'] = license}}, function(license)
            if license ~= nil then
                deferrals.done("Vous êtes bannis !")
                isBannis = true
            else
                deferrals.done()
            end
          end)
        print("Joueur : [ "..GetPlayerName(source).. " ] vient de rejoindre. license : ", license)
    end
end)