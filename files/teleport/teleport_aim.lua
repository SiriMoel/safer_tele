function teleport_aim(entity, x, y, steps)
    local comp_controls = EntityGetFirstComponentIncludingDisabled(entity, "ControlsComponent")
    if comp_controls == nil then return false, x, y end
    local mouse_x, mouse_y = ComponentGetValueVector2(comp_controls, "mMousePosition")

    function ray_test(ray_test_x, ray_test_y, ray_count, ray_dist, try)
        try = try or 1
        local rays_ok = true
        for ray_i = 1, ray_count do
            local ray_a = ray_i * (2 * math.pi) / ray_count
            local ray_x = ray_test_x + ray_dist * math.cos(ray_a)
            local ray_y = ray_test_y + ray_dist * math.sin(ray_a)
            if RaytraceSurfacesAndLiquiform(ray_test_x, ray_test_y, ray_x, ray_y) then
                rays_ok = false
            elseif rays_ok == false and try < 4 then
                local rays_ok_2, ray_dest_x, ray_dest_y = ray_test(ray_x, ray_y, 8, 5, try + 1)
                if rays_ok_2 then
                    return rays_ok_2, ray_dest_x, ray_dest_y
                end
            end
        end
        return rays_ok, ray_test_x, ray_test_y
    end

    local a = math.atan2(mouse_y - y, mouse_x - x)

    local start_x = x + 128 * math.cos(a)
    local start_y = y - 5 + 128 * math.sin(a)

    local step_dist = (1024 - 128) / steps

    local valid_dests = {}

    for i = 0, steps - 1 do
        local test_x = start_x + i * step_dist * math.cos(a)
        local test_y = start_y + i * step_dist * math.sin(a)
        local rays_ok, dest_x, dest_y = ray_test(test_x, test_y, 8, 7)
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