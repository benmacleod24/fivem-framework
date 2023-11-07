Config = {}

Config.Cells = {
    [1] = { x = 1767.5340576172, y = 2501.2746582031, z = 45.725219726562, h = 212.59841918945 },
    [2] = { x = 1764.7385253906, y = 2498.9011230469, z = 45.725219726562, h = 209.76377868652 },
    [3] = { x = 1761.6527099609, y = 2497.1208496094, z = 45.725219726562, h = 204.09449768066 },
}

Citizen.CreateThread(function()

    -- Prison Polyzone
    exports['vx-zones']:AddPolyZone("prison", {
        vector2(1761.5638427734, 2410.3581542969),
        vector2(1658.9371337891, 2394.29296875),
        vector2(1540.2492675781, 2469.8410644531),
        vector2(1535.0080566406, 2585.3569335938),
        vector2(1569.8275146484, 2680.8308105469),
        vector2(1649.74609375, 2758.0393066406),
        vector2(1773.3669433594, 2762.767578125),
        vector2(1848.9772949219, 2699.8627929688),
        vector2(1824.4252929688, 2620.8491210938),
        vector2(1845.3806152344, 2612.5668945312),
        vector2(1844.6472167969, 2568.9545898438),
        vector2(1818.7222900391, 2567.5981445312),
        vector2(1817.0460205078, 2531.2172851562),
        vector2(1824.7937011719, 2475.6281738281)
      }, {
        name="prison",
        --minZ = 53.685684204102,
        --maxZ = 69.405700683594
      })

      exports['vx-zones']:AddBoxZone("prison_time_check", vector3(1828.92, 2581.05, 46.01), 3.25, 5.1, {
        name="prison_time_check",
        heading=1,
        --debugPoly=true,
        minZ=44.81,
        maxZ=48.81
      })
end)