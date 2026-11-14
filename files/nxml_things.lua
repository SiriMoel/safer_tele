local nxml = dofile_once("mods/safer_tele/lib/nxml.lua")

local effects_tele = {
    {
        path = "data/entities/misc/effect_teleportation.xml",
        setting = "safer_tele.safer_teleportatium",
    },
    {
        path = "data/entities/misc/effect_teleportation_enemy.xml",
        setting = "safer_tele.safer_mage_tele",
    },
}
for _, v in ipairs(effects_tele) do
    local ok = true
    if v.setting ~= nil then
        ok = ModSettingGet(v.setting)
    end
    if ok then
        for content in nxml.edit_file(v.path) do
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
end

local effects_tele_unstable = {
    {
        path = "data/entities/misc/effect_unstable_teleportation.xml",
        setting = "safer_tele.safer_unstable_teleportatium",
    },
}
for _, v in ipairs(effects_tele_unstable) do
    local ok = true
    if v.setting ~= nil then
        ok = ModSettingGet(v.setting)
    end
    if ok then
        for content in nxml.edit_file(v.path) do
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
end