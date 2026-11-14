function update_settings_globals()
    GlobalsSetValue("safer_tele.mat_check_range", tostring(ModSettingGet("safer_tele.mat_check_range")))
    GlobalsSetValue("safer_tele.check_steps", tostring(ModSettingGet("safer_tele.check_steps")))
    GlobalsSetValue("safer_tele.slow_fall_effect", tostring(ModSettingGet("safer_tele.slow_fall_effect")))
    GlobalsSetValue("safer_tele.slow_fall_duration", tostring(ModSettingGet("safer_tele.slow_fall_duration")))
    GlobalsSetValue("safer_tele.slower_fall", tostring(ModSettingGet("safer_tele.slower_fall")))
    GlobalsSetValue("safer_tele.max_tries", tostring(ModSettingGet("safer_tele.max_tries")))
    GlobalsSetValue("safer_tele.velocity", tostring(ModSettingGet("safer_tele.velocity")))
    GlobalsSetValue("safer_tele.avoid_gas", tostring(ModSettingGet("safer_tele.avoid_gas")))
    GlobalsSetValue("safer_tele.biome_check", tostring(ModSettingGet("safer_tele.biome_check")))
end

--ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/safer_tele/files/gun_actions.lua")

dofile_once("mods/safer_tele/files/nxml_things.lua")

if ModSettingGet("safer_tele.safer_teleportitis") then
    ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/safer_tele/files/teleportitis_perk_append.lua")
end

local translations = ModTextFileGetContent("data/translations/common.csv")
if translations ~= nil then
    while translations:find("\r\n\r\n") do
    	translations = translations:gsub("\r\n\r\n","\r\n")
    end
    local new_translations = ModTextFileGetContent(table.concat({"mods/safer_tele/files/translations.csv"}))
    translations = translations .. new_translations
    ModTextFileSetContent("data/translations/common.csv", translations)
end

function OnWorldInitialized() 
    update_settings_globals()
end

function OnPlayerSpawned(player)

end

function OnPausedChanged(is_paused, is_inventory_pause)
    if is_paused then
        update_settings_globals()
    end
end