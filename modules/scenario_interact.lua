local radius = 1.5

if not Config.EnableScenarioInteraction then return end

local function canPedUseScenarioNearCoords(playerPed, coords)
    return DoesScenarioExistInArea(coords, radius, true)
        and not IsScenarioOccupied(coords, radius, true)
        and not IsPedInAnyVehicle(playerPed, true)
end

local isHelpShown = false

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)

        if IsPedUsingAnyScenario(playerPed) then
            if not isHelpShown then
                lib.showTextUI("[ENTER] to stop animation", {
                    position = "right-center",
                    icon = "fa-hand-paper"
                })
                isHelpShown = true
            end

            if IsControlJustPressed(0, 23) then -- Enter
                ClearPedTasks(playerPed)
                lib.hideTextUI()
                isHelpShown = false
            end

            Wait(0)

        elseif canPedUseScenarioNearCoords(playerPed, coords) then
            if not isHelpShown then
                lib.showTextUI("[E] to use nearby animation", {
                    position = "right-center",
                    icon = "fa-person-running"
                })
                isHelpShown = true
            end

            if IsControlJustPressed(0, 38) then -- E
                TaskUseNearestScenarioToCoordWarp(playerPed, coords, radius, -1)
                lib.hideTextUI()
                isHelpShown = false
            end

            Wait(0)

        else
            if isHelpShown then
                lib.hideTextUI()
                isHelpShown = false
            end

            Wait(1000)
        end
    end
end)
