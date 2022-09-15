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
local function ApplySkin(infos)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		if skin.sex == 0 then
			uniformObject = infos.variations.male
		else
			uniformObject = infos.variations..female
		end
		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		end

		infos.onEquip()
	end)
end
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
function Vestiaire()
    local Vestiaire = RageUI.CreateMenu("~o~Vestiaire", "Menu Intéraction", 25, 150)
    Vestiaire:SetRectangleBanner(11, 11, 11, 1)
    RageUI.Visible(Vestiaire, not RageUI.Visible(Vestiaire))
            while Vestiaire do
            Citizen.Wait(0)
            RageUI.IsVisible(Vestiaire, true, true, true, function()
                RageUI.Line()                
					RageUI.Separator("~o~"..GetPlayerName(PlayerId()).. "~w~ - ~o~" ..ESX.PlayerData.job.grade_label.. "")
                    RageUI.Line()
                    for index,infos in pairs(mecano.clothes.specials) do
                        RageUI.ButtonWithStyle(infos.label,nil, {RightLabel = "→"}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
                            if s then
                                ApplySkin(infos)
                            end
                        end)
                    end               
                    RageUI.Line()
            end, function()
            end, 1)

            if not RageUI.Visible(Vestiaire) then
            Vestiaire = RMenu:DeleteType("Vestiaire", true)
        end
    end
end
Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' then
        local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.vestiaire.position.x, Config.pos.vestiaire.position.y, Config.pos.vestiaire.position.z)

        if jobdist <= 55.0 and Config.marker then
            Timer = 0
            DrawMarker(6, Config.pos.vestiaire.position.x, Config.pos.vestiaire.position.y, Config.pos.vestiaire.position.z-1, 0.0, 0.0, 0.0, 270.0, 360.0, 135.0, 1.0, 1.0, 1.0, 245, 89, 0, 255)
            end
            if jobdist <= 1.0 then
                Timer = 0
                    RageUI.Text({ message = "Appuyez sur ~o~[E]~s~ pour accéder au vestiaire", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        Vestiaire()
                end   
            end
        end 
    Citizen.Wait(Timer)   
end
end)
