-- Sets Vehicle Engine state
-- Returns the state of the entity after setting it
function SetVehicleEngineState(vehicle, state)
    SetVehicleEngineOn(vehicle, state, 1, 1)
    return GetIsVehicleEngineRunning(vehicle)
end