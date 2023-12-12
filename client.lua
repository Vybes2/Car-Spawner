RegisterCommand("car", function(source, args)
    local vehicleName = args[1] or 'adder'

    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Citizen.Wait(0)
    end

    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local currentVehicle = GetVehiclePedIsIn(playerPed, false)

    if IsPedInAnyVehicle(playerPed) then
        DeleteEntity(currentVehicle)
    
        Citizen.Wait(1)
    
        local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

        SetPedIntoVehicle(playerPed, vehicle, -1)

        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(vehicleName)
    end
end, false)

TriggerEvent("chat:addSuggestion", "/car", "Spawns the car of your choice")
