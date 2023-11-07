-- Binds that are used globaly and do not fit in a single resouce
-- All Binds should use the event name and bool

function InteractRelease()
	TriggerEvent("binds:Interact")
end
RegisterCommand("-interact_use", InteractRelease)
exports["vx-keymapping"]:registerKeyMapping("Interact", "Use Key", "", "-interact_use", "E")

local Int = {
	["Finish"] = false,
	["Listen"] = false,
	["Event"] = nil
}

function Interact()-- E Default
	if not Int.Event then
		Int.Event = AddEventHandler("binds:Interact", function()
			if Int.Listen then
				Int.Finish = true
				SetTimeout(500, function() Int.Finish = false end)
			end
		end)
	end
	if not Int.Finish and not Int.Listen then
		Int.Listen = true
		SetTimeout(500, function() Int.Listen = false end)
	end
	if Int.Finish then
		Int.Finish = false
		return true
	end
	return false
end

exports("Interact", Interact)

-- disable pause
Citizen.CreateThread(function()
	while true do
		DisableControlAction(1, 199, true)
		Wait(5)
	end
end)