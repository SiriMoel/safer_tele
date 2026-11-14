dofile_once("mods/safer_tele/files/teleport/teleport.lua")

function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
	if damage > 0 then
		damage = damage * 0.8
	end
    return damage, critical_hit_chance
end

function damage_received(damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible)
	local this = GetUpdatedEntityID()
	if damage >= 0 then
		local comp_frame = EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "safer_tele_perk")
		if comp_frame ~= nil then
			local frame = ComponentGetValue2(comp_frame, "value_int")
			local frame_now = GameGetFrameNum()
			if frame_now >= frame + 60 then
				TeleportatiumTele(this)
				ComponentSetValue2(comp_frame, "value_int", frame_now)
			end
		end
	end
end