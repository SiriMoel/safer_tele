function teleport_aim(entity, x, y, steps)
    ray_test = dofile_once("mods/safer_tele/files/teleport/ray_test.lua")

    local check_range = tonumber(GlobalsGetValue("safer_tele.mat_check_range", "10")) or 10

    local comp_controls = EntityGetFirstComponentIncludingDisabled(entity, "ControlsComponent")
    if comp_controls == nil then return false, x, y end
    local mouse_x, mouse_y = ComponentGetValue2(comp_controls, "mMousePosition")

    local a = math.atan2(mouse_y - y, mouse_x - x)

    local start_x = x + 128 * math.cos(a)
    local start_y = y - 5 + 128 * math.sin(a)

    local step_dist = (1024 - 128) / steps

    local valid_dests = {}

    for i = 0, steps - 1 do
        local test_x = start_x + i * step_dist * math.cos(a)
        local test_y = start_y + i * step_dist * math.sin(a)
        local rays_ok, dest_x, dest_y = ray_test(test_x, test_y, 8, check_range)
        if rays_ok then
            if DoesWorldExistAt(dest_x - 5, dest_y - 5, dest_x + 5, dest_y + 5) then
                table.insert(valid_dests, {x = dest_x, y = dest_y})
            end
        end
    end

    if #valid_dests > 0 then
        SetRandomSeed(entity + x, y)
        local dest = valid_dests[Random(1, #valid_dests)]
        return true, dest.x, dest.y
    end

    return false, x, y
end

return teleport_aim