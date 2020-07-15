Citizen.CreateThread(function()
    while true do
        SetVehicleDensityMultiplierThisFrame(config.vehiculeDensiter)
        SetPedDensityMultiplierThisFrame(config.pedDensiter)
        SetRandomVehicleDensityMultiplierThisFrame(config.vehiculeDensiter)
        SetParkedVehicleDensityMultiplierThisFrame(config.vehiculeDensiter)
        SetScenarioPedDensityMultiplierThisFrame(config.pedDensiter, config.pedDensiter)
        Citizen.Wait(0)
    end
end)