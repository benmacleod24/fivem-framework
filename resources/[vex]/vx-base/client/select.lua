FinalCoords = { x = 1058.8615722656, y = 239.39340209961, z = 130.17651367188, h = 127.55905151367 }
CharacterSelectCam = nil


function StartCamera()
    CharacterSelectCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    ped = PlayerPedId()

    -- Keep player from dying
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, false)
    FreezeEntityPosition(ped, true)

    -- Setting up Area
    RequestCollisionAtCoord(FinalCoords.x, FinalCoords.y, FinalCoords.z)

    -- Handle Loadingscreen & NUI
    ShutdownLoadingScreen()
    exports['vx-nui']:SetUIFocus(true, true)

    -- Settings up camera and player locations
    SetEntityCoordsNoOffset(ped, FinalCoords.x, FinalCoords.y, FinalCoords.z, false, false, false, false)
    NetworkResurrectLocalPlayer(FinalCoords.x, FinalCoords.y, FinalCoords.z, FinalCoords.h)
    SetCamActive(CharacterSelectCam, true)
    SetCamCoord(CharacterSelectCam, FinalCoords.x, FinalCoords.y, FinalCoords.z + 200)
    
    -- Smooht transition & Camera endpoint
    RenderScriptCams(true, false, 3000, true, false, false)
    SetCamParams(
        CharacterSelectCam,
        FinalCoords.x,
        FinalCoords.y,
        FinalCoords.z,
        0.0,
        0.0,
        120.0,
        40.0557, 
        9100, 
        0, 
        0, 
        2
    )
end

function StopSelectCam()
    DestroyCam(CharacterSelectCam, false)
    RenderScriptCams(false, false, 0, 1, 0)
    if (DoesCamExist(CharacterSelectCam)) then
       DestroyCam(CharacterSelectCam, false) 
    end
end

RegisterNetEvent("base:character:dropped", StartCamera)

Citizen.CreateThread(function()
    StartCamera()
end)

exports('StartCamera', StartCamera)
exports('StopSelectCam', StopSelectCam)