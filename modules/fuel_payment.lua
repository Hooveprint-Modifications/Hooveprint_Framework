
-- Custom ox_fuel integration using Azure Framework billing

local function attemptPayment(price)
    local success = lib.callback.await('azure_economy:removeMoney', false, price, 'cash')
    return success
end

AddEventHandler('ox_fuel:pay', function(price, station)
    local src = source
    if not price or price <= 0 then return end

    local success = attemptPayment(price)
    if not success then
        TriggerClientEvent('ox_fuel:paymentFailed', src)
    else
        TriggerClientEvent('ox_fuel:paymentSuccess', src)
    end
end)

-- Replace ox_fuel's default export trigger with our Azure Framework logic
exports('processFuelPayment', function(price)
    return attemptPayment(price)
end)
