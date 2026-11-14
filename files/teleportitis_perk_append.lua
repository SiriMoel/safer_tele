for _, v in ipairs(perk_list) do
    if v.id == "TELEPORTITIS" then
        v.game_effect = nil
        v.func = function(entity_perk_item, entity_who_picked, item_name)
			local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "LuaComponent", "safer_tele_perk") or EntityAddComponent2(entity_who_picked, "LuaComponent", {
        	    _tags="safer_tele_perk",
                script_damage_about_to_be_received="mods/safer_tele/files/teleportitis_perk.lua",
        	    script_damage_received="mods/safer_tele/files/teleportitis_perk.lua",
        	})
            local comp2 = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "VariableStorageComponent", "safer_tele_perk") or EntityAddComponent2(entity_who_picked, "VariableStorageComponent", {
        	    _tags="safer_tele_perk",
        	    name="safer_tele_perk_frame",
                value_int="0",
        	})
		end
        v.func_remove = function(entity_who_picked)
			local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "LuaComponent", "safer_tele_perk")
			if comp ~= nil then
    			EntityRemoveComponent(entity_who_picked, comp)
			end
            local comp2 = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "VariableStorageComponent", "safer_tele_perk")
			if comp2 ~= nil then
    			EntityRemoveComponent(entity_who_picked, comp2)
			end
		end
    end
end