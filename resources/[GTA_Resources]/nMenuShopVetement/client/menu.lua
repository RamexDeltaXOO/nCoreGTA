--> Json config fichier :
local vetementConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/ConfigPos.json'))
local menuConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/ConfigMenu.json'))

--> Blips :
local VetementBlips = {};
local prixPantalon = 0;


--> MENU :
local vetementShops = {
	opened = false,
	title = "",
	currentmenu = "mainTshirtsHomme",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.1 + 0.03,
		y = 0.0 + 0.03,
		width = 0.2 + 0.02 + 0.005,
		height = 0.04,
		buttons = 30,
		from = 1,
		to = 10,
		scale = 0.3 + 0.05, --> Taille.
		font = 0,
		["mainTshirtsHomme"] = {
			title = "Tshirts",
			name = "mainTshirtsHomme",
			buttons = {
				{name = "Torse nue", topsID = '11', topsDraw = '15', topsCouleur = '0', torsosID = '3', torsosDraw = '15', undershirtsID = '8', undershirtsDraw = '15', prix = 0},
				{name = "Tshirt gris", topsID = '11', topsDraw = '1',   	 topsCouleur = '1',	torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Tshirt jaune", topsID = '11', topsDraw = '71',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Tshirt angel", topsID = '11', topsDraw = '73',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Tshirt gris délavé", topsID = '11', topsDraw = '97',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Tshirt noir avec poche", topsID = '11', topsDraw = '226', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Tshirt bleu", topsID = '11', topsDraw = '271', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo blanc avec rayure", topsID = '11', topsDraw = '9',   	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Polo rouge avec rayure", topsID = '11', topsDraw = '39',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo vert sortit", topsID = '11', topsDraw = '93', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo vert rentrer", topsID = '11', topsDraw = '94',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo liberty sortit", topsID = '11', topsDraw = '131', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo liberty rentrer", topsID = '11', topsDraw = '132', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo avec poche", topsID = '11', topsDraw = '123', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo gris rouge sortit", topsID = '11', topsDraw = '235', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo gris rouge rentrer", topsID = '11', topsDraw = '236', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo gris foncer sortit", topsID = '11', topsDraw = '241', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Polo gris foncer rentrer", topsID = '11', topsDraw = '242', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Maillot noir", topsID = '11', topsDraw = '81',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Maillot blanc", topsID = '11', topsDraw = '80',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Maillot vert", topsID = '11', topsDraw = '128', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Maillot gris", topsID = '11', topsDraw = '82',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Maillot a bouton", topsID = '11', topsDraw = '83',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Maillot burger", topsID = '11', topsDraw = '282', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Maillot noir a boutons", topsID = '11', topsDraw = '164', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
				{name = "Maillot blanc avec motif", topsID = '11', topsDraw = '193', 	 topsCouleur = '0',torsosID = '3', torsosDraw = '0',  undershirtsID = '8', undershirtsDraw = ' 15', prix = 300},
			}
		},

		["mainTshirtsFemme"] = {
			title = "Tshirts",
			name = "mainTshirtsFemme",
			buttons = {
				{name = "Torse nue", topsID = '11', topsDraw = '15', topsCouleur = '0', torsosID = '3', torsosDraw = '15', undershirtsID = '8', undershirtsDraw = '2', prix = 0},
				{name = "Debardeur rose", topsID = '11', topsDraw = '16',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '15', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Tshirt noir avec poche", topsID = '11', topsDraw = '236',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Tshirt gris délavé", topsID = '11', topsDraw = '49',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Tshirt angel", topsID = '11', topsDraw = '68',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Tshirt blanc", topsID = '11', topsDraw = '73',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Tshirt gris", topsID = '11', topsDraw = '88',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Tshirt bleu sortit", topsID = '11', topsDraw = '141',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Tshirt bleu rentrer", topsID = '11', topsDraw = '281',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Polo vert sortit", topsID = '11', topsDraw = '84',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Polo vert rentrer", topsID = '11', topsDraw = '85',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Polo gris rouge", topsID = '11', topsDraw = '246',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Polo gris foncé sortit", topsID = '11', topsDraw = '249',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Polo gris foncé rentrer", topsID = '11', topsDraw = '250',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Polo blanc avec poches", topsID = '11', topsDraw = '119',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Polo liberty sortit", topsID = '11', topsDraw = '128',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Polo liberty rentrer", topsID = '11', topsDraw = '129',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Maillot gris a bouton", topsID = '11', topsDraw = '76',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '11', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Maillot noir avec bouton", topsID = '11', topsDraw = '161',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Maillot burger", topsID = '11', topsDraw = '295',  	 topsCouleur = '0',torsosID = '3', torsosDraw = '14', undershirtsID = '8', undershirtsDraw = '7', prix = 300},
			}
		},

		["mainVesteHomme"] = {
			title = "Vestes",
			name = "mainVesteHomme",
			buttons = {
				{name = "Vestes blanc légère", topsID = '11', topsDraw = '3', 	topsCouleur = '0', 	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes chic noir ouvert", topsID = '11', topsDraw = '4', 	topsCouleur = '0', 	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes chic noir fermer", topsID = '11', topsDraw = '10',	topsCouleur = '0',	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Veste de motar noir et gris", topsID = '11', topsDraw = '6', 	topsCouleur = '0', 	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes blanc sportife", topsID = '11', topsDraw = '7', 	topsCouleur = '0', 	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes blanc chic fermer", topsID = '11', topsDraw = '20',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes vert chic ouvert", topsID = '11', topsDraw = '23',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes gris chic fermer", topsID = '11', topsDraw = '24',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes noir classe ouvert", topsID = '11', topsDraw = '35',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes de motar marron", topsID = '11', topsDraw = '37',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes de show", topsID = '11', topsDraw = '46',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes basic gris fermer", topsID = '11', topsDraw = '57',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Vestes en cuir stylé noir ouvert", topsID = '11', topsDraw = '62',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes en cuir noir fermer", topsID = '11', topsDraw = '64',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes en cuir avec capuche mise", topsID = '11', topsDraw = '68',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes en cuir avec capuche", topsID = '11', topsDraw = '69', 	topsCouleur = '0', 	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes marron avec motif ouvert", topsID = '11', topsDraw = '74', 	topsCouleur = '0', 	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes marron avec motif fermer", topsID = '11', topsDraw = '75', 	topsCouleur = '0', 	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau marron avec fourrure", topsID = '11', topsDraw = '70',  	topsCouleur = '0',	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau chic jaune", topsID = '11', topsDraw = '72', 	topsCouleur = '0', 	torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau chic avec bouton fermer", topsID = '11', topsDraw = '76',	topsCouleur = '0',  torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
			}
		},

		["mainSousVesteHomme"] = {
			title = "Sous Vestes",
			name = "mainSousVesteHomme",
			buttons = {
				{name = "Rien", topsID = '11', topsDraw = '57',  		topsCouleur = '0', torsosID = '3', torsosDraw = '6',   undershirtsID = '8', undershirtsDraw = '15', prix = 0},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '3', 	topsCouleur = '0', torsosID = '3', torsosDraw = '15',   undershirtsID = '8', undershirtsDraw = '3', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '9',  	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '16', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 9', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '39', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 10', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '71', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 12', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '73', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 13', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '81', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 16', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '80', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 17', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '82', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 21', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '83', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 25', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '93', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 37', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '94', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 38', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '97', 	topsCouleur = '0', torsosID = '3', torsosDraw = '1',   undershirtsID = '8', undershirtsDraw = ' 40', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '123',	topsCouleur = '0', torsosID = '3', torsosDraw = '1',  undershirtsID = '8', undershirtsDraw = ' 41', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '128',	topsCouleur = '0', torsosID = '3', torsosDraw = '1',  undershirtsID = '8', undershirtsDraw = ' 42', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '131',	topsCouleur = '0', torsosID = '3', torsosDraw = '1',  undershirtsID = '8', undershirtsDraw = ' 43', prix = 300},
			}
		},

		["mainVesteFemme"] = {
			title = "Vestes",
			name = "mainVesteFemme",
			buttons = {
				{name = "Vestes blanc légère", topsID = '11', topsDraw = '3', topsCouleur = '0',  torsosID = '3', torsosDraw = '3',  undershirtsID = '8', undershirtsDraw = '6', prix = 300},
				{name = "Vestes classe noir fermer", topsID = '11', topsDraw = '6', topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes chic noir ouvert", topsID = '11', topsDraw = '7', topsCouleur = '0',  torsosID = '3', torsosDraw = '6',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes de survette fermer", topsID = '11', topsDraw = '10',topsCouleur = '0',  torsosID = '3', torsosDraw = '6',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes chic rouge ouvert", topsID = '11', topsDraw = '25',topsCouleur = '0',  torsosID = '3', torsosDraw = '6',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes chic militaire ouvert", topsID = '11', topsDraw = '34',topsCouleur = '0',  torsosID = '3', torsosDraw = '6',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes basic gris foncé fermer", topsID = '11', topsDraw = '50',topsCouleur = '0',  torsosID = '3', torsosDraw = '3',  undershirtsID = '8', undershirtsDraw = '6', prix = 300},
				{name = "Vestes chic longue gris ouvert", topsID = '11', topsDraw = '51',topsCouleur = '0',  torsosID = '3', torsosDraw = '6',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes chic grise ouvert", topsID = '11', topsDraw = '52',topsCouleur = '0',  torsosID = '3', torsosDraw = '6',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes chic grise fermer", topsID = '11', topsDraw = '53',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes cuir grise fermer", topsID = '11', topsDraw = '55',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes noir avec capuche mise", topsID = '11', topsDraw = '62',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes noir avec capuche", topsID = '11', topsDraw = '63',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes noir avec ceinture fermer ", topsID = '11', topsDraw = '69',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Vestes de football rouge", topsID = '11', topsDraw = '72',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau blanc avec bouton", topsID = '11', topsDraw = '64',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau avec fourrure fermer", topsID = '11', topsDraw = '65',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau blanc ceinture fermer", topsID = '11', topsDraw = '70',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau blanc simple ouvert", topsID = '11', topsDraw = '90',topsCouleur = '0',  torsosID = '3', torsosDraw = '6',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau blanc simple fermer", topsID = '11', topsDraw = '91',topsCouleur = '0',  torsosID = '3', torsosDraw = '6',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau violet simple ouvert", topsID = '11', topsDraw = '92',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
				{name = "Manteau violet simple fermer", topsID = '11', topsDraw = '93',topsCouleur = '0',  torsosID = '3', torsosDraw = '5',  undershirtsID = '8', undershirtsDraw = '5', prix = 300},
			}
		},

		["mainSousVesteFemme"] = {
			title = "Sous Vestes",
			name = "mainSousVesteFemme",
			buttons = {
				{name = "Rien", topsID = '11', topsDraw = '3', 			topsCouleur = '0', torsosID = '3', torsosDraw = '3',   undershirtsID = '8', undershirtsDraw = '6', prix = 0},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '9', 	topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '37', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '16', 	topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '39', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '39',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '40', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '71',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '45', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '73',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '51', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '81',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '57', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '80',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '61', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '82',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '64', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '83',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '72', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '93',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '101', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '94',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '102', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '94',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '106', prix = 300},
				{name = "Sous-Vestes", topsID = '11', topsDraw = '94',  topsCouleur = '0', torsosID = '3', torsosDraw = '0',   undershirtsID = '8', undershirtsDraw = '147', prix = 300},
			}
		},

		["mainPantalonHomme"] = {
			title = "Pantalon",
			name = "mainPantalonHomme",
			buttons = {
				{name = "Jean bleu large", legsID = '4', legsDraw = '0',  legsCouleur = '0', prix = 300},
				{name = "Jean gris large", legsID = '4', legsDraw = '1',  legsCouleur = '0', prix = 300},
				{name = "Pantalon de survet blanc", legsID = '4', legsDraw = '3',  legsCouleur = '0', prix = 300},
				{name = "Pantalon de survet large blanc", legsID = '4', legsDraw = '5',  legsCouleur = '0', prix = 300},
				{name = "Short blanc", legsID = '4', legsDraw = '6',  legsCouleur = '0', prix = 300},
				{name = "Pantalon noir large", legsID = '4', legsDraw = '7',  legsCouleur = '0', prix = 300},
			}
		},

		["mainPantalonFemme"] = {
			title = "Pantalon",
			name = "mainPantalonFemme",
			buttons = {
				{name = "Jean bleu", legsID = '4', legsDraw = '0',  legsCouleur = '0', prix = 300},
				{name = "Pantalon court gris", legsID = '4', legsDraw = '2',  legsCouleur = '1', prix = 300},
				{name = "Pantalon noir", legsID = '4', legsDraw = '3',  legsCouleur = '0', prix = 300},
				{name = "Jean noir délavé court", legsID = '4', legsDraw = '4',  legsCouleur = '0', prix = 300},
				{name = "Pantalon noir chic", legsID = '4', legsDraw = '6',  legsCouleur = '0', prix = 300},
				{name = "Pantalon blanc chic", legsID = '4', legsDraw = '24', legsCouleur = '0', prix = 300},
				{name = "Jupe", legsID = '4', legsDraw = '7',  legsCouleur = '0', prix = 300},
				{name = "Jupe court", legsID = '4', legsDraw = '8',  legsCouleur = '0', prix = 300},
				{name = "short blanc bleu", legsID = '4', legsDraw = '10', legsCouleur = '0', prix = 300},
				{name = "Pantalon sauté", legsID = '4', legsDraw = '11', legsCouleur = '0', prix = 300},
				{name = "Jupe court avec rayure", legsID = '4', legsDraw = '12', legsCouleur = '0', prix = 300},
				{name = "short jean bleu", legsID = '4', legsDraw = '18', legsCouleur = '0', prix = 300},
				{name = "Jupe rouge", legsID = '4', legsDraw = '23', legsCouleur = '0', prix = 300},
				{name = "Court short jean", legsID = '4', legsDraw = '25', legsCouleur = '0', prix = 300},
				{name = "Leggins noir", legsID = '4', legsDraw = '27', legsCouleur = '0', prix = 300},
				{name = "Jupe rose rayure", legsID = '4', legsDraw = '28', legsCouleur = '0', prix = 300},
				{name = "Pantalon noir", legsID = '4', legsDraw = '30', legsCouleur = '0', prix = 300},
			}
		},

		["mainPullHomme"] = {
			title = "Pull",
			name = "mainPullHomme",
			buttons = {
				{name = "Sweet blanc avec motif", topsID = '11', topsDraw = '84', topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull marron avec motif", topsID = '11', topsDraw = '78', topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull noir avec capuche", topsID = '11', topsDraw = '86', topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull noir basic", topsID = '11', topsDraw = '89', topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull bleu foot avec capuche", topsID = '11', topsDraw = '96', topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Col roulé gris", topsID = '11', topsDraw = '111',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull avec motif gris", topsID = '11', topsDraw = '121',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull gris foncé avec motif", topsID = '11', topsDraw = '190',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull gris avec motif", topsID = '11', topsDraw = '196',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull jaune avec capuche", topsID = '11', topsDraw = '200',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull jaune avec capuche mise", topsID = '11', topsDraw = '203',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull bleu motif militaire", topsID = '11', topsDraw = '220',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull chaud", topsID = '11', topsDraw = '244',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull vert avec motif", topsID = '11', topsDraw = '245',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull chaud avec capuche", topsID = '11', topsDraw = '251',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull chaud avec capuche mise", topsID = '11', topsDraw = '253',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull blanc avec motif", topsID = '11', topsDraw = '255',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull bleu avec motif", topsID = '11', topsDraw = '259',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull gris foncé avec capuche", topsID = '11', topsDraw = '262',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull gris foncé avec capuche mise", topsID = '11', topsDraw = '263',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull blanc avec capuche + motif", topsID = '11', topsDraw = '279',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
				{name = "Pull blanc avec capuche mise", topsID = '11', topsDraw = '280',topsCouleur = '0', torsosID = '3', torsosDraw = '4',   undershirtsID = '8', undershirtsDraw = '15', prix = 300},
			}
		},

		["mainPullFemme"] = {
			title = "Pull",
			name = "mainPullFemme",
			buttons = {
				{name = "Pull marron avec motif", topsID = '11', topsDraw = '71', topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull noir avec capuche", topsID = '11', topsDraw = '78', topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull noir basic", topsID = '11', topsDraw = '79', topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull bleu foot avec capuche", topsID = '11', topsDraw = '87', topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull gris avec capuche + motif", topsID = '11', topsDraw = '123',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull liberty noir", topsID = '11', topsDraw = '131',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Sweet rose avec motif", topsID = '11', topsDraw = '149',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull gris avec motif", topsID = '11', topsDraw = '192',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull gris claire motif", topsID = '11', topsDraw = '198',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull jaune avec capuche", topsID = '11', topsDraw = '202',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull jaune avec capuche mise", topsID = '11', topsDraw = '205',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull chaud", topsID = '11', topsDraw = '252',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull vert avec motif", topsID = '11', topsDraw = '253',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull chaud avec capuche", topsID = '11', topsDraw = '261',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Sweet blanc avec motif", topsID = '11', topsDraw = '264',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull bleu avec motif", topsID = '11', topsDraw = '268',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull gris foncé avec capuche", topsID = '11', topsDraw = '271',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull gris foncé avec capuche mise", topsID = '11', topsDraw = '272',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull blanc avec capuche + motif", topsID = '11', topsDraw = '292',topsCouleur = '0',  torsosID = '3', torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
				{name = "Pull blanc avec capuche mise", topsID = '11', topsDraw = '293',topsCouleur = '0',  torsosID = '3',	torsosDraw = '9',   undershirtsID = '8', undershirtsDraw = '7', prix = 300},
			}
		},

		
		["mainChaussureHomme"] = {
			title = "Chaussure",
			name = "mainChaussureHomme",
			buttons = {
				{name = "Pied Nue",  shoesID = '6', shoesDraw = '34', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '1', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '3', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '4', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '5', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '6', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '7', prix = 300},
			}
		},

		["mainChaussureFemme"] = {
			title = "Chaussure",
			name = "mainChaussureFemme",
			buttons = {
				{name = "Pied Nue",  shoesID = '6', shoesDraw = '35',prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '1', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '2', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '3', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '4', prix = 300},
				{name = "Chaussure", shoesID = '6', shoesDraw = '5', prix = 300},
			}
		},

		["mainAccessoiresHomme"] = {
			title = "Accessoires",
			name = "mainAccessoiresHomme",
			buttons = {
				{name = "Rien", AccessoiresID = '7', AccessoiresDraw = '96', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '10', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '11', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '12', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '18', prix = 300},
			}
		},

		["mainAccessoiresFemme"] = {
			title = "Accessoires",
			name = "mainAccessoiresFemme",
			buttons = {
				{name = "Rien", AccessoiresID = '7', AccessoiresDraw = '0', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '3', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '5', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '9', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '10', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '13', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '15', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '17', prix = 300},
				{name = "Accessoires", AccessoiresID = '7', AccessoiresDraw = '19', prix = 300},
			}
		},

		["mainChapeauHomme"] = {
			title = "Chapeau",
			name = "mainChapeauHomme",
			buttons = {
				{name = "Rien", HatsID = '0', HatsDraw = '8', prix = 300},
				{name = "Bonnet noir", HatsID = '0', HatsDraw = '2', prix = 300},
				{name = "Casquette noir LS", HatsID = '0', HatsDraw = '4', prix = 300},
				{name = "Beret blanc", HatsID = '0', HatsDraw = '7', prix = 300},
				{name = "Chapeau noir", HatsID = '0', HatsDraw = '12', prix = 300},
				{name = "Chapeau cowbow", HatsID = '0', HatsDraw = '13', prix = 300},
				{name = "Bandana", HatsID = '0', HatsDraw = '14', prix = 300},
			}
		},

		["mainChapeauFemme"] = {
			title = "Chapeau",
			name = "mainChapeauFemme",
			buttons = {
				{name = "Rien", HatsID = '0', HatsDraw = '57', prix = 300},
				{name = "Casquette noir los santos", HatsID = '0', HatsDraw = '4', prix = 300},
				{name = "Bonnet noir", HatsID = '0', HatsDraw = '5', prix = 300},
				{name = "Beret bleu", HatsID = '0', HatsDraw = '7', prix = 300},
				{name = "Chapeau beige", HatsID = '0', HatsDraw = '13', prix = 300},
				{name = "Chapeau cowbow", HatsID = '0', HatsDraw = '20', prix = 300},
				{name = "Casquette a l'enver rouge", HatsID = '0', HatsDraw = '44', prix = 300},
			}
		},

		["menuValiderPaiement"] = {
			title = "Paiement",
			name = "menuValiderPaiement",
			buttons = {
				{name = "Valider cette achat"},
				{name = "Retour"},
			}
		},
  	}
}

--[[
local function GetPlayerModel(modelhash)
	local playerPed = PlayerPedId()

	if IsModelValid(modelhash) then
		if not IsPedModel(playerPed, modelHash) then
			RequestModel(modelhash)
			while not HasModelLoaded(modelhash) do
				Wait(500)
			end

			SetPlayerModel(PlayerId(), modelhash)
		end

		SetPedHeadBlendData(PlayerPedId(), 0, math.random(45), 0,math.random(45), math.random(5), math.random(5),1.0,1.0,1.0,true)
		SetPedHairColor(PlayerPedId(), math.random(1, 4), 1)
		
		if IsPedMale(PlayerPedId()) then
			SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)		
		else
			SetPedComponentVariation(PlayerPedId(), 8, 2, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0)
			SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)
		end

		SetModelAsNoLongerNeeded(modelhash)
	end
end

RegisterCommand("femme", function(source, args, rawCommand)
	GetPlayerModel("mp_f_freemode_01")
end, false)


RegisterCommand("homme", function(source, args, rawCommand)
	GetPlayerModel("mp_m_freemode_01")
end, false)
--]]

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

function CloseCreator()
	Citizen.CreateThread(function()
		vetementShops.opened = false
		vetementShops.menu.from = 1
		vetementShops.menu.to = 10
	end)
end

function OpenMainPersonnage(open_menu)
	CloseCreator()
	Wait(150)
	if not HasStreamedTextureDictLoaded("ninja_source") then
        RequestStreamedTextureDict("ninja_source", true)
    end

    scaleform = RequestScaleformMovie("mp_menu_glare")
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "initScreenLayout")
    PopScaleformMovieFunctionVoid()
	vetementShops.opened = true
	vetementShops.currentmenu = open_menu
	vetementShops.selectedbutton = 1
end


function drawMenuButton(button,x,y,selected)
	local menu = vetementShops.menu

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

function DrawTextMenu(fonteP, stringT, scale, posX, posY)
    SetTextFont(fonteP)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(stringT)
    DrawText(posX, posY)
end


function drawMenuTitle(txt,x,y)
	local menu = vetementShops.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	for i=1, #menuConfig do 
		DrawRect(x,y,menu.width,menu.height, menuConfig[i].couleurTopMenu.r, menuConfig[i].couleurTopMenu.g, menuConfig[i].couleurTopMenu.b, menuConfig[i].couleurTopMenu.a)
	end
	DrawTextMenu(1, txt, 0.8,menu.width - 0.4 / 2 + 0.1 + 0.005, y - menu.height/2 + 0.01, 255, 255, 255)
    DrawSprite("ninja_source", "interaction_bgd", x,y, menu.width,menu.height + 0.04 + 0.007, .0, 255, 255, 255, 255)
    DrawScaleformMovie(scaleform, 0.42 + 0.003,0.45, 0.9,0.9)
end


function tablelength(T)
	local count = 0
	for _ in pairs(T) do 
		count = count + 1 
	end
	return count
end

function drawTxt(k,l,m,n,o,p,q,r,s,t)
	SetTextFont(l)
	SetTextProportional(0)
	SetTextScale(p,p)
	SetTextColour(q,r,s,t)
	SetTextDropShadow(0,0,0,0,255)
	SetTextEdge(1,0,0,0,255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(m)
	SetTextEntry("STRING")
	AddTextComponentString(k)
	DrawText(n,o)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local myPos = GetEntityCoords(GetPlayerPed(-1))
		for _,v in ipairs(vetementConfig) do
			if getDistance(myPos, v.TeeShirtPos) < 2 then
				if GetLastInputMethod(0) then
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Tshirt")
				else
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Tshirt")
				end
				
				if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
					TriggerEvent("GTA:GetSexPlayer")
					if Sex == "mp_m_freemode_01" then
						OpenMainPersonnage("mainTshirtsHomme")
					else
						OpenMainPersonnage("mainTshirtsFemme")
					end
				end
			elseif getDistance(myPos, v.PullPos) < 2 then 
				if GetLastInputMethod(0) then
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Pulls")
				else
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Pulls")
				end
				
				if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
					TriggerEvent("GTA:GetSexPlayer")
					if Sex == "mp_m_freemode_01" then
						OpenMainPersonnage("mainPullHomme")
					else
						OpenMainPersonnage("mainPullFemme")
					end
				end
			elseif getDistance(myPos, v.VestePos) < 2 then 
				if GetLastInputMethod(0) then
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Vestes")
				else
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Vestes")
				end
				
				if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
					TriggerEvent("GTA:GetSexPlayer")

					if Sex == "mp_m_freemode_01" then
						OpenMainPersonnage("mainVesteHomme")
					else
						OpenMainPersonnage("mainVesteFemme")
					end
				end
			elseif getDistance(myPos, v.PantalonPos) < 2 then
				if GetLastInputMethod(0) then
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Pantalons")
				else
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Pantalons")
				end
				
				if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
					TriggerEvent("GTA:GetSexPlayer")
					TriggerEvent("GTA:SetCamPantalon")
					if Sex == "mp_m_freemode_01" then
						OpenMainPersonnage("mainPantalonHomme")
					else
						TriggerServerEvent("GTA:LoadVetement")
						OpenMainPersonnage("mainPantalonFemme")
					end
				end
			elseif getDistance(myPos, v.ChaussuresPos) < 2 then 
				if GetLastInputMethod(0) then
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Chaussures")
				else
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Chaussures")
				end
				
				if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
					TriggerEvent("GTA:GetSexPlayer")
					TriggerEvent("GTA:SetCamShoes")
					if Sex == "mp_m_freemode_01" then
						OpenMainPersonnage("mainChaussureHomme")
					else
						OpenMainPersonnage("mainChaussureFemme")
					end
				end
			elseif getDistance(myPos, v.AccessoiresPos) < 2 then 
				if GetLastInputMethod(0) then
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Accessoires")
				else
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Accessoires")
				end
				
				if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
					TriggerEvent("GTA:GetSexPlayer")

					if Sex == "mp_m_freemode_01" then
						OpenMainPersonnage("mainAccessoiresHomme")
					else
						OpenMainPersonnage("mainAccessoiresFemme")
					end
				end
			elseif getDistance(myPos, v.ChapeauPos) < 2 then
				if GetLastInputMethod(0) then
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Chapeau")
				else
					Ninja_Core__DisplayHelpAlert("~INPUT_TALK~ pour ouvrir le catalogue des ~b~Chapeau")
				end
				
				if (IsControlJustReleased(0, 54) or IsControlJustReleased(0, 175)) then
					TriggerEvent("GTA:GetSexPlayer")

					if Sex == "mp_m_freemode_01" then
						OpenMainPersonnage("mainChapeauHomme")
					else
						OpenMainPersonnage("mainChapeauFemme")
					end
				end
			end
		end
	end
end)


local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if vetementShops.opened then

			local menu = vetementShops.menu[vetementShops.currentmenu]
			local y = vetementShops.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			drawMenuTitle(menu.title, vetementShops.menu.x,vetementShops.menu.y + 0.08)
			drawTxt(vetementShops.selectedbutton.."/"..buttoncount,0,0,vetementShops.menu.x+vetementShops.menu.width/2-0.0385,vetementShops.menu.y+0.067,0.4,255,255,255,255)
			local selected = false
			for i,button in pairs(menu.buttons) do
				if i >= vetementShops.menu.from and i <= vetementShops.menu.to then
					if i == vetementShops.selectedbutton then
						selected = true

						if Sex == "mp_m_freemode_01" then
							
							if vetementShops.currentmenu == "mainPantalonHomme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.legsID), tonumber(button.legsDraw), tonumber(button.legsCouleur), 0)
							end

							if vetementShops.currentmenu == "mainTshirtsHomme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)
								SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0)
								SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
							end
							
							if vetementShops.currentmenu == "mainVesteHomme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)
								SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 
								SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
							end

							if vetementShops.currentmenu == "mainSousVesteHomme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
							end

							if vetementShops.currentmenu == "mainPullHomme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)
								SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 	
								SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
							end

							if vetementShops.currentmenu == "mainChaussureHomme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.shoesID), tonumber(button.shoesDraw), 0, 0)
							end

							if vetementShops.currentmenu == "mainAccessoiresHomme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.AccessoiresID), tonumber(button.AccessoiresDraw), 0, 0)	
							end

							if vetementShops.currentmenu == "mainChapeauHomme" then
								SetPedPropIndex(LocalPed(), tonumber(button.HatsID), tonumber(button.HatsDraw), 0, 0)
							end
						else
							if vetementShops.currentmenu == "mainTshirtsFemme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)
								SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 	
								SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
							end
							
							if vetementShops.currentmenu == "mainVesteFemme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)
								SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 
								SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
							end

							if vetementShops.currentmenu == "mainSousVesteFemme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
							end

							if vetementShops.currentmenu == "mainPullFemme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)		
								SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 	
								SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
							end

							if vetementShops.currentmenu == "mainPantalonFemme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.legsID), tonumber(button.legsDraw), tonumber(button.legsCouleur))	
							end

							if vetementShops.currentmenu == "mainChaussureFemme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.shoesID), tonumber(button.shoesDraw), 0, 0)	
							end

							if vetementShops.currentmenu == "mainAccessoiresFemme" then
								SetPedComponentVariation(LocalPed(), tonumber(button.AccessoiresID), tonumber(button.AccessoiresDraw), 0, 0)	
							end

							if vetementShops.currentmenu == "mainChapeauFemme" then
								SetPedPropIndex(LocalPed(), tonumber(button.HatsID), tonumber(button.HatsDraw), 0, 0)
							end
						end
					else
						selected = false
					end
				drawMenuButton(button,vetementShops.menu.x,y + 0.02 + 0.003,selected)
				y = y + 0.04
					if selected and IsControlJustPressed(1,201) then
						PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
						ButtonSelected(button)
					end
				end
			end
		end

		if vetementShops.opened then
			if IsControlJustPressed(1,177) then
				Back()
			end
			
			if IsControlJustReleased(1,202) then
				backlock = false
			end

			if IsControlJustPressed(1,188) then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if vetementShops.selectedbutton > 1 then
					vetementShops.selectedbutton = vetementShops.selectedbutton -1
					if buttoncount > 10 and vetementShops.selectedbutton < vetementShops.menu.from then
						vetementShops.menu.from = vetementShops.menu.from -1
						vetementShops.menu.to = vetementShops.menu.to - 1
					end
				end
			end

			if IsControlJustPressed(1,187)then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
				if vetementShops.selectedbutton < buttoncount then
					vetementShops.selectedbutton = vetementShops.selectedbutton +1
					if buttoncount > 10 and vetementShops.selectedbutton > vetementShops.menu.to then
						vetementShops.menu.to = vetementShops.menu.to + 1
						vetementShops.menu.from = vetementShops.menu.from + 1
					end
				end
			end
		end
   	end
end)

function ButtonSelected(button)
	if Sex == "mp_m_freemode_01" then
		if vetementShops.currentmenu == "mainTshirtsHomme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)
			SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0)
			SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateTShirtVestePull", tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), tonumber(button.torsosID), tonumber(button.torsosDraw), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), tonumber(button.prix))
			CloseCreator()
		end

		if vetementShops.currentmenu == "mainVesteHomme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)
			SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 	
			SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateTShirtVestePull", tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), tonumber(button.torsosID), tonumber(button.torsosDraw), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), tonumber(button.prix))
			OpenMainPersonnage("mainSousVesteHomme")
		end

		if vetementShops.currentmenu == "mainSousVesteHomme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
			
			if IsControlJustPressed(1,201) then
				TriggerServerEvent("GTA:UpdateSousVeste",tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), tonumber(button.prix))
				CloseCreator()
			end
		end

		if vetementShops.currentmenu == "mainPullHomme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)	
			SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 	
			SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateTShirtVestePull", tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), tonumber(button.torsosID), tonumber(button.torsosDraw), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), tonumber(button.prix))
			CloseCreator()
		end

		if vetementShops.currentmenu == "mainPantalonHomme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.legsID), tonumber(button.legsDraw), tonumber(button.legsCouleur))
			prixPantalon = button.prix
			pantalonID = button.legsID
			pantalonDraw = button.legsDraw
			pantalonCouleur = button.legsCouleur
			OpenMainPersonnage("menuValiderPaiement")
		end

		if vetementShops.currentmenu == "menuValiderPaiement" then
			if button.name == "Valider cette achat" then
				if IsControlJustPressed(1,201) then
					CloseCreator()
					TriggerServerEvent("GTA:UpdatePantalonShop", pantalonID, pantalonDraw, pantalonCouleur, prixPantalon)
				end
			elseif button.name == "Retour" then
				if IsControlJustPressed(1,201) then
					OpenMainPersonnage("mainPantalonHomme")
				end
			end
		end

		if vetementShops.currentmenu == "mainChaussureHomme" then
			TriggerEvent("GTA:DeleteCam")
			SetPedComponentVariation(LocalPed(), tonumber(button.shoesID), tonumber(button.shoesDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateChaussure", tonumber(button.shoesID), tonumber(button.shoesDraw), tonumber(button.prix))
		end

		if vetementShops.currentmenu == "mainAccessoiresHomme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.AccessoiresID), tonumber(button.AccessoiresDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateAccessoires", tonumber(button.AccessoiresID), tonumber(button.AccessoiresDraw), tonumber(button.prix))
		end

		if vetementShops.currentmenu == "mainChapeauHomme" then
			SetPedPropIndex(LocalPed(), tonumber(button.HatsID), tonumber(button.HatsDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateChapeau", tonumber(button.HatsID), tonumber(button.HatsDraw), tonumber(button.prix))
		end
	else
		if vetementShops.currentmenu == "mainTshirtsFemme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)	
			SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 	
			SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateTShirtVestePull", tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), tonumber(button.torsosID), tonumber(button.torsosDraw), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), tonumber(button.prix))
			TriggerEvent("GTA_Vetement:ChargerTenuePerso")
		end

		if vetementShops.currentmenu == "mainVesteFemme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)	
			SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 	
			SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateTShirtVestePull", tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), tonumber(button.torsosID), tonumber(button.torsosDraw), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), tonumber(button.prix))
			OpenMainPersonnage("mainSousVesteFemme")
		end

		if vetementShops.currentmenu == "mainSousVesteFemme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
			
			if IsControlJustPressed(1,201) then
				TriggerServerEvent("GTA:UpdateSousVeste",tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), tonumber(button.prix))
				CloseCreator()
			end
		end

		if vetementShops.currentmenu == "mainPullFemme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), 0)	
			SetPedComponentVariation(LocalPed(), tonumber(button.torsosID), tonumber(button.torsosDraw), 0, 0) 	
			SetPedComponentVariation(LocalPed(), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateTShirtVestePull", tonumber(button.topsID), tonumber(button.topsDraw), tonumber(button.topsCouleur), tonumber(button.torsosID), tonumber(button.torsosDraw), tonumber(button.undershirtsID), tonumber(button.undershirtsDraw), tonumber(button.prix))
			TriggerEvent("GTA_Vetement:ChargerTenuePerso")
		end

		if vetementShops.currentmenu == "mainPantalonFemme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.legsID), tonumber(button.legsDraw), tonumber(button.legsCouleur))
			prixPantalon = button.prix
			pantalonID = button.legsID
			pantalonDraw = button.legsDraw
			pantalonCouleur = button.legsCouleur
			OpenMainPersonnage("menuValiderPaiement")
		end

		if vetementShops.currentmenu == "menuValiderPaiement" then
			if button.name == "Valider cette achat" then
				if IsControlJustPressed(1,201) then
					TriggerEvent("GTA:DeleteCam")
					CloseCreator()
					TriggerServerEvent("GTA:UpdatePantalonShop", pantalonID, pantalonDraw, pantalonCouleur, prixPantalon)
				end
			elseif button.name == "Retour" then
				if IsControlJustPressed(1,201) then
					OpenMainPersonnage("mainPantalonFemme")
				end
			end
		end

		if vetementShops.currentmenu == "mainChaussureFemme" then
			TriggerEvent("GTA:DeleteCam")
			SetPedComponentVariation(LocalPed(), tonumber(button.shoesID), tonumber(button.shoesDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateChaussure", tonumber(button.shoesID), tonumber(button.shoesDraw), tonumber(button.prix))
		end

		if vetementShops.currentmenu == "mainAccessoiresFemme" then
			SetPedComponentVariation(LocalPed(), tonumber(button.AccessoiresID), tonumber(button.AccessoiresDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateAccessoires", tonumber(button.AccessoiresID), tonumber(button.AccessoiresDraw), tonumber(button.prix))
		end

		if vetementShops.currentmenu == "mainChapeauFemme" then
			SetPedPropIndex(LocalPed(), tonumber(button.HatsID), tonumber(button.HatsDraw), 0, 0)
			TriggerServerEvent("GTA:UpdateChapeau", tonumber(button.HatsID), tonumber(button.HatsDraw), tonumber(button.prix))
		end
	end
end

RegisterNetEvent("GTA_Vetement:ChargerTenuePerso")
AddEventHandler("GTA_Vetement:ChargerTenuePerso", function()
	TriggerServerEvent("GTA:LoadVetement")
	CloseCreator()
	TriggerEvent("GTA:DeleteCam")
end)


RegisterNetEvent("GTA_Vetement:ChargerTenuePersoaa")
AddEventHandler("GTA_Vetement:ChargerTenuePersoaa", function()
	TriggerServerEvent("GTA:LoadVetement")
end)

function Back()
	if vetementShops.currentmenu == "mainSousVesteFemme" then
		OpenMainPersonnage("mainVesteFemme")
	elseif vetementShops.currentmenu == "mainSousVesteFemme" then
		OpenMainPersonnage("mainVesteHomme")
	else
		CloseCreator()
	end
	TriggerEvent("GTA:DeleteCam")
	TriggerServerEvent("GTA:LoadVetement")
end

RegisterNetEvent("GTA:ShowVetementBlips")
AddEventHandler('GTA:ShowVetementBlips', function(bool)
	if bool and #VetementBlips  == 0 then
		for _, v in ipairs(vetementConfig) do
			local loc = v
			position = v.blipsPos
			posName = v.name
			local blip = AddBlipForCoord(position.x,position.y,position.z)
            SetBlipSprite(blip,73)
			SetBlipColour(blip, 44)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(posName)
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(VetementBlips, {blip = blip, position = loc})
		end
	elseif bool == false and #VetementBlips > 0 then
		for _,v in ipairs(VetementBlips) do
			if DoesBlipExist(v.blip) then
				SetBlipAsMissionCreatorBlip(v.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(v.blip))
			end
		end
		VetementBlips = {}
	end
end)

RegisterNetEvent("GTA:SetCamShoes")
AddEventHandler("GTA:SetCamShoes", function() 
	local myPos = GetEntityCoords(GetPlayerPed(-1))
	
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	
	while not DoesCamExist(cam) do
        Citizen.Wait(500)
	end
	
	for _, v in ipairs(vetementConfig) do
		if getDistance(myPos, v.ChaussuresPos) < 2 then
			SetEntityCoordsNoOffset(PlayerPedId(), v.playerPosChaussure.x, v.playerPosChaussure.y, v.playerPosChaussure.z)
			SetEntityHeading(PlayerPedId(), v.playerPosChaussure.h)

			if DoesCamExist(cam) then
				SetCamCoord(cam, v.camPosChaussures.x, v.camPosChaussures.y, v.camPosChaussures.z)
				SetCamRot(cam, -3.589798, 0.0, -180.276381, 2)
				SetCamFov(cam, 60.95373)

				ClearPedTasksImmediately(GetPlayerPed(-1))
				FreezeEntityPosition(PlayerPedId(), true)
				SetEntityInvincible(PlayerPedId(), true)

				RenderScriptCams(true, false, 0, 1, 0, 0)
				DoScreenFadeIn(200)
			end
		end
	end
end)


RegisterNetEvent("GTA:SetCamPantalon")
AddEventHandler("GTA:SetCamPantalon", function() 
	local myPos = GetEntityCoords(GetPlayerPed(-1))
	
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	
	while not DoesCamExist(cam) do
        Citizen.Wait(500)
	end
	
	for _, v in ipairs(vetementConfig) do
		if getDistance(myPos, v.PantalonPos) < 2 then
			SetEntityCoordsNoOffset(PlayerPedId(), v.playerPosPantalon.x, v.playerPosPantalon.y, v.playerPosPantalon.z)
			SetEntityHeading(PlayerPedId(), v.playerPosPantalon.h)

			if DoesCamExist(cam) then
				SetCamCoord(cam, v.camPosPantalon.x, v.camPosPantalon.y, v.camPosPantalon.z)
				SetCamRot(cam, -3.589798, 0.0, -180.276381, 2)
				SetCamFov(cam, 60.95373)

				ClearPedTasksImmediately(GetPlayerPed(-1))
				FreezeEntityPosition(PlayerPedId(), true)
				SetEntityInvincible(PlayerPedId(), true)

				RenderScriptCams(true, false, 0, 1, 0, 0)
				DoScreenFadeIn(200)
			end
		end
	end
end)

RegisterNetEvent("GTA:DeleteCam")
AddEventHandler("GTA:DeleteCam", function()
	if DoesCamExist(cam) then
		RenderScriptCams(false, false, 3000, 1, 0, 0)
		FreezeEntityPosition(PlayerPedId(), false)
		SetEntityInvincible(PlayerPedId(), false)
		DestroyCam(cam, true)
	end 
end)