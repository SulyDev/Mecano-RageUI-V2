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
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
function Coffremecano()
    local sMecano = RageUI.CreateMenu("~o~Coffre", "Menu Intéraction", 25, 150)
    sMecano:SetRectangleBanner(11, 11, 11, 1)
        RageUI.Visible(sMecano, not RageUI.Visible(sMecano))
            while sMecano do
            Citizen.Wait(0)
            RageUI.IsVisible(sMecano, true, true, true, function()
                RageUI.Line()
                RageUI.Separator("↓ ~o~Action Disponible~s~ ↓")
                RageUI.Line()
                    RageUI.ButtonWithStyle("Retirer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            mecanoRetire()
                            RageUI.CloseAll()
                        end
                    end)                    
                    RageUI.ButtonWithStyle("Déposer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            mecanoDepose()
                            RageUI.CloseAll()
                        end
                    end)
                    RageUI.Line()                    
                end, function()
                end)
            if not RageUI.Visible(sMecano) then
            sMecano = RMenu:DeleteType("sMecano", true)
        end
    end
end
Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' then
        local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.coffre.position.x, Config.pos.coffre.position.y, Config.pos.coffre.position.z)
        if jobdist <= 55.0 and Config.marker then
            Timer = 0
            DrawMarker(6, Config.pos.coffre.position.x, Config.pos.coffre.position.y, Config.pos.coffre.position.z-1, 0.0, 0.0, 0.0, 270.0, 360.0, 135.0, 1.0, 1.0, 1.0, 245, 89, 0, 255)
            end
            if jobdist <= 1.0 then
                Timer = 0
                    RageUI.Text({ message = "Appuyez sur ~o~[E]~s~ pour accéder au coffre", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        Coffremecano()
                end   
            end
        end 
    Citizen.Wait(Timer)   
end
end)
itemstock = {}
function mecanoRetire()
    local StocsMeca = RageUI.CreateMenu("~o~Coffre", "Menu Intéraction", 25, 150)
    StocsMeca:SetRectangleBanner(11, 11, 11, 1)
    ESX.TriggerServerCallback('sMeca:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(StocsMeca, not RageUI.Visible(StocsMeca))
        while StocsMeca do
            Citizen.Wait(0)
                RageUI.IsVisible(StocsMeca, true, true, true, function()
                    RageUI.Separator("↓ ~o~Object à Retirer~s~ ↓")
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('sMeca:getStockItem', v.name, tonumber(count))
                                    ExecuteCommand'e pickup'
                                    mecanoRetire()
                                    Coffremecano()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StocsMeca) then
            StocsMeca = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function mecanoDepose()
    local mecanoDepose = RageUI.CreateMenu("~o~Coffre", "Menu Intéraction", 25, 150)
    mecanoDepose:SetRectangleBanner(11, 11, 11, 1)
    ESX.TriggerServerCallback('sMeca:getPlayerInventory', function(inventory)
        RageUI.Visible(mecanoDepose, not RageUI.Visible(mecanoDepose))
    while mecanoDepose do
        Citizen.Wait(0)
            RageUI.IsVisible(mecanoDepose, true, true, true, function()
                RageUI.Separator("↓ ~o~Object à Déposer~s~ ↓")
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('sMeca:putStockItems', item.name, tonumber(count))
                                            ExecuteCommand'e pickup'
                                            mecanoDepose()
                                            Coffremecano()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(mecanoDepose) then
                mecanoDepose = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end       
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end