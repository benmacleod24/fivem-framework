inHotel = false

function GenerateHotel(hotelId)

    local position = GetHotelPosition(hotelId)

    -- Generate Interior
    -- Handled through our interior script
    local room = exports['vx-interiors']:GenerateInterior(position, `furnitured_lowapart`)

    return room
end

-- Gets hotel based off generator number and hotelId
-- Broke out so it could be used for offsets and such
function GetHotelPosition(hotelId)
    if (not hotelId) then return false end

    local generator = {x = -267.1969909668, y = -977.97259521484, z = -98.999984741211}
    generator.x = (generator.x) + ((hotelId * 20.0))
    generator.y = (generator.y) + ((hotelId * 20.0))

    return generator
end

function EnterHotel()
    local hotelId = RPC.Execute('hotel:get')
    local hotelPosition = GetHotelPosition(hotelId.id)
    if (not hotelPosition) then return end

    -- Generate Hotel Shell
    GenerateHotel(hotelId.id)

    -- Used to place the player at the proper height of the hotel
    hotelPosition.z = hotelPosition.z + 2

    -- Place player in new motel
    -- Placing player is handled by interior script
    -- We want to set weather a certain type so we don't get rain and shit
    exports['vx-interiors']:EnterInterior(hotelPosition, hotelId.id)
    TriggerEvent("vx-sync:weather:update", "EXTRASUNNY", 1.0)

    inHotel = hotelId.id
end

-- Exit the hotel and destroy shell through interior resource
function ExitHotel()
    local exit = { x = -267.0725402832, y = -959.68353271484, z = 31.217529296875, h = 212.59841918945 }
    exports['vx-interiors']:ExitInterior(exit)
    inHotel = false
end

-- Maybe break this out to a temp net event loop
-- Requiring them being in a hotel
-- Definity build a universal on click func
Tick(function()
    local position = GetEntityCoords(PlayerPedId())
    local hotelPosition = GetHotelPosition(inHotel)

    -- We want to make sure they are in an apartment
    if (inHotel and hotelPosition) then

        -- Hotel Offsets from generated hotel position
        local stash = vector3(hotelPosition.x - OFFSETS.stash.x, hotelPosition.y - OFFSETS.stash.y, hotelPosition.z + 2.5)
        local characterSwap = vector3(hotelPosition.x - OFFSETS.swap.x, hotelPosition.y - OFFSETS.swap.y, hotelPosition.z + 2.5)
        local exit = vector3(hotelPosition.x - OFFSETS.exit.x, hotelPosition.y - OFFSETS.exit.y, hotelPosition.z + 2.5)

        if (Vdist2(position, stash) <= 1.0) then
            print("Near Stash")
        end

        if (Vdist2(position, characterSwap) <= 2.0) then
            if (IsControlJustReleased(0, 38)) then
                ExitHotel()

                -- Needs to be routed through hotels server-side first
                RPC.Execute("hotel:character:drop")
            end
        end

        if (Vdist2(position, exit) <= 4.0) then
            if (IsControlJustReleased(0, 38)) then
                ExitHotel()
            end
        end
    end
end, 0)

RegisterCommand("exith", ExitHotel)
RegisterCommand("enter", EnterHotel)

RegisterNetEvent('hotel:spawn', function()
    EnterHotel()
    DoScreenFadeIn(300)
end)

exports('EnterHotel', EnterHotel)