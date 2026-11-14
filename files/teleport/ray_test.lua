function ray_test(ray_test_x, ray_test_y, ray_count, ray_dist, try)
    local check_range = (tonumber(GlobalsGetValue("safer_tele.mat_check_range", "10")) or 10) + 2
    try = try or 1
    local rays_ok = true
    for ray_i = 1, ray_count do
        local ray_a = ray_i * (2 * math.pi) / ray_count
        local ray_x = ray_test_x + ray_dist * math.cos(ray_a)
        local ray_y = ray_test_y + ray_dist * math.sin(ray_a)
        if RaytraceSurfacesAndLiquiform(ray_test_x, ray_test_y, ray_x, ray_y) then
            rays_ok = false
        elseif rays_ok == false and try < 4 then
            local rays_ok_2, ray_dest_x, ray_dest_y = ray_test(ray_x, ray_y, 8, check_range, try + 1)
            if rays_ok_2 then
                return rays_ok_2, ray_dest_x, ray_dest_y
            end
        end
    end
    return rays_ok, ray_test_x, ray_test_y
end

return ray_test