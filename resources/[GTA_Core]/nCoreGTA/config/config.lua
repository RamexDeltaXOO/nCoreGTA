--@Super.Cool.Ninja
config = {}

config.versionCore = "Version 1.3"

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


------------------------> System de notification : @Mobius1
config.Enabled          = true      -- Enable / disable

-- Text Options
config.Font             = 4         -- Font family (https://gtaforums.com/topic/794014-fonts-list/)
config.Scale            = 0.38      -- Font size

-- Box Dimensions
config.Width            = 0.145     -- Box width
config.Spacing          = 0.005     -- Box margin / seperation
config.Padding          = 0.006

config.Queue            = 5         -- Message queue limit
config.FilterDuplicates = true      -- Enable / disable filtering of duplicate notifications
config.Animation        = true      -- Enable / disable animation

config.Sound            = { -1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1 }

config.Position         = "milieuGauche"      -- Position

-- Message Positions
config.Positions = { -- https://github.com/Mobius1/FeedM#positioning
    milieuGauche     = { x = 0.085,  y = 0.70 },
    milieuDroite     = { x = 0.915,  y = 0.98 },
    topGauche        = { x = 0.085,  y = 0.02 },
    topDroite        = { x = 0.915,  y = 0.02 },
    Milieu    =        { x = 0.500,  y = 0.98 }    
}

-- Message Types
config.Types = {
    primary = { r = 0,      g = 0,      b = 0,      a = 180 },
    success = { r = 100,    g = 221,    b = 23,     a = 180 },
    warning = { r = 255,    g = 196,    b = 0,      a = 180 },
    danger  = { r = 211,    g = 47,     b = 47,     a = 180 },
}