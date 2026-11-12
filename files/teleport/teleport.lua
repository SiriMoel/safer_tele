teleport_random = dofile_once("mods/safer_tele/files/teleport/teleport_random.lua")
teleport_aim = dofile_once("mods/safer_tele/files/teleport/teleport_aim.lua")

function TeleportatiumTele(entity)
    local x, y = EntityGetTransform(entity)

    local success, new_x, new_y = teleport_aim(entity, x, y, 10)

    if success then
        EntitySetTransform(entity, new_x, new_y)
        GamePrint("Teleported! (safer? aim)")
    else
        local success, new_x, new_y = teleport_random(entity, x, y, 20)
        if success then
            EntitySetTransform(entity, new_x, new_y)
            GamePrint("Teleported! (safer? random)")
        end
    end
end

function UnstableTeleportatiumTele(entity)

end

function TeleportitisTele(entity)

end