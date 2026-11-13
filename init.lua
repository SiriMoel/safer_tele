ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/safer_tele/files/gun_actions.lua")

dofile_once("mods/safer_tele/files/nxml_things.lua")

function OnWorldPreUpdate()
    
end

function OnPlayerSpawned(player)

end

function OnPausedChanged(is_paused, is_inventory_pause)
    if is_paused then
        
    end
end