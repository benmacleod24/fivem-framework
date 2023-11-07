-- List of ATM Models
atmModels = {
    506770882, -- Fleeca ATM
    -870868698, -- Public ATM
}

function OpenATM()
    exports['vx-nui']:OpenApplication("atm", true)
end

-- Initalize the interact enrties on file start.
Citizen.CreateThread(function()

    for k,v in pairs(atmModels) do
        exports['vx-interact']:AddPeekEntryByModel(v, {
            id = "economy:atm:open",
            label = "Open ATM",
            icon = 'fa-solid fa-wallet'
        }, {
            isEnabled = true,
            cb = OpenATM,
        })
    end

end)