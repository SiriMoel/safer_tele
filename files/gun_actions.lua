dofile_once("mods/safer_tele/files/teleport/teleport.lua")

local new_actions = {
    {
		id = "SAFER_TELE_TEST",
		name = "safer tele test",
		description = "safer tele test",
		sprite = "data/ui_gfx/gun_actions/teleport_projectile_unidentified.png",
		type = ACTION_TYPE_UTILITY,
		spawn_level  = "10",
		spawn_probability = "0",
		price = 100,
		mana = 0,
		action = function()
            if reflecting then return end
            local caster = GetUpdatedEntityID()
            TeleportatiumTele(caster)
		end,
	},
}

for i, action in ipairs(new_actions) do
	table.insert(actions, action)
end