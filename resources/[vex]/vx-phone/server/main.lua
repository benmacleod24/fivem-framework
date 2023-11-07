-- Generate a 10 digit phone number
-- Option to pass an area code in for burner phones
function GeneratePhoneNumber(area_code)
    area_code = area_code

    -- Allow for different area codes, IE burner phones
    if (not area_code) then
        area_code = "310"
    end

    -- These complete the phone number
    -- exchange_code is the middle section
    -- line_number is the last 4
    local exchange_code = math.random(0, 9)..math.random(0, 9)..math.random(0, 9)
    local line_number = math.random(0, 9)..math.random(0, 9)..math.random(0, 9)..math.random(0, 9)

    return area_code..exchange_code..line_number
end

-- Verifys a phone number is unique
-- If not unique we will generate a new one and check again
-- IDK if this will return to the origin of it's call (if called again)
function VerifyPhoneNumberIsUnique(phone_number)
    phone_number = phone_number

    local query = "SELECT * FROM fivem_phones WHERE phone_number = ?"
    local phone_numbers = exports.oxmysql:fetchSync(query, { phone_number })

    if (#phone_numbers > 0 or phone_numbers[1]) then
        phone_number = GeneratePhoneNumber(string.sub(phone_number, 1, 3))
        VerifyPhoneNumberIsUnique(phone_number)
    end

    return phone_number
end

-- Root of generating a new phone & Handles making the new phone number and verifying it
-- Allows options of area_code and is_burner
-- Burner basically allows it to display as a non-owned phone (feature that will come later)
function GenerateNewPhone(net_id, area_code, is_burner)
    local phone_number = GeneratePhoneNumber(area_code)
    local is_unique = VerifyPhoneNumberIsUnique(phone_number)
    
    if (not is_unique) then return false end

    local character = exports['vx-base']:GetPlayerActiveCharacter(net_id)

    local query = "INSERT INTO fivem_phones (character_id, phone_number, is_burner) VALUES (?, ?, ?)"
    local results = exports.oxmysql:insertSync(query, {character.characterId, phone_number, is_burner})

    if (not results) then return false end
    return results
end

-- Returns character based of phone number provided
function GetCharacterByPhoneNumber(phone_number)
    local query = "SELECT character_id FROM fivem_phones WHERE phone_number = ? and is_burner = 0"
    local results = exports.oxmysql:singleSync(query, { phone_number })

    return exports['vx-base']:GetCharacterById(results)
end

-- Returns net_id based of phone number provided
function GetNetIdByPhoneNumber(phone_number)
    local character_id = GetCharacterByPhoneNumber(phone_number)
    local character = exports['vx-base']:GetCharacterById(character_id)

    return character.netId
end

-- Returns phone number based of character id provided
function GetPhoneNumberByCharacterId(character_id)
    local query = "SELECT phone_number FROM fivem_phones WHERE character_id = ? and is_burner = 0"
    local results = exports.oxmysql:singleSync(query, { character_id })

    return results
end

exports("GetCharacterByPhoneNumber", GetCharacterByPhoneNumber)
exports("GetNetIdByPhoneNumber", GetNetIdByPhoneNumber)
exports("GetPhoneNumberByCharacterId", GetPhoneNumberByCharacterId)
exports("GenerateNewPhone", GenerateNewPhone)