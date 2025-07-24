
-- Refactored client-side fuel script using Config.Fuel

local isFueling = false

-- Triggered by ox_target
function StartFueling(pumpEntity)
    if not Config.Fuel.Enabled then return end

    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle == 0 then
        vehicle = lib.getClosestVehicle(GetEntityCoords(ped), 5.0)
    end

    if not DoesEntityExist(vehicle) then
        if Config.Fuel.NotifyOnError then
            lib.notify({description = 'No vehicle nearby!', type = 'error'})
        end
        return
    end

    local fuelLevel = GetVehicleFuelLevel(vehicle)
    if fuelLevel >= 98 then
        if Config.Fuel.NotifyOnError then
            lib.notify({description = 'Fuel tank already full.', type = 'inform'})
        end
        return
    end

    local fuelPrice = (100 - fuelLevel) * Config.Fuel.CostPerPercent
    if Config.Fuel.NotifyOnStart then
        lib.notify({description = string.format('Fueling vehicle for $%.2f', fuelPrice)})
    end

    local success = lib.callback.await('ox_fuel:pay', false, fuelPrice)
    if not success then return end

    isFueling = true
    TaskTurnPedToFaceEntity(ped, pumpEntity, 1000)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)

    CreateThread(function()
        while isFueling do
            Wait(Config.Fuel.RefuelInterval)
            fuelLevel = fuelLevel + Config.Fuel.RefuelRate
            SetVehicleFuelLevel(vehicle, fuelLevel)
            if fuelLevel >= 100 then
                isFueling = false
            end
        end
        ClearPedTasksImmediately(ped)
        if Config.Fuel.NotifyOnComplete then
            lib.notify({description = "Fueling complete!"})
        end
    end)
end

-- ox_target registration
CreateThread(function()
    exports.ox_target:addModel(Config.Fuel.AllowedPumpModels, {
        {
            icon = 'fa-solid fa-gas-pump',
            label = 'Refuel Vehicle',
            onSelect = function(data)
                StartFueling(data.entity)
            end,
            canInteract = function(entity, distance, coords, name)
                return not isFueling
            end
        }
    })
end)
