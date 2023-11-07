inInterior = false

-- Generate interior at given position
function GenerateInterior(spawn, interiorHash)

    -- Require spawn and interior hash
    if (not spawn or not interiorHash) then
        return false
    end

    local shell = CreateObject(interiorHash, spawn.x, spawn.y, spawn.z, false, false, false)
    
    RPC.Execute("interiors:create", {entity = shell, position = spawn})
    FreezeEntityPosition(shell, true)

    return shell
end

function EnterInterior(position, interiorId)

    -- We want to make sure the server allows this transaction to happen
    local serverCheck = RPC.Execute("interiors:enter", {interiorId = interiorId})
    if (not serverCheck) then
        return false
    end

    -- We want to freeze and not hurt player while spawning them
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityInvincible(PlayerPedId(), true)

    -- Position is based off what is passed through params
    SetEntityCoords(PlayerPedId(), position.x, position.y, position.z)
    SetEntityHeading(PlayerPedId(), position.h or 0.0)
    inInterior = interiorId

    -- Wait to fully spawn
    -- Unfreeze the player
    Wait(500)
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityInvincible(PlayerPedId(), false)

    return inInterior
end

-- Duplicates the enter interior func
-- Small tweaks to edit varibles and delete shell
function ExitInterior(position)

    -- Do NOT want to attemp this if not in interior
    if (not inInterior) then
        return false
    end

    -- Want to make sure the server says it's okay to exit
    local serverCheck =  RPC.Execute("interiors:exit", {interiorId = inInterior})
    if (serverCheck == false) then
        return false
    end

    -- We want to freeze and not hurt player while spawning them
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityInvincible(PlayerPedId(), true)

    -- Position is based off what is passed through params
    SetEntityCoords(PlayerPedId(), position.x, position.y, position.z)
    SetEntityHeading(PlayerPedId(), position.h or 0.0)
    interiorId = false

    -- Wait to fully spawn
    -- Unfreeze the player
    Wait(500)
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityInvincible(PlayerPedId(), false)

    -- Want to delete entity if no more players in it
    -- Definity Needs to be broken out into a func
    if (#serverCheck.playersInside <= 0) then
        DeleteObject(serverCheck.entity_id)
    end

    return interiorId
end


exports('GenerateInterior', GenerateInterior)
exports('EnterInterior', EnterInterior)
exports('ExitInterior', ExitInterior)