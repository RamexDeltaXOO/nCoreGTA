Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetVehicleDensityMultiplierThisFrame(config.vehiculeDensiter)
        SetPedDensityMultiplierThisFrame(config.pedDensiter)
        SetRandomVehicleDensityMultiplierThisFrame(config.vehiculeDensiter)
        SetParkedVehicleDensityMultiplierThisFrame(config.vehiculeDensiter)
        SetScenarioPedDensityMultiplierThisFrame(config.pedDensiter, config.pedDensiter)
    end
end)