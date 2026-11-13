teleport_random = dofile_once("mods/safer_tele/files/teleport/teleport_random.lua")
teleport_aim = dofile_once("mods/safer_tele/files/teleport/teleport_aim.lua")

function finish_teleport(entity, x, y)
    EntitySetTransform(entity, x, y)
    local comp_vel = EntityGetFirstComponent(entity, "VelocityComponent")
    if comp_vel ~= nil then
        ComponentSetValue2(comp_vel, "mVelocity", 0, 0)
    end
    GamePrint(GameTextGetTranslatedOrNot("$log_teleported") .. " (safer)")
    GamePlaySound("data/audio/Desktop/misc.bank", "game_effect/teleport/tick", x, y)
end

function TeleportatiumTele(entity)
    local x, y = EntityGetTransform(entity)
    local success, new_x, new_y = teleport_aim(entity, x, y, 10)
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

function TeleportitisTele(entity)
    -- idk
end