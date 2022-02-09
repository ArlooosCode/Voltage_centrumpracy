ESX = nil
local dzielnica = GetConvar("cfgdzielnica", "false")
TriggerEvent('esx:getShtestaredObjtestect', function(obj) ESX = obj end)

RegisterServerEvent('route68centrumpracy:ustalPrace')
AddEventHandler('route68centrumpracy:ustalPrace', function(job, detect)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.protect ~= detect then
		TriggerEvent('DAWIJMDAWIJD8945J09J9GEJG90JE5490', xPlayer.source, 'ban', 'Event Detect', GetCurrentResourceName())
		return
	end
	
	if job == 'kawiarnia' then
		if dzielnica == 'Skye' then
			xPlayer.setJob(job, 0)
			TriggerClientEvent('esx:showNotification', _source, 'Masz nową pracę!')
		else
			TriggerClientEvent('esx:showNotification', _source, '~r~Zatrudnienie możliwe tylko w Kawiarni na północy LS!')
		end
	else
		xPlayer.setJob(job, 0)
		TriggerClientEvent('esx:showNotification', _source, 'Masz nową pracę!')
	end
end)

ESX.RegisterServerCallback('centrumpracy:getkursy', function(source, cb, what)	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.fetchAll('SELECT '..what..' FROM users WHERE identifier = @identifier',{
	['@identifier'] = xPlayer.identifier
	}, function(result)	
		if result[1] ~= nil then
			if what == 'kawa' then
				count = result[1].kawa
			elseif what == 'zlomkursy' then
				count = result[1].zlomkursy
			elseif what == 'sadkursy' then
				count = result[1].sadkursy
			elseif what == 'kursy' then
				count = result[1].kursy
			end
			cb(tonumber(count))
		else
			cb(0)
		end
	end)
end)