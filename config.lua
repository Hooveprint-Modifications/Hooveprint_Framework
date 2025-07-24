-- Main Framework Config

Config = {}

Config.FrameworkName = "Custom Framework"
Config.BlipsEnabled = true
Config.CalmPedsEnabled = true

-- Fuel System Configuration (Merged from ox_fuel)

Config.Fuel = {
    Enabled = true,
    CostPerPercent = 0.4, -- Cost in $ per 1% of fuel

    AllowedPumpModels = {
        `prop_gas_pump_1a`,
        `prop_gas_pump_1b`,
        `prop_gas_pump_1c`,
        `prop_gas_pump_old2`
    },

    RefuelRate = 1.0, -- % added per interval
    RefuelInterval = 500, -- ms between fuel ticks

    NotifyOnStart = true,
    NotifyOnComplete = true,
    NotifyOnError = true
}

-- Vehicle Models to Suppress from Natural Spawn

Config.SuppressedVehicles = {
    "police", "police2", "police3", "ambulance", "sheriff", "sheriff2",
    "policeb", "polmav", "firetruk", "police4", "fbi", "fbi2", "police5"
}

-- Leave Engine Running Settings
Config.LeaveEngine = {
    RestrictEmergencyOnly = false, -- Only allow for emergency vehicles
    KeepDoorOpen = true            -- Keep door open when exiting
}

-- BozPlates Custom Plate Settings
Config.LicensePlateSystem = {
    Enabled = true,
    ReplaceTextures = true,
    ForceRandomPlateFormat = true,
    PlateFormats = {
        "### ###", -- 123 ABC
        "##A ###", -- 12A 345
        "###-###", -- 123-456
        "## ## ##", -- 12 34 56
        "#### AA", -- 1234 AB
        "AA ####"  -- AB 1234
    }
}

-- License Plate Format System
Config.PlateFormats = {
    ["plate_mod_01"] = {"### ###", "###-###", "####AA"},
    ["plate_mod_02"] = {"AA ####", "### ###"},
    ["plate_mod_03"] = {"##A ###"},
    ["plate_mod_04"] = {"#### AA"},
    ["plate_mod_05"] = {"## ## ##", "###-###"},
    ["plate_mod_06"] = {"### AAA"},
    ["plate_mod_07"] = {"### ###"}
}

Config.LicensePlateSystem = {
    Enabled = true,
    ReplaceTextures = true,
    ForceFormatOnSpawn = true
}
-- License Plate Formatting and Texture System
Config.PlateFormats = {
    plate01 = "11AAA111",         -- Blue on White 2 (Modern SA)
    plate02 = "11AAA111",         -- Yellow on Black
    plate03 = "11AAA111",         -- Yellow on Blue
    plate04 = "11AAA111",         -- Blue on White 1 (90s SA)
    plate05 = "^11111111",        -- Blue on White 3 (Exempt)
    yankton_plate = "AAA  111"    -- Yankton
}

Config.PlateTextures = {
    { old = "plate01", new = "plate01" },
    { old = "plate01_n", new = "plate01_n" },
    { old = "plate02", new = "plate02" },
    { old = "plate02_n", new = "plate02_n" },
    { old = "plate03", new = "plate03" },
    { old = "plate03_n", new = "plate03_n" },
    { old = "plate04", new = "plate04" },
    { old = "plate04_n", new = "plate04_n" },
    { old = "plate05", new = "plate05" },
    { old = "plate05_n", new = "plate05_n" },
    { old = "yankton_plate", new = "yankton_plate" },
    { old = "yankton_plate_n", new = "yankton_plate_n" },
    { old = "vehicle_generic_plate_font", new = "vehicle_generic_plate_font" },
    { old = "vehicle_generic_plate_font_n", new = "vehicle_generic_plate_font_n" }
}
