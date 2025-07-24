
-- Suppress emergency vehicles and clear cops in player vicinity using Config.SuppressedVehicles

CreateThread(function()
    for _, model in ipairs(Config.SuppressedVehicles or {}) do
        SetVehicleModelIsSuppressed(GetHashKey(model), true)
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        ClearAreaOfCops(coords.x, coords.y, coords.z, 1000.0)
    end
end)
