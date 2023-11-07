-- Collects all records pertaining to a character id from `fivem_character_jobs`
function FetchCharactersJob(netId)
    local characterId = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId

    local query = [[
        SELECT *
        FROM fivem_character_jobs cj
        INNER JOIN fivem_jobs fj
        WHERE cj.character_id = ?
    ]]

    local jobs = exports.oxmysql:executeSync(query, {characterId})
    return jobs
end

-- This runs against the `fivem_character_jobs` table to see if they have a job
function DoesPlayerHaveJob(netId, jobName)
    if (not exports['vx-base'] or not exports['vx-base']:GetPlayerActiveCharacter(netId)) then return end
    local characterId = exports['vx-base']:GetPlayerActiveCharacter(netId).characterId

    local query = [[
        SELECT cj.permission_level, fj.name 
        FROM fivem_character_jobs cj
        INNER JOIN fivem_jobs fj
        WHERE cj.character_id = ? and fj.name = ?
    ]]

    local job = exports.oxmysql:singleSync(query, {characterId, jobName})
    
    if (not job or job == nil) then return false end
    return true, job
end