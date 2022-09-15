ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local PlayerData = {}
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
function F6mecano()
    local MenuSulyMecano = RageUI.CreateMenu("~o~Mécano", "Menu Intéraction", 25, 150)
    local MenuCar = RageUI.CreateSubMenu(MenuSulyMecano, "~o~Mécano", "Menu Intéraction")
    MenuSulyMecano:SetRectangleBanner(11, 11, 11, 1)
    MenuCar:SetRectangleBanner(11, 11, 11, 1)
    RageUI.Visible(MenuSulyMecano, not RageUI.Visible(MenuSulyMecano))
    while MenuSulyMecano do
        Citizen.Wait(0)
            RageUI.IsVisible(MenuSulyMecano, true, true, true, function()
                
              if etatservice then
                RageUI.Separator("Service - ~o~Actif")
                    onSelected = function()
                        etatservice = not etatservice
                    end
            else
                RageUI.Separator("Service - ~o~Inactif")
                    onSelected = function()
                        etatservice = not etatservice
                    end
            end
              RageUI.Checkbox("Prendre/Quitter son service", "Prendre son service pour commencer a travailler", service,{},function(Hovered,Ative,Selected,Checked)
                if Selected then

                    service = Checked

                    if Checked then
                        etatservice = true
                        ESX.ShowAdvancedNotification("Benny's", '~g~Notification', "Vous avez pris votre ~o~service~s~ !", 'CHAR_CARSITE3', 7)

                    else
                        etatservice = false
                        ESX.ShowAdvancedNotification("Benny's", '~g~Notification', "Vous avez quitter votre ~o~service~s~ !", 'CHAR_CARSITE3', 7)
                    end
                end
            end)
            if etatservice then
              RageUI.Line()
              RageUI.Separator("~o~"..GetPlayerName(PlayerId()).. "~w~ - ~o~" ..ESX.PlayerData.job.grade_label.. "")
              RageUI.Line()
              RageUI.ButtonWithStyle("Faire - ~o~Annonces", "Permet de mettre une annonces", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local msg = KeyboardInput("Message", "", 100)
                    TriggerServerEvent('sMecano:Perso', msg)
                end
            end)
              RageUI.ButtonWithStyle("Mettre - ~o~Facture","Permet de facturer un citoyen a proximité", {RightLabel = "→"}, true, function(_,_,s)
                local player, distance = ESX.Game.GetClosestPlayer()
                if s then
                    local raison = ""
                    local montant = 0
                    AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0)
                        Wait(0)
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then
                            raison = result
                            result = nil
                            AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                result = GetOnscreenKeyboardResult()
                                if result then
                                    montant = result
                                    result = nil
                                    if player ~= -1 and distance <= 3.0 then
                                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_mechanic', ('Benny\'s'), montant)
                                        TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                    else
                                        ESX.ShowAdvancedNotification('Mecano', '~r~Notification', "Aucun joueur proche", 'CHAR_CARSITE3', 7)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
                RageUI.ButtonWithStyle("Interaction - ~o~véhicule", "Permet de faire une action sur un véhicule", {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                end, MenuCar)                              
                if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' and ESX.PlayerData.job.grade_name == 'boss' then 
                  RageUI.ButtonWithStyle("Message - ~o~Employés", "Pour écrire un message aux Employés", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                      if (Selected) then   
                      local info = 'patron'
                      local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', 40)
                      TriggerServerEvent('suly:mecanojob', info, message)
                  end
                  end)
              end
                RageUI.Line()
            end
            end)
            RageUI.IsVisible(MenuCar, true, true, true, function()  
            RageUI.Line()  
            RageUI.Separator("~o~"..GetPlayerName(PlayerId()).. "~w~ - ~o~" ..ESX.PlayerData.job.grade_label.. "")
            RageUI.Line()
              RageUI.ButtonWithStyle("Réparer - ~o~Véhicule", "Permet de réparer un véhicule a proximité", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
            local playerPed = PlayerPedId()
            local vehicle   = ESX.Game.GetVehicleInDirection()
            local coords    = GetEntityCoords(playerPed)
            if IsPedSittingInAnyVehicle(playerPed) then
                ESX.ShowNotification('Veuillez descendre de la voiture.')
                return
            end
            if DoesEntityExist(vehicle) then
                isBusy = true
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                Citizen.CreateThread(function()
                    Citizen.Wait(20000)

                    SetVehicleFixed(vehicle)
                    SetVehicleDeformationFixed(vehicle)
                    SetVehicleUndriveable(vehicle, false)
                    SetVehicleEngineOn(vehicle, true, true)
                    ClearPedTasksImmediately(playerPed)

                    ESX.ShowNotification('Le véhicule est réparer')
                    isBusy = false
                end)
            else
				ESX.ShowAdvancedNotification('Mecano', '~r~Notification', "Aucun véhicule à proximité", 'CHAR_CARSITE3', 7)
            end
        end
        end)
              RageUI.ButtonWithStyle("Nettoyer - ~o~Véhicule", "Permet de nettoyer un véhicule a proximité", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local playerPed = PlayerPedId()
                    local vehicle   = ESX.Game.GetVehicleInDirection()
                    local coords    = GetEntityCoords(playerPed)
                    if IsPedSittingInAnyVehicle(playerPed) then
                        ESX.ShowNotification('Veuillez sortir de la voiture?')
                        return
                    end        
                    if DoesEntityExist(vehicle) then
                        isBusy = true
                        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
                        Citizen.CreateThread(function()
                            Citizen.Wait(10000)
                            SetVehicleDirtLevel(vehicle, 0)
                            ClearPedTasksImmediately(playerPed)
        
                            ESX.ShowNotification('Voiture néttoyé')
                            isBusy = false
                        end)
                    else
                        ESX.ShowAdvancedNotification('Mecano', '~r~Notification', "Aucun véhicule à proximité", 'CHAR_CARSITE3', 7)
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Crocheter - ~o~Véhicule", "Permet de crocheter un véhicule a proximité", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                            local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)
			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowAdvancedNotification('Mecano', '~r~Notification', "Vous ne pouvez pas faire cette action depuis un véhicule", 'CHAR_CARSITE3', 7)
				return
			end
			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowAdvancedNotification('Mecano', '~r~Notification', "Crochetage ~g~Terminer", 'CHAR_CARSITE3', 7)
					isBusy = false
				end)
			else
				ESX.ShowAdvancedNotification('Mecano', '~r~Notification', "Aucun véhicule à proximité", 'CHAR_CARSITE3', 7)
            end
        end
    end)
                RageUI.ButtonWithStyle("Mettre - ~o~Fourriere", "Mettre un véhicule en fourrière", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    local playerPed = PlayerPedId()
                    if IsPedSittingInAnyVehicle(playerPed) then
                        local vehicle = GetVehiclePedIsIn(playerPed, false)        
                        if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                            ESX.ShowNotification('la voiture a été mis en fourrière')
                            ESX.Game.DeleteVehicle(vehicle)                           
                        else
                            ESX.ShowNotification('Mais toi place conducteur, ou sortez de la voiture.')
                        end
                    else
                        local vehicle = ESX.Game.GetVehicleInDirection()        
                        if DoesEntityExist(vehicle) then
                            TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                            Citizen.Wait(5000)
                            ClearPedTasks(playerPed)
                            ESX.ShowNotification('La voiture à été placer en fourriere.')
                            ESX.Game.DeleteVehicle(vehicle)        
                        else
                            ESX.ShowAdvancedNotification('Mecano', '~r~Notification', "Aucun véhicule à proximité", 'CHAR_CARSITE3', 7)
                        end
                    end
                    end
                end)
                RageUI.Line()
            end)            
        end
    end
Keys.Register("F6", 'Mécano', 'Ouvrir le Menu Mécano', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' then
    	F6mecano()
	end
end)
RegisterNetEvent('suly:mecanojob')
AddEventHandler('suly:mecanojob', function(service, nom, message)
	if service == 'patron' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('La direction', 'A lire', 'Directeur: '..nom..'\n~w~Message: ~o~'..message..'', 'CHAR_CARSITE3', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)	
	end
end)