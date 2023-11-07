-- RegisterCommand
-- Allowing for command param to be table.
local nativeCallback = RegisterCommand
function RegisterCommand(command, callback)

    if (type(command) == 'table') then
        for i = 1, #command do
            nativeCallback(command[i], callback, false)
        end
        return;
    end

    nativeCallback(command, callback, false)
end