local nxml = dofile_once("mods/safer_tele/lib/nxml.lua")

local effects_tele = {
    "data/entities/misc/effect_teleportation.xml",
    "data/entities/misc/effect_teleportation_enemy.xml",
}
for _, path in ipairs(effects_tele) do
    for content in nxml.edit_file(path) do
        local gec = content:first_of("GameEffectComponent")
        gec:set("effect", "CUSTOM")
        gec:set("custom_effect_id", "SAFER_TELEPORTATION")
        gec:set("teleportation_probability", 0)
        content:create_children(
            { VariableStorageComponent  = {
                _tags = "safer_tele_frame",
                name = "safer_tele_frame",
                value_int = 0
            }},
            { VariableStorageComponent  = {
                _tags = "safer_tele_min_frame",
                name = "safer_tele_min_frame",
                value_int = gec:get("teleportation_delay_min_frames")
            }},
            { LuaComponent = {
                _enabled = true,
                script_source_file = "mods/safer_tele/files/effect_teleportation.lua",
                execute_every_n_frame = 1
	        }}
        )
    end
end

local effects_tele_unstable = {
    "data/entities/misc/effect_unstable_teleportation.xml",
}
for _, path in ipairs(effects_tele_unstable) do
    for content in nxml.edit_file(path) do
        local gec = content:first_of("GameEffectComponent")
        gec:set("effect", "CUSTOM")
        gec:set("custom_effect_id", "SAFER_UNSTABLE_TELEPORTATION")
        gec:set("teleportation_probability", 0)
        content:create_children(
            { VariableStorageComponent  = {
                _tags = "safer_tele_frame",
                name = "safer_tele_frame",
                value_int = 0
            }},
            { VariableStorageComponent  = {
                _tags = "safer_tele_min_frame",
                name = "safer_tele_min_frame",
                value_int = gec:get("teleportation_delay_min_frames")
            }},
            { LuaComponent = {
                _enabled = true,
                script_source_file = "mods/safer_tele/files/effect_unstable_teleportation.lua",
                execute_every_n_frame = 1
	        }}
        )
    end
end