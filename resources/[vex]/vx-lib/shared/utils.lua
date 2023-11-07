-- Threads & Ticks
function Tick(f, ms)
    Citizen.CreateThread(function()
        while true do
            if f() then break end
            Wait(ms or 0)
        end
    end)
end

-- Entities
function EntityInfo(entity)
    local coords = GetEntityCoords(entity)
    local info = {
        x = round(coords[1], 4),
        y = round(coords[2], 4),
        z = round(coords[3], 4),
        h = round(GetEntityHeading(entity), 4),
        model = GetEntityModel(entity)
    }
    return info
end

-- Math & Time
function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

exports('round', round)

function timeToHMS(time)
	hour = math.floor(((time)/60)%24)
	minute = math.floor((time)%60)
	second = math.floor((time-math.floor(time))*60)

	return hour, minute, second
end

exports('timeToHMS', timeToHMS)

function GetTimeDifferenceInMinutes(valueOne, valueTwo)
    return os.difftime(valueOne, valueTwo / 1000) / 60
end

exports("GetTimeDifferenceInMinutes", GetTimeDifferenceInMinutes)


-- Drawing Text
-- 3D & 2D
function DrawText2D(x, y, width, height, scale, font, color, text)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(color[1], color[2], color[3], color[4])
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function DrawText3D(x, y, z, color, scale, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(color[1], color[2], color[3], color[4])
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- String Manipulation
function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function splitString (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

exports('splitString', splitString)

-- Conversations
function TableToVector3(tbl)
    if (not tbl) then return nil end
    
    local x = tbl.x or tbl[1]
    local y = tbl.y or tbl[2]
    local z = tbl.y or tbl[3]

    return vector3(x,y,z)
end

-- Animation
function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end


function TaskAnim(animDict, animName, typeAnim, speed)
    ClearPedSecondaryTask(PlayerPedId())
    if (DoesEntityExist(PlayerPedId())) then
        LoadAnimDict(animDict)
        ClearPedTasks(PlayerPedId())
        TaskPlayAnim(PlayerPedId(), animDict, animName, speed, 2.0, -1, typeAnim, 0, 0, 0, 0)
        RemoveAnimDict(animDict)
    end
end