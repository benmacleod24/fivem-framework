function roundedRadar()
    -- if not minimapEnabled or not inVehicle then
    --     DisplayRadar(0)
    --     SetRadarBigmapEnabled(true, false)
    --     Citizen.Wait(0)
    --     SetRadarBigmapEnabled(false, false)
    --     return
    -- end
    Citizen.CreateThread(function()
        -- if not appliedTextureChange and not useDefaultMinimap then
          RequestStreamedTextureDict("circlemap", false)
          while not HasStreamedTextureDictLoaded("circlemap") do
              Citizen.Wait(0)
          end
          AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasklg")
          AddReplaceTexture("platform:/textures/graphics", "radarmasklg", "circlemap", "radarmasklg")
          appliedTextureChange = true
        -- elseif appliedTextureChange and useDefaultMinimap then
        --   appliedTextureChange = false
        --   RemoveReplaceTexture("platform:/textures/graphics", "radarmasksm")
        --   RemoveReplaceTexture("platform:/textures/graphics", "radarmasklg")
        -- end

        SetBlipAlpha(GetNorthRadarBlip(), 0.0)
        -- SetBlipScale(GetMainPlayerBlipId(), 0.7)
        -- for k,v in pairs(exports["np-base"]:getModule("Blips")) do
        --     SetBlipScale(v["blip"], 0.7)
        -- end

        local screenX, screenY = GetScreenResolution()
        local modifier = screenY / screenX

        local baseXOffset = 0.0086875
        local baseYOffset = 0.74

        local baseSize    = 0.20 -- 20% of screen

        local baseXWidth  = 0.1313 -- baseSize * modifier -- %
        local baseYHeight = baseSize -- %

        local baseXNumber = screenX * baseSize  -- 256
        local baseYNumber = screenY * baseSize  -- 144

        local radiusX     = baseXNumber / 2     -- 128
        local radiusY     = baseYNumber / 2     -- 72

        local innerSquareSideSizeX = math.sqrt(radiusX * radiusX * 2) -- 181.0193
        local innerSquareSideSizeY = math.sqrt(radiusY * radiusY * 2) -- 101.8233

        local innerSizeX = ((innerSquareSideSizeX / screenX) - 0.01) * modifier
        local innerSizeY = innerSquareSideSizeY / screenY

        local innerOffsetX = (baseXWidth - innerSizeX) / 2
        local innerOffsetY = (baseYHeight - innerSizeY) / 2

        local innerMaskOffsetPercentX = (innerSquareSideSizeX / baseXNumber) * modifier

        local function setPos(type, posX, posY, sizeX, sizeY)
            SetMinimapComponentPosition(type, "I", "I", posX, posY, sizeX, sizeY)
        end
        -- if not useDefaultMinimap then
          setPos("minimap",       baseXOffset - (0.025 * modifier), baseYOffset - 0.025, baseXWidth + (0.05 * modifier), baseYHeight + 0.05)
          setPos("minimap_blur",  baseXOffset, baseYOffset, baseXWidth + 0.001, baseYHeight)
          -- setPos("minimap_mask",  baseXOffset + innerOffsetX, baseYOffset + innerOffsetY, innerSizeX, innerSizeY)
          -- The next one is FUCKING WEIRD.
          -- posX is based off top left 0.0 coords of minimap - 0.00 -> 1.00
          -- posY seems to be based off of the top of the minimap, with 0.75 representing 0% and 1.75 representing 100%
          -- sizeX is based off the size of the minimap - 0.00 -> 0.10
          -- sizeY seems to be height based on minimap size, ranging from -0.25 to 0.25
          setPos("minimap_mask", 0.1, 0.95, 0.09, 0.15)
          -- setPos("minimap_mask", 0.0, 0.75, 1.0, 1.0)
          -- setPos("minimap_mask",  baseXOffset, baseYOffset, baseXWidth, baseYHeight)
        -- else
        --   local function setPosLB(type, posX, posY, sizeX, sizeY)
        --       SetMinimapComponentPosition(type, "L", "B", posX, posY, sizeX, sizeY)
        --   end
        --   local offsetX = -0.018
        --   local offsetY = 0.025

        --   local defaultX = -0.0045
        --   local defaultY = 0.002

        --   local maskDiffX = 0.020 - defaultX
        --   local maskDiffY = 0.032 - defaultY
        --   local blurDiffX = -0.03 - defaultX
        --   local blurDiffY = 0.022 - defaultY

        --   local defaultMaskDiffX = 0.0245
        --   local defaultMaskDiffY = 0.03

        --   local defaultBlurDiffX = 0.0255
        --   local defaultBlurDiffY = 0.02

        --   setPosLB("minimap",       -0.0045,  -0.0245,  0.150, 0.18888)
        --   setPosLB("minimap_mask",  0.020,    0.022,  0.111, 0.159)
        --   setPosLB("minimap_blur",  -0.03,    0.002,  0.266, 0.237)
        -- end
        -- if not useDefaultMinimap then
          SetMinimapClipType(1)
        -- else
        --   SetMinimapClipType(0)
        -- end
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)
    end)
end

roundedRadar()