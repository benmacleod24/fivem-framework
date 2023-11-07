Config = {}
Config.Doors = {}
Config.Funcs = {}

Config.Funcs.GetDoorByZone = function(zoneName)
    for k,v in pairs(Config.Doors) do
        if (v.zone and v.zone == zoneName) then
            return k
        end
    end
end

Config.Doors[1] = {
    isDisabled = false,
    isLocked = true,
    model = 1830360419,
    position = vector3(464.1566, -997.5093, 26.3707),
    auth = {"leo"}
}

Config.Doors[2] = {
    isDisabled = false,
    isLocked = true,
    model = 2130672747,
    position = vector3(431.4119, -1000.731, 27.63248),
    zone = "mrpd_bottom_garage_left",
    automatic = {
        distance = 10.0,
        rate = 1.0
    }
}

Config.Doors[3] = {
    isDisabled = false,
    isLocked = true,
    model = -288803980,
    position = vector3(467.5222, -1000.544, 26.40548),
}

Config.Doors[4] = {
    isDisabled = false,
    isLocked = true,
    model = -288803980,
    position = vector3(469.9274, -1000.544, 26.40548),
}

Config.Doors[5] = {
    isDisabled = false,
    isLocked = true,
    model = -1547307588,
    position = vector3(443.0618, -998.7462, 30.8153),
}

Config.Doors[6] = {
    isDisabled = false,
    isLocked = true,
    model = -1547307588,
    position = vector3(440.7392, -998.7462, 30.8153),
}

Config.Doors[7] = {
    isDisabled = false,
    isLocked = true,
    model = -96679321,
    position = vector3(440.5201, -986.2335, 30.82319),
}

Config.Doors[8] = {
    isDisabled = false,
    isLocked = true,
    model = -1868050792,
    position = vector3(410.00567626953, -1020.0768432617, 29.362764358521),
    zone = "mrpd_bollard_01",
    automatic = {
        rate = 1.0,
        distance = 10.0
    }
}