ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local PlayerData = {}
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
    end
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)
Citizen.CreateThread(function()
    local mecanomap = AddBlipForCoord(Config.pos.blips.position.x, Config.pos.blips.position.y, Config.pos.blips.position.z)
    SetBlipSprite(mecanomap, 446)
    SetBlipColour(mecanomap, 17)
    SetBlipScale(mecanomap, 0.70)
    SetBlipAsShortRange(mecanomap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Entreprise | ~o~Mécano")
    EndTextCommandSetBlipName(mecanomap)
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
function GarageConfig()
  local SulyGarage = RageUI.CreateMenu("~o~Garage", "Menu Intéraction", 25, 150)
  SulyGarage:SetRectangleBanner(11, 11, 11, 1)
    RageUI.Visible(SulyGarage, not RageUI.Visible(SulyGarage))
        while SulyGarage do
            Citizen.Wait(0)
                RageUI.IsVisible(SulyGarage, true, true, true, function()
                    RageUI.Line()
                    RageUI.Separator("~o~"..GetPlayerName(PlayerId()).. "~w~ - ~o~" ..ESX.PlayerData.job.grade_label.. "")
                    RageUI.Line()
                    RageUI.ButtonWithStyle("Ranger - ~o~Véhicule", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            ESX.ShowNotification('Vous avez ranger le véhicule')
                            RageUI.CloseAll()
                            end 
                        end
                    end) 
                    RageUI.Separator("↓ ~o~Véhicule dispo~s~ ↓")
                    for k,v in pairs(GBennysvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarConfig(v.modele)
                            ESX.ShowNotification('Vous avez sorti un véhicule')
                            RageUI.CloseAll()
                            end
                        end)
                    end
                    RageUI.Line()
                end, function()
                end)
            if not RageUI.Visible(SulyGarage) then
            SulyGarage = RMenu:DeleteType("Garage", true)
        end
    end
end
Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' then
        local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.garage.position.x, Config.pos.garage.position.y, Config.pos.garage.position.z)
        if jobdist <= 55.0 and Config.marker then
            Timer = 0
            DrawMarker(6, Config.pos.garage.position.x, Config.pos.garage.position.y, Config.pos.garage.position.z-1, 0.0, 0.0, 0.0, 270.0, 360.0, 135.0, 1.0, 1.0, 1.0, 245, 89, 0, 255)
            end
            if jobdist <= 10.0 then
                Timer = 0
                    RageUI.Text({ message = "Appuyez sur ~o~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        GarageConfig()
                end   
            end
        end 
    Citizen.Wait(Timer)   
end
end)
function spawnuniCarConfig(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Config.pos.spawnvoiture.position.x, Config.pos.spawnvoiture.position.y, Config.pos.spawnvoiture.position.z, Config.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Suly"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end


