Citizen.CreateThread(function()
    exports['vx-zones']:AddBoxZone('semitruck-duty', vector3(1196.2, -3253.31, 7.1), 11.2, 6.4, {
        name="semitruck-duty",
        heading=0,
        minZ=6.1,
        maxZ=10.7,
        data = {
            is_job = true,
            name = "semitrucking"
        }
    })
end)