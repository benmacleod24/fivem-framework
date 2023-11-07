RegisterNUICallback('/context/menu/select', function(data, cb)
    cb(exports['vx-context']:ContextMenuSelected(data))
end)