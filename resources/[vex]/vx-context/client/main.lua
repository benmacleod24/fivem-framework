IsMenuOpen = false
GlobalPromise = nil

-- opts = { returnPromise = boolean }
-- Returns a promise if for a varible (returnPromise Required)
function OpenContextMenu(menuSchema, returnsWithPromise)
    if (GlobalPromise) then return end
    if (not menuSchema) then return end

    returnsWithPromise = returnsWithPromise or false

    exports['vx-nui']:DispatchNui('nui:context:set_menu', menuSchema)
    exports['vx-nui']:SetUIFocus(true, true)
    exports['vx-nui']:OpenApplication('context')

    if (returnsWithPromise) then
        GlobalPromise = promise.new()
        return  Citizen.Await(GlobalPromise)
    end
end

RegisterNetEvent('vx-context:open-context')
AddEventHandler('vx-context:open-context', OpenContextMenu)

-- Handle menu selection and resolve the promise.
function ContextMenuSelected(data)
    if (not data) then return true end
    

    if (GlobalPromise ~= nil) then

        if (data.data ~= nil) then
            GlobalPromise:resolve(data.data)
        else
            GlobalPromise:resolve(true)
        end

        IsMenuOpen = false
        GlobalPromise = nil
    end

    if (data.data and data.data.event) then
        TriggerEvent(data.data.event, data.data)
        TriggerServerEvent(data.data.event, data.data)
    end

    GlobalPromise = nil
    exports['vx-nui']:CloseApplication()
    return true
end

exports('OpenContextMenu', OpenContextMenu)
exports('ContextMenuSelected', ContextMenuSelected)

--[[

    Menu Schema 
    This needs to be an Array/Table

     {
         id = number
         title = string
         description = string
         icon = string (Use font awesome **free icons**)
         data = {
             event = string
         }
     }

]]