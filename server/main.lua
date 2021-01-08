----Sotek#1234 ----  discord : https://discord.gg/MYb6TcHmq9


ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('::{{sLaKOD}}::#97653', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local playerGroup = xPlayer.getGroup()
        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb(nil)
        end
	else
		cb(nil)
	end
end)

ESX.RegisterServerCallback('::{{sLaKOD}}::#64135', function(source, cb)
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local playerLoadout = xPlayer.getLoadout()
		cb(playerLoadout)
	else
		cb(nil)
	end
end)

ESX.RegisterServerCallback('::{{WlzeMD}}::#17735', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bills = {}
	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', { -- change here if your sql is different
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				label      = result[i].label,
				amount     = result[i].amount
			})
		end
		cb(bills)
	end)
end)

RegisterServerEvent('::{{WZiChMD}}::#97842')
AddEventHandler('::{{WZiChMD}}::#97842', function(target, job, grade)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	targetXPlayer.setJob(job, grade)
	TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté " .. targetXPlayer.name .. "~w~.")
	TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~embauché par " .. sourceXPlayer.name .. "~w~.")
end)



RegisterServerEvent('::{{WZiChMD}}::#91435')
AddEventHandler('::{{WZiChMD}}::#91435', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local maximumgrade = tonumber(getMaximumGrade(sourceXPlayer.job.name)) - 1
	if (targetXPlayer.job.grade == maximumgrade) then
		TriggerClientEvent('esx:showNotification', _source, "Vous devez demander une autorisation du ~r~Gouvernement~w~.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) + 1
			local job = targetXPlayer.job.name
			targetXPlayer.setJob(job, grade)
			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~promu " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~promu par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		end
	end
end)

RegisterServerEvent('::{{WZiChMD}}::#87643')
AddEventHandler('::{{WZiChMD}}::#87643', function(target)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 0) then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ davantage.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) - 1
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~r~rétrogradé par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		end
	end
end)


RegisterServerEvent('::{{WZiChMD}}::#86735')
AddEventHandler('::{{WZiChMD}}::#86735', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local job = "unemployed"
	local grade = "0"
	if (sourceXPlayer.job.name == targetXPlayer.job.name) then
		targetXPlayer.setJob(job, grade)
		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré " .. targetXPlayer.name .. "~w~.")
		TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~viré par " .. sourceXPlayer.name .. "~w~.")
	else
		TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
	end
end)

RegisterServerEvent('::{{WZiChMD}}::#81346')
AddEventHandler('::{{WZiChMD}}::#81346', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local maximumgrade = tonumber(getMaximumGrade(sourceXPlayer.org.name)) -1
	if (targetXPlayer.org.grade == maximumgrade) then
		TriggerClientEvent('esx:showNotification', _source, "Vous devez demander une autorisation du ~r~Gouvernement~w~.")
	else
		if (sourceXPlayer.org.name == targetXPlayer.org.name) then -- maybe change org to job2 
			local gradeorg = tonumber(targetXPlayer.org.grade) + 1 -- maybe change org to job2
			local org = targetXPlayer.org.name -- maybe change org to job2
			targetXPlayer.setOrg(org, gradeorg) -- maybe change org to job2
			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~promu " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~promu par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		end
	end
end)

RegisterServerEvent('::{{WZiChMD}}::#79468')
AddEventHandler('::{{WZiChMD}}::#79468', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if (targetXPlayer.org.grade == 0) then -- maybe change org to job2
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ davantage.")
	else
		if (sourceXPlayer.org.name == targetXPlayer.org.name) then
			local gradeorg = tonumber(targetXPlayer.org.grade) - 1
			local org = targetXPlayer.org.name
			targetXPlayer.setOrg(org, gradeorg)
			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~r~rétrogradé par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		end
	end
end)

RegisterServerEvent('::{{WZiChMD}}::#78145')
AddEventHandler('::{{WZiChMD}}::#78145', function(target, org, gradeorg)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	targetXPlayer.setOrg(org, gradeorg)
	TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté " .. targetXPlayer.name .. "~w~.")
	TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~embauché par " .. sourceXPlayer.name .. "~w~.")
end)

RegisterServerEvent('::{{WZiChMD}}::#77495')
AddEventHandler('::{{WZiChMD}}::#77495', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local org = "organisation" -- maybe change org to job2
	local gradeorg = "0" -- maybe change org to job2
	if (sourceXPlayer.org.name == targetXPlayer.org.name) then
		targetXPlayer.setOrg(org, gradeorg)
		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré " .. targetXPlayer.name .. "~w~.")
		TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~viré par " .. sourceXPlayer.name .. "~w~.")
	else
		TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
	end
end)

--
-- Developped by Sotek#1234
-- Cleaned and edited by lwz#2051
--