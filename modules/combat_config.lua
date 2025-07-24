
if not Config.EnableCombatTweaks then return end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- Hide Ammo HUD
        HideHudComponentThisFrame(2)

        -- Weapon damage modifiers
        SetWeaponDamageModifierThisFrame(GetHashKey('WEAPON_STUNGUN'), 0.1)
        SetWeaponDamageModifierThisFrame(GetHashKey('WEAPON_NIGHTSTICK'), 0.1)
        SetWeaponDamageModifierThisFrame(GetHashKey('WEAPON_BEANBAG'), 0.1)
        SetWeaponDamageModifierThisFrame(GetHashKey('WEAPON_BATON'), 0.01)

        -- Disable melee actions while armed
        if IsPedArmed(PlayerPedId(), 6) and not IsPedInAnyVehicle(PlayerPedId()) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)
