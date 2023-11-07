inPrison = false

RegisterNetEvent("prison:timecheck:loop", function()
    Citizen.CreateThread(function()
        while (CurrentZone == "prison_time_check") do

            if (exports['vx-keymapping']:Interact() and CurrentZone == "prison_time_check") then
                GenerateTimeCheckContextMenu()
            end

            Citizen.Wait(0)
        end
    end)
end)

function GenerateTimeCheckContextMenu()
    local timeLeftInPrison = RPC.Execute("prison:timeLeftInPrison")

    local timeLeftTitle = "Time Left in Sentence"
    local timeLeftString = math.floor(timeLeftInPrison).." Months Left"

    if (timeLeftInPrison <= 0) then
        timeLeftTitle = "You have Served your sentence"
        timeLeftString = "Get the fuck outta here"
    end

    local menuSchema = {
        {
            id = 1,
            title = timeLeftTitle,
            description = timeLeftString,
            icon = "fa-solid fa-stopwatch"
        },
        {
            id = 2,
            title = "Swap Character",
            description = "Maybe you shouldn't have went to prison, idiot!",
            icon = "fa-solid fa-shuffle",
            data = {
                event = "prison:character:drop"
            }
        }
    }

   exports['vx-context']:OpenContextMenu(menuSchema)
end