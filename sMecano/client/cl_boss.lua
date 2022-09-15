ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local mecanoBoss = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
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


function MecanoBoss()
    local ActionPatron = RageUI.CreateMenu("~o~Mécano", "Menu Intéraction", 25, 150)
    ActionPatron:SetRectangleBanner(11, 11, 11, 1)
      RageUI.Visible(ActionPatron, not RageUI.Visible(ActionPatron))
  
              while ActionPatron do
                  Citizen.Wait(0)
                      RageUI.IsVisible(ActionPatron, true, true, true, function()
                        
                        RageUI.Line()
                        
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' and ESX.PlayerData.job.grade_name == 'boss' then 
            RageUI.Separator("↓ ~o~Action Patron~s~ ↓")
        end
        RageUI.Line()
                        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' and ESX.PlayerData.job.grade_name == 'boss' then 
            if mecanoBoss ~= nil then
                RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "" .. mecanoBoss}, true, function()
                end)
            end
        end

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' and ESX.PlayerData.job.grade_name == 'boss' then 
            RageUI.ButtonWithStyle("Message aux Employés", "Pour écrire un message aux Employés", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                local info = 'patron'
                local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', 40)
                TriggerServerEvent('suly:mecanojob', info, message)
            end
            end)
        end

            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' and ESX.PlayerData.job.grade_name == 'boss' then 
            RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:withdrawMoney', 'mecano', amount)
                        RefreshmecanoBoss()
                    end
                end
            end)
        end

            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' and ESX.PlayerData.job.grade_name == 'boss' then 
            RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    local amount = KeyboardInput("Montant", "", 10)
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:depositMoney', 'mecano', amount)
                        RefreshmecanoBoss()
                    end
                end
            end) 
        end

        RageUI.Line()

        end, function()
        end)
        if not RageUI.Visible(ActionPatron) then
        ActionPatron = RMenu:DeleteType("ActionPatron", true)
    end
end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' then
        local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.patron.position.x, Config.pos.patron.position.y, Config.pos.patron.position.z)

        if jobdist <= 55.0 and Config.marker then
            Timer = 0
            DrawMarker(6, Config.pos.patron.position.x, Config.pos.patron.position.y, Config.pos.patron.position.z-1, 0.0, 0.0, 0.0, 270.0, 360.0, 135.0, 1.0, 1.0, 1.0, 245, 89, 0, 255)
            end
            if jobdist <= 1.0 then
                Timer = 0
                    RageUI.Text({ message = "Appuyez sur ~o~[E]~s~ pour accéder au action du patron", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        RefreshmecanoBoss()  
                        MecanoBoss()
                end   
            end
        end 
    Citizen.Wait(Timer)   
end
end)

function RefreshmecanoBoss()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdatemecanoBoss(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdatemecanoBoss(money)
    mecanoBoss = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'mecano', function(data, menu)
        menu.close()
    end, {wash = false})
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end
