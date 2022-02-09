local PlayerData 	= {}
ESX 				= nil
local asmenu 		= false

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShtestaredObjtestect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local coordsUI = vector3(243.34, -1090.47, 29.34)
local coordsCheckCount = vector3(236.81, -1078.20, 29.33)

CreateThread(function ()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, -1))
		if #(coords - coordsUI) <= 10.0 then
			DrawMarker(27, coordsUI.x, coordsUI.y, coordsUI.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 0, 158, 189, 100, false, true, 2, false, false, false, false)
			if #(coords - coordsUI) <= 1.5 then
				ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby ~y~przejrzeć ~s~ofertę')
				ESX.ShowFloatingHelpNotification('~b~ URZĄD PRACY', vec3(coordsUI.x, coordsUI.y, coordsUI.z))
				if IsControlJustReleased(1, 51) then
					TriggerEvent('wybranopostac', false)
					SetNuiFocus(true, true)
					SendNUIMessage({
						ativa = true
					})
				end
			end
		end
		
		if #(coords - coordsCheckCount) <= 10.0 then
			DrawMarker(27, coordsCheckCount.x, coordsCheckCount.y, coordsCheckCount.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 0, 158, 189, 100, false, true, 2, false, false, false, false)
			if #(coords - coordsCheckCount) <= 1.5 then
				ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby ~y~porozmawiać ~s~z asystentem')
				ESX.ShowFloatingHelpNotification('~b~ ASYSTENT FIRM', vec3(coordsCheckCount.x, coordsCheckCount.y, coordsCheckCount.z))
				if IsControlJustReleased(1, 51) then
					asystentmenu()
				end
			end
		end
		
		if asmenu then
			if #(coords - coordsCheckCount) >= 2.0 then
				ESX.UI.Menu.CloseAll()
				asmenu = false
			end
		end
	end
end)

function asystentmenu()
	asmenu = true
	
    local elements = {
		{label = "Kawiarnia", value = 'kawa'},
		{label = "Złomowisko", value = 'zlomkursy'},
		{label = "Sad", value = 'sadkursy'},
		{label = "Taxi", value = 'kursy'},
		{label = "-= System awansów =-", value = 'awanse'}
    } 

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'asystentmenu',
		{
			title    = "Asystent firm LS",
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)

			if data.current.value == 'kawa' then
				ESX.TriggerServerCallback('centrumpracy:getkursy', function (liczba)
					czaskawiarnia = math.floor(liczba * 19 / 60)
					ESX.ShowAdvancedNotification('Asystent firm LS', '~b~Kawiarnia', '~y~Wykonana liczba kursów: ~g~'..liczba..'~n~~y~Szacowany czas pracy: ~g~'..czaskawiarnia..'h', 'CHAR_DEFAULT', 8)
				end, data.current.value)
			end

			if data.current.value == 'zlomkursy' then
				ESX.TriggerServerCallback('centrumpracy:getkursy', function (liczba)
					czaszlom = math.floor(liczba * 5.2 / 60)
					ESX.ShowAdvancedNotification('Asystent firm LS', '~b~Złomowisko', '~y~Wykonana liczba kursów: ~g~'..liczba..'~n~~y~Szacowany czas pracy: ~g~'..czaszlom..'h', 'CHAR_DEFAULT', 8)
				end, data.current.value)
			end
			
			if data.current.value == 'sadkursy' then
				ESX.TriggerServerCallback('centrumpracy:getkursy', function (liczba)
					czassad = math.floor(liczba * 7 / 60)
					ESX.ShowAdvancedNotification('Asystent firm LS', '~b~Sad', '~y~Wykonana liczba kursów: ~g~'..liczba..'~n~~y~Szacowany czas pracy: ~g~'..czassad..'h', 'CHAR_DEFAULT', 8)
				end, data.current.value)
			end
			
			if data.current.value == 'kursy' then
				ESX.TriggerServerCallback('centrumpracy:getkursy', function (liczba)
					czastaxi = math.floor(liczba * 10 / 60)
					ESX.ShowAdvancedNotification('Asystent firm LS', '~b~Taxi', '~y~Wykonana liczba kursów: ~g~'..liczba..'~n~~y~Szacowany czas pracy: ~g~'..czastaxi..'h', 'CHAR_DEFAULT', 8)
				end, data.current.value)
			end
			
			if data.current.value == 'awanse' then
				systemmenu()
			end

		end,
      
		function(data, menu)
			menu.close()
		end
    )
end

function systemmenu()
	
    local elements = {
		{label = "<= 149 - 0lvl", value = nil},
		{label = ">= 150 - 1lvl", value = nil},
		{label = ">= 300 - 2lvl", value = nil},
		{label = ">= 600 - 3lvl", value = nil},
		{label = ">= 1000 - 4lvl", value = nil},
		{label = ">= 1500 - 5lvl", value = nil},
		{label = ">= 2100 - 6lvl", value = nil},
		{label = ">= 2800 - 7lvl", value = nil},
		{label = ">= 3600 - 8lvl", value = nil},
		{label = ">= 4500 - 9lvl", value = nil},
		{label = ">= 5500 - 10lvl", value = nil}
    } 

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'systemmenu',
		{
			title    = "Asystent firm LS",
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
		end,
      
		function(data, menu)
			menu.close()
		end
    )
end

RegisterNUICallback('2', function(data, cb) --KAT B
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'farming', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. B')
		end
	end, GetPlayerServerId(PlayerId()), 'drive')
	cb('ok')
end)

RegisterNUICallback('3', function(data, cb) --KAT C
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'sadownik', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. B')
		end
	end, GetPlayerServerId(PlayerId()), 'drive')
	cb('ok')
end)

RegisterNUICallback('4', function(data, cb) --KAT C
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'trucker', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. C')
		end
	end, GetPlayerServerId(PlayerId()), 'drive_truck')
	cb('ok')
end)

RegisterNUICallback('6', function(data, cb) --KAT B
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'deliverer', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. B')
		end
	end, GetPlayerServerId(PlayerId()), 'drive')
	cb('ok')
end)

RegisterNUICallback('10', function(data, cb) --KAT B
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'kawiarnia', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. B')
		end
	end, GetPlayerServerId(PlayerId()), 'drive')
	cb('ok')
end)

RegisterNUICallback('11', function(data, cb) --KAT C
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'garbage', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. C')
		end
	end, GetPlayerServerId(PlayerId()), 'drive_truck')
	cb('ok')
end)

RegisterNUICallback('12', function(data, cb) --BRAK KATEGORII
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'piekarz', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. B')
		end
	end, GetPlayerServerId(PlayerId()), 'drive')
	cb('ok')
end)

RegisterNUICallback('25', function(data, cb) --BRAK KATEGORII
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'krawiec', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. B')
		end
	end, GetPlayerServerId(PlayerId()), 'drive')
	cb('ok')
end)

RegisterNUICallback('27', function(data, cb) --BRAK KATEGORII
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'taxi', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. B')
		end
	end, GetPlayerServerId(PlayerId()), 'drive')
	cb('ok')
end)

RegisterNUICallback('28', function(data, cb) --BRAK KATEGORII
	ESX.TriggerServerCallback('esx_license:checkLicense', function(lickajest)
		if lickajest then
			TriggerServerEvent('route68centrumpracy:ustalPrace', 'winiarnia', PlayerData.protect)
		else
			ESX.ShowNotification('Nie posiadasz prawa jazdy kat. B')
		end
	end, GetPlayerServerId(PlayerId()), 'drive')
	cb('ok')
end)

RegisterNUICallback('13', function(data, cb) --BRAK KATEGORII
	TriggerServerEvent('route68centrumpracy:ustalPrace', 'zlomiarz', PlayerData.protect)
  	cb('ok')
end)

RegisterNUICallback('14', function(data, cb) --BRAK KATEGORII
	TriggerServerEvent('route68centrumpracy:ustalPrace', 'unemployed', PlayerData.protect)
  	cb('ok')
end)

RegisterNUICallback('fechar', function(data, cb)
	SetNuiFocus( false )
	SendNUIMessage({
		ativa = false
	})
	TriggerEvent('wybranopostac', true)
  	cb('ok')
end)
