AddEventHandler('base:character:selected', function(character)
    local netId = character.netId

    -- Require netId when character is selected
    if (not netId) then
        exports['vx-lib']:ConsoleError("Base Permissions", "Could not gather player permissions (netId was null)")
    end

    -- Execute Permission functions
    SetUserInterfacePermissions(netId)
end)

function SetUserInterfacePermissions(netId)

    local permissions = {
        isAdmin = exports['vx-lib']:IsRolePresent(netId, 908545003368906834),
        isDev = exports['vx-lib']:IsRolePresent(netId, 934941872684671057)
    }

    TriggerClientEvent('nui:permissions:set', netId, permissions)
end