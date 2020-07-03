tenues_list = {}
identity_perso = {}

local topsID = 0; topsDraw = 0; topsCouleur = 0; torsosID = 0; torsosDraw = 0; undershirtsID = 0; undershirtsDraw = 0; legsID = 0;
local legsDraw = 0; legsCouleur = 0; shoesID = 0; shoesDraw = 0; AccessoiresID = 0; AccessoiresDraw = 0; AccessoiresCouleur = 0;

function fi(n)
	return n + 0.0001
end

function LocalPed()
	return GetPlayerPed(-1)
end

function SaisitText(actualtext, max)
    local text = ""
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TTTIP8", "", actualtext, "", "", "", max)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(10)
    end
    if (GetOnscreenKeyboardResult()) then
        text = GetOnscreenKeyboardResult()
    end
    return text
end

RegisterNetEvent("GTA:ChangerSex")
AddEventHandler("GTA:ChangerSex", function(skin)
	config.Sex = skin
end)

RegisterNetEvent("GTA:ChangerVisage")
AddEventHandler("GTA:ChangerVisage",function(aVisage)
	config.Visage = aVisage
end)

RegisterNetEvent("GTA:ChangerCouleurPeau")
AddEventHandler("GTA:ChangerCouleurPeau",function(aCPeau)
	config.Peau = aCPeau
end)

RegisterNetEvent("GTA:ChangerCoupeCheveux")
AddEventHandler("GTA:ChangerCoupeCheveux",function(aCheveux)
	config.Cheveux = aCheveux
end)

RegisterNetEvent("GTA:ChangerCouleurCheveux")
AddEventHandler("GTA:ChangerCouleurCheveux",function(aCCheveux)
	config.CouleurCheveux = aCCheveux
end)

RegisterNetEvent("GTA:UpdatePersonnage")
AddEventHandler("GTA:UpdatePersonnage",function(sex, visage, cheveux, cheveuxCouleur, couleurPeau)
	config.Sex = sex
	config.Visage = visage
    config.Cheveux = cheveux
	config.CouleurCheveux = cheveuxCouleur
	config.Peau = couleurPeau


	local modelhashed = GetHashKey(config.Sex)
	RequestModel(modelhashed)
	while not HasModelLoaded(modelhashed) do 
	    RequestModel(modelhashed)
	    Citizen.Wait(0)
	end
	SetPlayerModel(PlayerId(), modelhashed)
    SetModelAsNoLongerNeeded(modelhashed)
	TriggerServerEvent("GTA:LoadVetement")
	
	--print(config.Sex, config.Visage, config.Cheveux, config.CouleurCheveux, config.Peau)
	SetPedHeadBlendData(LocalPed(), config.Visage, config.Visage, config.Visage, config.Peau, config.Peau, config.Peau, 1.0, 1.0, 1.0, true)
	SetPedComponentVariation(LocalPed(), 2,tonumber(config.Cheveux),2,10)
	SetPedHairColor(LocalPed(), config.CouleurCheveux)
end)

RegisterNetEvent("GTA:UpdateVetement")
AddEventHandler("GTA:UpdateVetement",function(args)
	topsID = tonumber(args[1])
	topsDraw = tonumber(args[2])
	topsCouleur = tonumber(args[3])
	undershirtsID = tonumber(args[4])
	undershirtsDraw = tonumber(args[5])
	undershirtsCouleur = tonumber(args[6])
	torsosID = tonumber(args[7])
	torsosDraw = tonumber(args[8])
	legsID = tonumber(args[9])
	legsDraw = tonumber(args[10])
	legsCouleur = tonumber(args[11])
	shoesID = tonumber(args[12])
	shoesDraw = tonumber(args[13])
	shoesCouleur = tonumber(args[14])
	AccessoiresID = tonumber(args[15])
	AccessoiresDraw = tonumber(args[16])
	AccessoiresCouleur = tonumber(args[17])
	HatsID = tonumber(args[18])
	HatsDraw = tonumber(args[19])
	HatsCouleurs = tonumber(args[20])

	--print("Torse : ", torsosID, torsosDraw, 0)
	--print("Legs : ",  legsID, 	legsDraw, 	legsCouleur)
	--print("Shoes : ", shoesID, 	shoesDraw, 	shoesCouleur)
	--print("undershirts : ", undershirtsID, undershirtsDraw, undershirtsCouleur)
	--print("Tops : ", topsID, topsDraw, topsCouleur)
	--print("Hats : ", HatsID, HatsDraw, HatsCouleurs)

	SetPedComponentVariation(LocalPed(), tonumber(topsID), tonumber(topsDraw), tonumber(topsCouleur), 0)		
	SetPedComponentVariation(LocalPed(), tonumber(torsosID), tonumber(torsosDraw), 0, 0) 	
	SetPedComponentVariation(LocalPed(), tonumber(undershirtsID), tonumber(undershirtsDraw), 0, 0)
	SetPedComponentVariation(LocalPed(), tonumber(legsID), tonumber(legsDraw), tonumber(legsCouleur), 0)
	SetPedComponentVariation(LocalPed(), tonumber(shoesID), tonumber(shoesDraw), 0, 0)
	SetPedComponentVariation(LocalPed(), tonumber(AccessoiresID), tonumber(AccessoiresDraw), tonumber(AccessoiresCouleur), 0)
	SetPedPropIndex(LocalPed(), tonumber(HatsID), tonumber(HatsDraw), tonumber(HatsCouleurs), 0)
	SetPedComponentVariation(LocalPed(), 10, 0, 0, 2)
end)