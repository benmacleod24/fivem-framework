BOT_TOKEN = "Bot OTE3MTMwODQxNjQ0MjEyMjc0.GTxQDx.OQ8KndTIf7rrEfCZkXijGVJ-K3jD2hInnD74o8"
GUILD_ID = "908544950403211315"

-- Sourced from sadboilogan
-- https://github.com/sadboilogan/discord_perms/blob/master/discord_perms/server.lua

function DiscordRequest(method, endpoint, jsondata)
    local data = nil

    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {
            data=resultData, 
            code=errorCode, 
            headers=resultHeaders
        }
    end, 
    method, 
    #jsondata > 0 and json.encode(jsondata) or "", 
    {["Content-Type"] = "application/json", 
    ["Authorization"] = BOT_TOKEN}
    )

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

function GetRoles(user)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(GUILD_ID, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			return roles
		else
            
			Console:Error("An error occured, maybe they arent in the discord? Error: "..member.data, "Discord Perms")
			return false
		end
	else
        -- This should never happen, they can't join without discord.
		Console:Error("missing identifier", "Discord Perms")
		return false
	end
end

function IsRolePresent(user, role)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	local theRole = nil
	if type(role) == "number" then
		theRole = tostring(role)
	else
		theRole = Config.Roles[role]
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(GUILD_ID, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			for i=1, #roles do
				if roles[i] == theRole then
					return true
				end
			end
			return false
		else
			Console:Error("An error occured, maybe they arent in the discord? Error: "..member.data, "Discord Perms")
			return false
		end
	else
        -- This should never happen, they can't join without discord.
		Console:Error("missing identifier", "Discord Perms")
		return false
	end
end

Citizen.CreateThread(function()
	local guild = DiscordRequest("GET", "guilds/"..GUILD_ID, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		Console:Log("Connected to "..data.name.." successfully", "Discord Perms")
	else
		Console:Error("An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code), "Discord Perms") 
	end
end)

exports('IsRolePresent', IsRolePresent)
exports('DiscordRequest', DiscordRequest)
exports('GetRoles', GetRoles)