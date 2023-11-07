Citizen.CreateThread(function()
    SetDiscordAppId(917130841644212274)
    SetDiscordRichPresenceAsset('logo')
    SetDiscordRichPresenceAssetText('No Discord :(')
    SetDiscordRichPresenceAssetSmall('logo')
    SetDiscordRichPresenceAssetSmallText('Vex FiveM')
    AddTextEntry('FE_THDR_GTAO', 'Vex FiveM')
end)

Tick(function()

    local players = 0
    for k, v in ipairs(GetActivePlayers()) do
        players = players + 1
    end
   
    local displayStr = "Players: "..players .."/"..GetConvarInt('sv_maxclients', 48)
    local activeCharacter = RPC.Execute('vx-base:character:active')

    if (activeCharacter) then
        displayStr = "Playing as "..capitalize(activeCharacter.firstName).." "..capitalize(activeCharacter.lastName).." | "..displayStr
    end

    SetRichPresence(displayStr)
end, 60000)