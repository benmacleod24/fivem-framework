-- Generate a table of all the players identities.
-- Stored aginst the id type with the value.
function IdentitiesFactory(netId)
    local identities = {}
    local identifiers = GetPlayerIdentifiers(netId)

    for k,v in pairs(identifiers) do
        local split = splitString(v, ":")
        local key = split[1]
        local value = split[2]

        identities[key] = value
    end

    return identities
end

-- Get players identity/identifiers, will return a kvp of ids or single va
-- Identitiers: string[] | string
function GetIdentifier(netId, identifiers)
    local identities = IdentitiesFactory(netId)
    
    -- Determine if the requested identifiers is a table.
    if (type(identifiers) == 'table') then
        local returnTable = {}

        -- Search through the table for identifiers.
        for _,identifier in pairs(identifiers) do

            -- Compare against identities table from the factory
            local _identifier = identities[identifier]

            if (_identifier) then
                print(_identifier, identifier)
                returnTable[identifier] = _identifier
            end
        end


        return returnTable
    end
    
    -- Return the identity if it's not a table.
    return identities[identifiers]
end

exports("GetIdentifier", GetIdentifier)