teleport_random = dofile_once("mods/safer_tele/files/teleport/teleport_random.lua")
teleport_aim = dofile_once("mods/safer_tele/files/teleport/teleport_aim.lua")

function finish_teleport(entity, x, y)
    EntitySetTransform(entity, x, y)
    if GlobalsGetValue("safer_tele.velocity", "true") == "true" then
        local comp_vel = EntityGetFirstComponent(entity, "VelocityComponent")
        if comp_vel ~= nil then
            ComponentSetValue2(comp_vel, "mVelocity", 0, 0)
        end
        local comp_char_data = EntityGetFirstComponent(entity, "CharacterDataComponent")
        if comp_char_data ~= nil then
            ComponentSetValue2(comp_char_data, "mVelocity", 0, 0)
        end
    end
    GamePrint(GameTextGetTranslatedOrNot("$log_teleported"))
    GamePlaySound("data/audio/Desktop/misc.bank", "game_effect/teleport/tick", x, y)
    EntityLoad("mods/safer_tele/files/particles_entity.xml", x, y - 5)
    if GlobalsGetValue("safer_tele.slow_fall_effect", "true") == "true" then
        local effect = EntityLoad("mods/safer_tele/files/slow_fall/effect.xml", x, y)
        local gec = EntityGetFirstComponentIncludingDisabled(effect, "GameEffectComponent")
        ComponentSetValue2(gec, "frames", tonumber(GlobalsGetValue("safer_tele.slow_fall_duration", "120")))
        EntityAddChild(entity, effect)
    end
end

function TeleportatiumTele(entity)
    local x, y = EntityGetTransform(entity)
    local success, new_x, new_y = teleport_aim(entity, x, y, tonumber(GlobalsGetValue("safer_tele.check_steps", "10")) or 10)
    if success then
        finish_teleport(entity, new_x, new_y)
    else
        local success, new_x, new_y = teleport_random(entity, x, y, 25)
        if success then
            finish_teleport(entity, new_x, new_y)
        end
    end
end

function UnstableTeleportatiumTele(entity)
    local x, y = EntityGetTransform(entity)
    local success, new_x, new_y = teleport_random(entity, x, y, 25)
    if success then
        finish_teleport(entity, new_x, new_y)
    end
end