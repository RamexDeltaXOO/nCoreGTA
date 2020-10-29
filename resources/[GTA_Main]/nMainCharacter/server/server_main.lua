 --||@SuperCoolNinja.||--
 
 math.randomseed(os.time()) --> permet de generer un nombre aleatoire pour votre numero de phone.

 --- Pour les numero du style XXX-XXX
 local function getPhoneRandomNumber()
    local numBase0 = math.random(100,999)
    local numBase1 = math.random(0,999)
    local num = string.format("%03d-%03d", numBase0, numBase1)

	return num
end

function getHistoriqueCall (num)
    local result = exports.ghmattimysql:execute("SELECT * FROM phone_calls WHERE owner = @num ORDER BY time DESC LIMIT 120", {
        ['@num'] = num
    })
    return result
end

function sendHistoriqueCall(src, num) 
    exports.ghmattimysql:execute("SELECT * FROM phone_calls WHERE owner = @num ORDER BY time DESC LIMIT 120", { ['@num'] = num}, function(res2)
        TriggerClientEvent('gcPhone:historiqueCall', src, res2)
    end)
end

RegisterServerEvent("GTA:CreationPersonnage") --> Check a chaque spawn, si vous avez un personnage ou non.
AddEventHandler("GTA:CreationPersonnage", function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	local licenseValeur = {license}
    
    --> Si le joueurs n'a pas de perso on lui renvoi au menu de création sinon on charge le perso : 
	exports.ghmattimysql:scalar("SELECT isFirstConnection FROM gta_joueurs WHERE ?", {{['license'] = license}}, function(isFirstConnection)
        if isFirstConnection then
			exports.ghmattimysql:execute('INSERT INTO gta_joueurs_humain (`license`) VALUES ?', { { licenseValeur } })
			exports.ghmattimysql:execute('INSERT INTO gta_joueurs_vetement (`license`) VALUES ?', { { licenseValeur } })
			
			local randomPhoneNumber = getPhoneRandomNumber() 
			exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['phone_number'] = randomPhoneNumber}, {['license'] = license} })
			
			exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['isFirstConnection'] = 0}, {['license'] = license} })
			TriggerClientEvent("GTA:BeginCreation", source)
		else
			exports.ghmattimysql:execute("SELECT * FROM gta_joueurs_humain WHERE license = @license", { ['@license'] = license}, function(res2)
				TriggerClientEvent("GTA:UpdatePersonnage", source, res2[1].sex, res2[1].cheveux, res2[1].couleurCheveux, res2[1].couleurYeux, res2[1].pere, res2[1].mere, res2[1].couleurPeau, res2[1].visage)
			end)
		end
	end)

	Wait(1000)
	
	--GCPHONE Chargement du numéro : 
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
		end
	end)

	TriggerClientEvent("GTA:JoueurLoaded", source) --> Load l'argent du joueur.
end)


RegisterServerEvent("GTA:UpdateSexPersonnage")
AddEventHandler("GTA:UpdateSexPersonnage",function(sex)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs_humain SET ? WHERE ?", { {['sex'] = sex}, {['license'] = license} })

	if sex == "mp_m_freemode_01" then
		exports.ghmattimysql:execute("UPDATE gta_joueurs_vetement SET ? WHERE ?", { {['HatsDraw'] = 8}, {['license'] = license} })
	elseif sex == "mp_f_freemode_01" then
		exports.ghmattimysql:execute("UPDATE gta_joueurs_vetement SET ? WHERE ?", { {['HatsDraw'] = 15}, {['license'] = license} })
	end

	TriggerClientEvent("GTA:ChangerSex", source, sex)
end)

RegisterServerEvent("GTA:UpdateVisage")
AddEventHandler("GTA:UpdateVisage", function(visage)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs_humain SET ? WHERE ?", { {['visage'] = visage}, {['license'] = license} })
	TriggerClientEvent("GTA:ChangerVisage", source, visage)
end)

RegisterServerEvent("GTA:UpdateCouleurPeau")
AddEventHandler("GTA:UpdateCouleurPeau",function(peauID)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs_humain SET ? WHERE ?", { {['couleurPeau'] = peauID}, {['license'] = license} })
	TriggerClientEvent("GTA:ChangerCouleurPeau", source, peauID)
end)

RegisterServerEvent("GTA:UpdateYeux")
AddEventHandler("GTA:UpdateYeux",function(yeux)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs_humain SET ? WHERE ?", { {['couleurYeux'] = yeux}, {['license'] = license} })
	TriggerClientEvent("GTA:ChangerCouleurYeux", source, yeux)
end)

RegisterServerEvent("GTA:UpdateDad")
AddEventHandler("GTA:UpdateDad",function(dad)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs_humain SET ? WHERE ?", { {['pere'] = dad}, {['license'] = license} })
	TriggerClientEvent("GTA:ChangerDad", source, dad)
end)

RegisterServerEvent("GTA:UpdateMom")
AddEventHandler("GTA:UpdateMom",function(mom)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs_humain SET ? WHERE ?", { {['mere'] = mom}, {['license'] = license} })
	TriggerClientEvent("GTA:ChangerMom", source, mom)
end)

RegisterServerEvent("GTA:UpdateCheveux")
AddEventHandler("GTA:UpdateCheveux",function(cheveuxID)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs_humain SET ? WHERE ?", { {['cheveux'] = cheveuxID}, {['license'] = license} })
	TriggerClientEvent("GTA:ChangerCoupeCheveux", source, cheveuxID)
end)


RegisterServerEvent("GTA:UpdateCouleurCheveux")
AddEventHandler("GTA:UpdateCouleurCheveux",function(couleurID)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("UPDATE gta_joueurs_humain SET ? WHERE ?", { {['couleurCheveux'] = couleurID}, {['license'] = license} })
	TriggerClientEvent("GTA:ChangerCouleurCheveux", source, couleurID)
end)


RegisterServerEvent("GTA:TenueHomme") 
AddEventHandler("GTA:TenueHomme", function(TenueHomme)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	
	exports.ghmattimysql:execute(
	"UPDATE gta_joueurs_vetement SET topsID=@topsid, topsDraw=@topdraw, topsCouleur=@topscouleur, undershirtsID=@undershirtsid, undershirtsDraw=@undershirtsdraw, undershirtsCouleur=@undershirtscouleur, shoesID=@shoesid, shoesDraw=@shoesdraw, shoesCouleur=@shoescouleur, legsID=@legsid, legsDraw=@legsdraw, legsCouleur=@legscouleur, torsosID=@torsosid, torsosDraw=@torsosdraw, AccessoiresID=@accessoiresid, AccessoiresDraw=@Accessoiresdraw, AccessoiresCouleur=@Accessoirescouleur WHERE license=@license", {
	['@license'] = license,
	['@topsid'] = 				TenueHomme["Tops"].componentId,
	['@topdraw'] = 				TenueHomme["Tops"].drawableId, 
	['@topscouleur'] = 			TenueHomme["Tops"].textureId, 
	['@undershirtsid'] = 		TenueHomme["Undershirts"].componentId,
	['@undershirtsdraw'] = 		TenueHomme["Undershirts"].drawableId, 
	['@undershirtscouleur'] = 	TenueHomme["Undershirts"].textureId,
	['@shoesid'] = 				TenueHomme["Shoes"].componentId, 
	['@shoesdraw'] = 			TenueHomme["Shoes"].drawableId,
	['@shoescouleur'] = 		TenueHomme["Shoes"].textureId,
	['@legsid'] = 				TenueHomme["Legs"].componentId, 
	['@legsdraw'] = 			TenueHomme["Legs"].drawableId, 
	['@legscouleur'] = 			TenueHomme["Legs"].textureId, 
	['@torsosid'] = 			TenueHomme["Torsos"].componentId, 
	['@torsosdraw'] = 			TenueHomme["Torsos"].drawableId,
	['@accessoiresid'] = 		TenueHomme["Accessories"].componentId,
	['@Accessoiresdraw'] = 		TenueHomme["Accessories"].drawableId,
	['@Accessoirescouleur'] = 	TenueHomme["Accessories"].textureId})
end)

RegisterServerEvent("GTA:TenueFemme")
AddEventHandler("GTA:TenueFemme", function(TenueFemme)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	
	exports.ghmattimysql:execute(
	"UPDATE gta_joueurs_vetement SET topsID=@topsid, topsDraw=@topdraw, topsCouleur=@topscouleur, undershirtsID=@undershirtsid, undershirtsDraw=@undershirtsdraw, undershirtsCouleur=@undershirtscouleur, shoesID=@shoesid, shoesDraw=@shoesdraw, shoesCouleur=@shoescouleur, legsID=@legsid, legsDraw=@legsdraw, legsCouleur=@legscouleur, torsosID=@torsosid, torsosDraw=@torsosdraw, AccessoiresID=@accessoiresid, AccessoiresDraw=@Accessoiresdraw, AccessoiresCouleur=@Accessoirescouleur WHERE license=@license", {
	['@license'] = license,
	['@topsid'] = 				TenueFemme["Tops"].componentId,
	['@topdraw'] = 				TenueFemme["Tops"].drawableId, 
	['@topscouleur'] = 			TenueFemme["Tops"].textureId, 
	['@undershirtsid'] = 		TenueFemme["Undershirts"].componentId,
	['@undershirtsdraw'] = 		TenueFemme["Undershirts"].drawableId, 
	['@undershirtscouleur'] = 	TenueFemme["Undershirts"].textureId,
	['@shoesid'] = 				TenueFemme["Shoes"].componentId, 
	['@shoesdraw'] = 			TenueFemme["Shoes"].drawableId,
	['@shoescouleur'] = 		TenueFemme["Shoes"].textureId,
	['@legsid'] = 				TenueFemme["Legs"].componentId, 
	['@legsdraw'] = 			TenueFemme["Legs"].drawableId, 
	['@legscouleur'] = 			TenueFemme["Legs"].textureId, 
	['@torsosid'] = 			TenueFemme["Torsos"].componentId, 
	['@torsosdraw'] = 			TenueFemme["Torsos"].drawableId,
	['@accessoiresid'] = 		TenueFemme["Accessories"].componentId,
	['@Accessoiresdraw'] = 		TenueFemme["Accessories"].drawableId,
	['@Accessoirescouleur'] = 	TenueFemme["Accessories"].textureId})
end)

RegisterServerEvent("GTA:LoadVetement")
AddEventHandler("GTA:LoadVetement",function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("SELECT * FROM gta_joueurs_vetement WHERE license = @license", { ['@license'] = license}, function (res1)
		TriggerClientEvent("GTA:UpdateVetement", source ,{res1[1].topsID, res1[1].topsDraw, res1[1].topsCouleur, res1[1].undershirtsID, res1[1].undershirtsDraw, res1[1].undershirtsCouleur, res1[1].torsosID, res1[1].torsosDraw, res1[1].legsID, res1[1].legsDraw, res1[1].legsCouleur, res1[1].shoesID, res1[1].shoesDraw, res1[1].shoesCouleur, res1[1].AccessoiresID, res1[1].AccessoiresDraw, res1[1].AccessoiresCouleur, res1[1].HatsID, res1[1].HatsDraw, res1[1].HatsCouleurs})
	end)
end)


RegisterServerEvent("GTA:UpdateNom") --> Update votre nom de famille a la création d'identité.
AddEventHandler("GTA:UpdateNom", function(nameInput)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	local newName = nameInput
	if tostring(newName) == nil then
		return false
	end
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['nom'] = tostring(newName)}, {['license'] = license} })
end)

RegisterServerEvent("GTA:UpdatePrenom") --> Update votre prénom a la création d'identité.
AddEventHandler("GTA:UpdatePrenom", function(prenomInput)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	local newPrenom = prenomInput
	if tostring(newPrenom) == nil then
		return false
	end
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['prenom'] = tostring(newPrenom)}, {['license'] = license} })
end)

RegisterServerEvent("GTA:UpdateAge")  --> Update votre age a la création d'identité.
AddEventHandler("GTA:UpdateAge", function(ageInput)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	local newAge = ageInput
	if tonumber(ageInput) == nil then
      return false
	end
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['age'] = tostring(newAge)}, {['license'] = license} })
end)

RegisterServerEvent("GTA:UpdateTaille") --> Update votre taille exemple 180 = 1.80 metre a la création d'identié.
AddEventHandler("GTA:UpdateTaille", function(tailleInput)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	local newTaille = tailleInput
	if tonumber(tailleInput) == nil then
		return false
	end
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['taille'] = tostring(newTaille)}, {['license'] = license} })
end)


RegisterServerEvent("GTA:UpdateOrigin") --> Update votre orgine a la création d'identité.
AddEventHandler("GTA:UpdateOrigin", function(oriInput)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	local newName = oriInput
	if tostring(newName) == nil then
		return false
	end
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET ? WHERE ?", { {['origine'] = tostring(newName)}, {['license'] = license} })
end)