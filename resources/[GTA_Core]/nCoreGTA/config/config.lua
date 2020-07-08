--@Super.Cool.Ninja
config = {}

config.versionCore = "Version 1.1"

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
config.vehiculeDensiter = 1.0
config.pedDensiter = 1.0

--> Whitelist :
--> Pour avoir la license du player, faite le connecter une fois au serveur sans qui puisse rejoindre, il sera afficher sur la console.
config.activerWhitelist = false
config.lienDiscord  = 'https://discord.gg/NKHJTqn'

---> Listes des joueurs whitelist :
config.JoueursWhitelist    = {
    --[[ EXEMPLE :
        'license:40423b6fc9a87b1c16c005a43d3a74863fdd96db'
    ]]
    
    'license:40423b6fc9a87b1c16c005a43d3a74863fdd96db'
}