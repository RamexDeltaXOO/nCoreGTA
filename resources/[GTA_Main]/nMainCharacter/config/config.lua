config = {}

config.Sex = ""
config.Visage = 0
config.Peau = 0
config.Cheveux = 0
config.CouleurCheveux = 0
config.Nom = "Sans Nom"
config.Prenom = "Sans Prenom"
config.Age = 0
config.Taille = 0
config.Origine = "A mettre a jours"
config.MenuOpen = false
config.cam = nil

--[[ --=============================================================================
------------------------------ INFO : ----------------------------------------- 
Pour le system de tenue plus d'info : https://wiki.rage.mp/index.php?title=Clothes

config.Tops = ID COMPONENT : 11
config.Undershirts = ID COMPONENT : 8
config.Shoes = ID COMPONENT : 6
config.Legs = ID COMPONENT : 4
config.Torsos = ID COMPONENT : 3
--=============================================================================]]

--[[ --=============================================================================
    ------------------------------ INFO : ----------------------------------------- 
Pour modifier la couleur de votre menu, vous pouvez vous rendre sur : https://www.rapidtables.com/web/color/RGB_Color.html
R = Rouge
G = Vert
B = Bleu
A = Opacité


couleurTopMenu = --> Couleur sur la barre au top du menu la ou se situe le titre de votre main menu.
couleurTextMenu = --> Couleur du text en général quand vous ouvré votre menu.
couleurTextSelectMenu = --> Couleur du text qui change quand vous le séléctionner.
couleurRectSelectMenu = --> Couleur de la barre qui s'affiche quand vous séléctionner un boutton.
--=============================================================================]]


---> Couleur du rect au top du menu :
couleurTopMenu = {}

couleurTopMenu.r = 0
couleurTopMenu.g = 0
couleurTopMenu.b = 0
couleurTopMenu.a = 255

---> Couleur du rect de séléction :
couleurRectSelectMenu = {}

couleurRectSelectMenu.r = 255
couleurRectSelectMenu.g = 255
couleurRectSelectMenu.b = 255
couleurRectSelectMenu.a = 255


---> Couleur du text principale :
couleurTextMenu = {}

couleurTextMenu.r = 255
couleurTextMenu.g = 255
couleurTextMenu.b = 255
couleurTextMenu.a = 255


---> Couleur du text qui change une fois le button séléctionner :
couleurTextSelectMenu = {}

couleurTextSelectMenu.r = 0
couleurTextSelectMenu.g = 0
couleurTextSelectMenu.b = 0
couleurTextSelectMenu.a = 255