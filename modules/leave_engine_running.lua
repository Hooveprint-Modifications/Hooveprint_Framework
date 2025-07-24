
-- Leave Engine Running Feature (Modified for Config Integration)

local notify = false

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if not notify and IsPedInAnyVehicle(ped, true) then
            lib.notify({description = "Hold ~b~F~s~ to exit without stopping the engine.", type = "info"})
            notify = true
        end

        if veh and IsPedInAnyVehicle(ped, false) and IsControlPressed(0, 75) and not IsEntityDead(ped) then
            Wait(150)
            if IsPedInAnyVehicle(ped, false) and IsControlPressed(0, 75) and not IsEntityDead(ped) then
                local restrict = Config.LeaveEngine.RestrictEmergencyOnly
                if not restrict or GetVehicleClass(veh) == 18 then
                    SetVehicleEngineOn(veh, true, true, false)
                    local taskFlag = Config.LeaveEngine.KeepDoorOpen and 256 or 0
                    TaskLeaveVehicle(ped, veh, taskFlag)
                end
            end
        end
    end
end)
