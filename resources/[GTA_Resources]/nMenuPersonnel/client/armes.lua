local armesConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), 'json/ConfigArmes.json'))

local Weapons = {}
local AmmoTypes = {}

local CurrentWeapon = nil

local IsShooting = false
local AmmoBefore = 0

for _,i in pairs(armesConfig) do
  for _,j in pairs(armesConfig) do
    Weapons[GetHashKey(i.nomHash)] = i
    AmmoTypes[GetHashKey(j.typeMunitions)] = j
  end
end

local function RemoveUsedAmmo()  
  local playerPed = GetPlayerPed(-1)
  local AmmoAfter = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
  local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]
  
  if ammoType and ammoType.idMunition then
    local ammoDiff = AmmoBefore - AmmoAfter
    if ammoDiff > 0 then
      TriggerEvent('player:looseItem', ammoType.idMunition, ammoDiff)
    end
  end
  return AmmoAfter
end

local function GetItemArmes(armeItem)
  for k,_ in pairs(ITEMS) do
    if k == armeItem then
        return ITEMS[k]
    end
  end
  return nil
end

local function GetMunitionItem(muniItem)
  for k,_ in pairs(ITEMS) do
    if k == muniItem then
        return ITEMS[k]
    end
  end
  return nil
end

RegisterNetEvent("GTA:LoadWeaponPlayer")
AddEventHandler("GTA:LoadWeaponPlayer", function()
  for _,i in pairs(Weapons) do
      for _,j in pairs(AmmoTypes) do
        local item = GetItemArmes(i.idArme)
        if item and item.quantity > 0 then
          
          local ammo = 0
          local ammoType = GetPedAmmoTypeFromWeapon(GetPlayerPed(-1), i.nomHash)

          if ammoType and AmmoTypes[ammoType] then
            local ammoItem = GetMunitionItem(AmmoTypes[ammoType].idMunition)
            if ammoItem then
              ammo = ammoItem.quantity
            end
          end

          if HasPedGotWeapon(GetPlayerPed(-1), i.nomHash, false) then
            if GetAmmoInPedWeapon(GetPlayerPed(-1), i.nomHash) ~= ammo then
              SetPedAmmo(GetPlayerPed(-1), i.nomHash, ammo)
            end
          else
            GiveWeaponToPed(GetPlayerPed(-1), i.nomHash, ammo, false, false)
          end
        elseif HasPedGotWeapon(GetPlayerPed(-1), i.nomHash, false) then
          RemoveWeaponFromPed(GetPlayerPed(-1), i.nomHash)
        end
      end
    end
end)
  
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPed = GetPlayerPed(-1)

    if CurrentWeapon ~= GetSelectedPedWeapon(playerPed) then
      IsShooting = false
      RemoveUsedAmmo()
      CurrentWeapon = GetSelectedPedWeapon(playerPed)
      AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
    end

    if IsPedShooting(playerPed) and not IsShooting then
      IsShooting = true
    elseif IsShooting and IsControlJustReleased(0, 24) then
      IsShooting = false
      AmmoBefore = RemoveUsedAmmo()
    elseif not IsShooting and IsControlJustPressed(0, 45) then
      AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
    end
  end
end)