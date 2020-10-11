--> Voici comment fonctionne le systeme de vêtement : 
--> Site pour le system de vêtement : https://wiki.rage.mp/index.php?title=Clothes
--[[
    EXEMPLE ICI :
    https://wiki.rage.mp/index.php?title=Male_Tops
    ["T-Shirt Blanc"] = {1, 0, 5, 0}, 
    Le premier chiffre représente le draw id[Torsos]
    Le deuxieme représente la couleur
    Le troisieme reprèsente le prix.
    Le quatrième reprèsente les bras[Torsos].
    Le 5ieme reprèsente le sous tshirt [Undershirts].
]]

Config = {
    Locations = {
        [1] = {
            ["MagasinDeVetement"] = {
                ["x"] = -822.61, ["y"] = -1077.64, ["z"] = 11.33,

                ["TShirtPos"] = { 
                   ["x"] = -822.61, ["y"] = -1077.64, ["z"] = 11.33,
                },

                ["PullPos"] = { 
                    ["x"] = -825.25, ["y"] = -1075.99, ["z"] = 11.32,
                },

                ["VestePos"] = { 
                    ["x"] = -827.47, ["y"] = -1079.88, ["z"] = 11.32,
                },

                ["PantalonPos"] = { 
                    ["x"] = -824.82, ["y"] = -1080.55, ["z"] = 11.32,
                },

                ["ChaussurePos"] = { 
                    ["x"] = -822.31, ["y"] = -1080.2, ["z"] = 11.32,
                },
            },
            
            ["Homme"] = { 
                ["Tshirt"] = {
                    ["T-Shirt blanc"] = {1, 0, 5, 0, 15},
                    ["T-Shirt gris"] = {16, 0, 5, 0, 15},
                    ["T-Shirt gris rayé"] = {33, 0, 5, 0, 15},
                    ["T-Shirt gris noir"] = {34, 0, 5, 0, 15},
                    ["T-Shirt gris noir"] = {34, 0, 5, 0, 15},
                    ["Polo gris"] = {9, 1, 5, 0, 15},
                },

                ["Pull"] = {
                    ["Pull gris"] = {38, 0, 5, 8, 15},
                },

                ["Veste"] = {
                    ["Veste en cuir"] = {37, 0, 5, 14, 15},
                    ["Chemise blanche"] = {13, 0, 5, 11, 15},
                    ["Veste légère"] = {3, 0, 5, 14, 15},
                },

                ["Pantalon"] = {
                    ["Jean bleu marine"] = {0, 0, 5}, --> DrawID, CouleurID, Prix.
                    ["Jean noir"] = {1, 0, 5}, --> DrawID, CouleurID, Prix.
                },

                ["Chaussure"] = {
                    ["Pied nu"] = {34, 0, 5}, --> DrawID, CouleurID, Prix.
                    ["Tong basic"] = {5, 0, 5}, --> DrawID, CouleurID, Prix.
                },
            },

            ["Femme"] = { 
                ["Tshirt"] = {
                    ["T-Shirt Blanc"] = {1, 1, 5, 0, 15},
                    ["T-Shirt Rouge"] = {9, 1, 5, 0, 15}
                },

                ["Pull"] = {
                    ["Pull"] = {1, 0, 5, 8, 15},
                },

                ["Veste"] = {
                    ["Pull gris"] = {37, 0, 5, 8, 15},
                },
            }
        },
    },
}