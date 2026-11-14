function update_settings_globals()
    GlobalsSetValue("safer_tele.mat_check_range", tostring(ModSettingGet("safer_tele.mat_check_range")))
    GlobalsSetValue("safer_tele.check_steps", tostring(ModSettingGet("safer_tele.check_steps")))
end

ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/safer_tele/files/gun_actions.lua")

dofile_once("mods/safer_tele/files/nxml_things.lua")

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