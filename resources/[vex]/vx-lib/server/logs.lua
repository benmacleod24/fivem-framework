function addLog(netId, logType, logMessage, logData)
    local invokingResource = GetInvokingResource() or ""

    -- We don't want empty log types
    if (not logType or logType == nil or logType == "") then
        return false
    end

    local characterData = exports['vx-base']:GetPlayerActiveCharacter(netId)

    local qString = [[INSERT INTO logs_fivem (log_user, log_character, log_type, log_message, log_resource, log_data) VALUES (@logUser, @logCharacter, @logType, @logMessage, @logResource, @logData)]]
    local qData = {
        logType = logType,
        logMessage = logMessage,
        logUser = characterData.characterOwner,
        logCharacter = characterData.characterId,
        logResource = invokingResource,
        logData = json.encode(logData)
    }

    return exports.oxmysql:insertSync(qString, qData)
end

exports('addLog', addLog)