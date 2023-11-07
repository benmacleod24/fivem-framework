-- [[ Hair Functions ]]
-- Get Hair colors into RGB string
function GetHairColors()
    colors = {}

    for i = 0, GetNumHairColors() - 1 do
        local r, g, b= GetPedHairRgbColor(i)
        table.insert(colors, {
            id = i,
            color = "rgb("..r..","..g..","..b..")"
        })
    end

    return colors
end

function SetHairColor(colorId)
    ped = PlayerPedId()
    SetPedHairColor(ped, colorId, colorId)
end

exports('SetHairColor', SetHairColor)
exports('GetHairColors', GetHairColors)