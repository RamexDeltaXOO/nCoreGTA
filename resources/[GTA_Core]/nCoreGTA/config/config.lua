--@Super.Cool.Ninja
config = {}

--> Permet d'activer l'affichage de votre version anticipé :
config.activerVersionDebug = true
config.versionCore = "Ninja-Source Accès anticipé version 1.3.3"

--> Desactiver le system d'indice de recherche.
config.activerPoliceWanted = false

--> Permet d'activer la possibilité du pvp.
config.activerPvp = true 

--> Temps en ms salaire du joueur : /toute les 15 minutes.
config.salaireTime = 900000

--> Temps en ms entre chaque sauvegarde de la pos du joueur : /toute les 60 secondes.
config.savePosTime = 60000

--> Valeur de départ Joueur : 
config.argentPropre = 500
config.argentSale = 150
config.banque = 5000

--> Traffic PNJ :
config.vehiculeDensiter = 0.5
config.pedDensiter = 1.0

-->JobMedic :
config.utilisationJobMedic = false

--> Whitelist :
--> Pour avoir la license du player, faite le connecter une fois au serveur sans qui puisse rejoindre, il sera afficher sur la console.
config.activerWhitelist = false
config.lienDiscord  = 'https://discord.gg/xXxUPA'

---> Listes des joueurs whitelist :
config.JoueursWhitelist    = {
    --[[ EXEMPLE :
        'license:40423b6fc9a87b1c16c005a43d3a74863fdd96db',
        'license:26d08f65594884f85b889c7612bd966c815479ec',
        "license:dad22062e0444e3b2485e2d6ef27c8fd7c989325"
    ]]
    
    'license:40423b6fc9a87b1c16c005a43d3a74863fdd96db',
    'license:26d08f65594884f85b889c7612bd966c815479ec',
    "license:dad22062e0444e3b2485e2d6ef27c8fd7c989325"
}