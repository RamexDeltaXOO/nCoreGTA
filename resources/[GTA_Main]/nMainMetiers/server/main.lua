--||@SuperCoolNinja.||--
local jobsDispo = {}
local ServerCallbacks = {}

function nameJob(metiers)
	return exports.ghmattimysql:execute("SELECT metiers FROM gta_metiers WHERE metiers = @metiers", {['@metiers'] = tostring(metiers)})
end

RegisterServerEvent('GTA:UpdateJob') --> Update le job du joueur.
AddEventHandler('GTA:UpdateJob', function(metiers)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	local myJob = nameJob(tostring(metiers))
	local job = tostring(metiers)
	exports.ghmattimysql:execute("UPDATE gta_joueurs SET `job`=@value WHERE license = @license", {['@value'] = job, ['@license'] = license})
end)

RegisterServerEvent('GTA:LoadJobsJoueur')
AddEventHandler('GTA:LoadJobsJoueur', function()
	local source = source	
	TriggerEvent('GTA:GetInfoJoueurs', source, function(data)
		local travail = data.job
		TriggerClientEvent('GTA:LoadClientJob', source, tostring(travail)) --> Update les jobs en générale coté client.
	end)
end)

--[[RegisterServerEvent("GTA:GetPlayerGrade") --> Retourne le grade du joueur.
AddEventHandler("GTA:GetPlayerGrade", function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	exports.ghmattimysql:execute("SELECT grade FROM gta_joueurs WHERE license = @username", {['@username'] = license}, function(result)
		TriggerClientEvent("GTA:LoadClientGrade",source, result[1].grade)
	end)
end)]]

RegisterServerEvent("GTA:ShowJobsDispo") --> Retourne le job du joueur.
AddEventHandler("GTA:ShowJobsDispo", function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	exports.ghmattimysql:execute("SELECT job FROM gta_joueurs WHERE license = @username", {['@username'] = license}, function(result)
		TriggerClientEvent("GTA:LoadClientJob",source, result[1].job) --> Refresh le job du joueur.
	end)
end)


RegisterServerEvent("GTA:GetJobsList")
AddEventHandler("GTA:GetJobsList", function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]
	exports.ghmattimysql:execute("SELECT metiers FROM gta_metiers WHERE emploi = @emploi", {['@emploi'] = "public"}, function(result)
		for k, v in pairs(jobsDispo) do
			jobsDispo[k] = nil
		end

		for k,v in ipairs(result) do 
			table.insert(jobsDispo, {
				jobName = result[k].metiers
			})
		end
		TriggerClientEvent("GTA:ListEmploi", source, jobsDispo)
	end)
end)