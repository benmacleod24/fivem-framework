function registerKeyMapping(category, description, onKeyDown, onKeyUp, default, type, opts)

    if (not default) then default = '' end
    if (not type) then type = 'keyboard' end

    if (not category) then
        exports['vx-lib']:Console():Error('Category not provided for key.')
    end

    if (not description) then
        exports['vx-lib']:Console():Error('Description not provided for key.')
    end

    nativeDescription = '('..category..') '..description
    keyDownCommand = '+key_cmd__'..onKeyDown
    keyUpCommand = '-key_cmd__'..onKeyDown

    RegisterCommand(keyDownCommand, function()
        if (opts and opts.event) then TriggerEvent('vx-keymapping:key_event', true) end
        ExecuteCommand(onKeyDown)
    end, false)

    RegisterCommand(keyUpCommand, function()
        if (opts and opts.event) then TriggerEvent('vx-keymapping:key_event', false) end
        ExecuteCommand(onKeyUp)
    end, false)

    RegisterKeyMapping(keyDownCommand, nativeDescription, type, default)
end

exports('registerKeyMapping', registerKeyMapping)