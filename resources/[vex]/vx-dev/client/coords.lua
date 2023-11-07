SHOW_COORDS = false

function ToggleShowCoords(value)
    SHOW_COORDS = value
    return SHOW_COORDS
end

Tick(function()
    if (SHOW_COORDS) then
    
        local pInfo = EntityInfo(PlayerPedId())

        DrawText2D(0.04, 0.05, 0.05, -0.0, 0.40, 4, {255, 255, 255, 255}, 'Your Position Is:')
        DrawText2D(0.04, 0.05 * 1.5, 0.05, -0.0, 0.40, 4, {255, 255, 255, 255}, 'X: '..pInfo.x)
        DrawText2D(0.04, 0.05 * 2.0, 0.05, -0.0, 0.40, 4, {255, 255, 255, 255}, 'Y: '..pInfo.y)
        DrawText2D(0.04, 0.05 * 2.5, 0.05, -0.0, 0.40, 4, {255, 255, 255, 255}, 'Z: '..pInfo.z)
        DrawText2D(0.04, 0.05 * 3.0, 0.05, -0.0, 0.40, 4, {255, 255, 255, 255}, 'H: '..pInfo.h)

    else
        Wait(500)
    end
end, 5)

exports('ToggleShowCoords', ToggleShowCoords)