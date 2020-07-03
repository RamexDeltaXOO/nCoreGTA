-----------------------------------------------------> INFO JOUEUR IDENTITER :
playerInfo = {
	sex = "",
	nom = "",
	prenom = "",
	age = "",
	origine = "",
	grade = "",
	argentPropre = 0,
	argentSale = 0,
	metiers = {}
}

local playerPed = nil
-----------------------------------------------------> TENUE JOUEUR :
RegisterNetEvent("GTA:GetSexJoueur")
AddEventHandler("GTA:GetSexJoueur", function(sex)
	playerInfo.sex = sex
end)

RegisterNetEvent("GTA:MettreHautJoueur")
AddEventHandler("GTA:MettreHautJoueur", function(args)
	local playerPed = GetPlayerPed(-1)

	SetPedComponentVariation(playerPed, args[1], args[2], args[3], 0) --> TopsID
	SetPedComponentVariation(playerPed, args[4], args[5], args[6], 0) --> Undershirt
	SetPedComponentVariation(playerPed, args[7], args[8], 0, 0) --> Torsos
end)

RegisterNetEvent("GTA:MettreBasJoueur")
AddEventHandler("GTA:MettreBasJoueur", function(args)
	local playerPed = GetPlayerPed(-1)
	SetPedComponentVariation(playerPed, args[1], args[2], args[3], 0) --> Legs
end)

RegisterNetEvent("GTA:MettreChaussureJoueur")
AddEventHandler("GTA:MettreChaussureJoueur", function(args)
	local playerPed = GetPlayerPed(-1)
	SetPedComponentVariation(playerPed, args[1], args[2], args[3], 0) --> Shoes
end)

RegisterNetEvent("GTA:MettreBonnetJoueur")
AddEventHandler("GTA:MettreBonnetJoueur", function(args)
	local playerPed = GetPlayerPed(-1)
	SetPedPropIndex(playerPed, args[1], args[2], args[3], 0) --> Hats
end)

RegisterNetEvent("GTA:RetirerHautJoueur")
AddEventHandler("GTA:RetirerHautJoueur", function()
	local playerPed = GetPlayerPed(-1)
	if playerInfo.sex == "mp_m_freemode_01" then
		SetPedComponentVariation(playerPed, 11, 15, 0, 0)
		SetPedComponentVariation(playerPed, 8, 15, 0, 0)
		SetPedComponentVariation(playerPed, 3, 15, 0, 0)
	else
		SetPedComponentVariation(playerPed, 11, 15, 0, 0)
		SetPedComponentVariation(playerPed, 8, 2, 0, 0)
		SetPedComponentVariation(playerPed, 3, 15, 0, 0)
	end
end)


RegisterNetEvent("GTA:RetirerBasJoueur")
AddEventHandler("GTA:RetirerBasJoueur", function()
	local playerPed = GetPlayerPed(-1)
	if playerInfo.sex == "mp_m_freemode_01" then
		SetPedComponentVariation(playerPed, 4, 14, 0, 0)
	else
		SetPedComponentVariation(playerPed, 4, 17, 0, 0)
	end
end)

RegisterNetEvent("GTA:RetirerChaussureJoueur")
AddEventHandler("GTA:RetirerChaussureJoueur", function()
	local playerPed = GetPlayerPed(-1)
	if playerInfo.sex == "mp_m_freemode_01" then
		SetPedComponentVariation(playerPed, 6, 34, 0, 0)
	else
		SetPedComponentVariation(playerPed, 6, 35, 0, 0)
	end
end)

RegisterNetEvent("GTA:RetirerBonnetJoueur")
AddEventHandler("GTA:RetirerBonnetJoueur", function()
	local playerPed = GetPlayerPed(-1)
	if playerInfo.sex == "mp_m_freemode_01" then
		SetPedPropIndex(playerPed, 0, 8, 0, 0)
	else
		SetPedPropIndex(playerPed, 0, 57, 0, 0)
	end
end)


-----------------------------------------------------------> ARGENT JOUEUR :
-->Event :
RegisterNetEvent("GTA:UpdateDirtyCash")
AddEventHandler("GTA:UpdateDirtyCash", function(dirtycash)
	dirtyMoney = dirtycash
end)

RegisterNetEvent('GTA:RegarderIdentiter')
AddEventHandler('GTA:RegarderIdentiter', function(pNom, pPrenom, pTravail, pAge, pOrigine, pGrade)
	active = true
	playerInfo.nom = tostring(pNom)
	playerInfo.prenom = tostring(pPrenom)
	playerInfo.metiers = tostring(pTravail)
	playerInfo.age = tonumber(pAge)
	playerInfo.origine = tostring(pOrigine)
	playerInfo.grade = tostring(pGrade)
end)


RegisterNetEvent('GTA:UpdateCash')
AddEventHandler('GTA:UpdateCash', function(argentSale, argentPropre)
	Cashactive = true
	playerInfo.argentPropre = tonumber(argentPropre)
	playerInfo.argentSale = tonumber(argentSale)
end)

RegisterNetEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
    TriggerServerEvent("bank:givecash", toPlayer, tonumber(amount))
end)

RegisterNetEvent('bank:givesale')
AddEventHandler('bank:givesale', function(toPlayer, amount)
  if(IsNearPlayer(toPlayer) == true) then
    local player2 = GetPlayerFromServerId(toPlayer)
    local playing = IsPlayerPlaying(player2)
    if (playing ~= false) then
      TriggerServerEvent("bank:givesale", toPlayer, tonumber(amount))
    else
		exports.nCoreGTA:nNotificationMain({
			text = "~r~ Aucune personne devant vous ~w~.",
			type = 'basGauche',
			nTimeNotif = 6000,
		})
    end
  end
end)