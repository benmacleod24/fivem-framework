RegisterCommand('nui:app', function(netId, args)
    OpenApplication(args[1])
end)

RegisterCommand('nui:close', function(netId, args)
    CloseApplication()
end)

RegisterCommand('nui:focus', function(netId, args)
    SetUIFocus(not IsFocused, not IsFocused)
end)