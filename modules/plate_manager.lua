
-- BozPlates integration with custom texture replacement and format enforcement

local plateFormats = {
    "### ###", -- e.g., 123 ABC
    "##A ###", -- e.g., 12A 345
    "###-###", -- e.g., 123-456
    "## ## ##", -- e.g., 12 34 56
    "#### AA", -- e.g., 1234 AB
    "AA ####"  -- e.g., AB 1234
}

local function randomPlate()
    local format = plateFormats[math.random(#plateFormats)]
    return string.gsub(format, "#", function() return math.random(0,9) end)
                 :gsub("A", function() return string.char(math.random(65,90)) end)
end

-- Apply all plate texture replacements
CreateThread(function()
    local plates = {
        "plate_mod_01", "plate_mod_02", "plate_mod_03", "plate_mod_04",
        "plate_mod_05", "plate_mod_06", "plate_mod_07"
    }

    for _, plate in ipairs(plates) do
        RemoveReplaceTexture("vehshare", plate)
        AddReplaceTexture("vehshare", plate, "plates", plate)
    end
end)

-- Enforce plate format when a new vehicle is created locally
AddEventHandler("entityCreated", function(entity)
    if DoesEntityExist(entity) and IsEntityAVehicle(entity) and NetworkHasControlOfEntity(entity) then
        Wait(100)
        local newPlate = randomPlate()
        SetVehicleNumberPlateText(entity, newPlate)
    end
end)
