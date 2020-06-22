blips = {
	{nom="Emplois", couleur = 57, id=408, x = -1083.4, y = -245.893, z = 37.7632},
}


Citizen.CreateThread(function()
	for _, item in pairs(blips) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipDisplay(item.blip, 4)
		SetBlipScale(item.blip, 0.9)
		SetBlipColour(item.blip, item.couleur)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.nom)
		EndTextCommandSetBlipName(item.blip)
	end
end)