
-- ox_target vehicle deletion integration
local distanceToCheck = 5.0
local numRetries = 5

-- Get vehicle in direction
local function GetVehicleInDirection(entFrom, coordFrom, coordTo)
    local rayHandle = StartShapeTestCapsule(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    if IsEntityAVehicle(vehicle) then
        return vehicle
    end
end

-- Notification (can be replaced with ox_lib notify)
local function Notify(text)
    lib.notify({description = text})
end

-- Delete vehicle logic
local function DeleteGivenVehicle(veh, timeoutMax)
    local timeout = 0
    SetEntityAsMissionEntity(veh, true, true)
    DeleteVehicle(veh)

    if DoesEntityExist(veh) then
        while DoesEntityExist(veh) and timeout < timeoutMax do
            DeleteVehicle(veh)
            if not DoesEntityExist(veh) then
                Notify("~g~Vehicle deleted.")
                break
            end
            timeout = timeout + 1
            Wait(500)
            if DoesEntityExist(veh) and timeout == timeoutMax - 1 then
                Notify("~r~Failed to delete vehicle after retries.")
            end
        end
    else
        Notify("~g~Vehicle deleted.")
    end
end

-- Register ox_target interaction
exports('RegisterVehicleDeleteTarget', function()
    exports.ox_target:addGlobalVehicle({
        label = 'Delete Vehicle',
        icon = 'fas fa-trash',
        groups = 'admin',
        distance = 2.0,
        onSelect = function(data)
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local veh = GetVehiclePedIsIn(ped, false)
                if GetPedInVehicleSeat(veh, -1) == ped then
                    DeleteGivenVehicle(veh, numRetries)
                else
                    Notify("~y~You must be in the driver's seat to delete.")
                end
            else
                local pos = GetEntityCoords(ped)
                local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(ped, 0.0, distanceToCheck, 0.0)
                local veh = GetVehicleInDirection(ped, pos, inFrontOfPlayer)
                if veh then
                    DeleteGivenVehicle(veh, numRetries)
                else
                    Notify("~y~You must be near a vehicle to delete it.")
                end
            end
        end
    })
end)

-- Automatically register on resource start
CreateThread(function()
    exports['custom_framework']:RegisterVehicleDeleteTarget()
end)
