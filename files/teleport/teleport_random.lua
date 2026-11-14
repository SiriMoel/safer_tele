function teleport_random(entity, x, y, tries)
    ray_test = dofile_once("mods/safer_tele/files/teleport/ray_test.lua")

    local current_biome = BiomeMapGetName(x, y)
    local check_biome = GlobalsGetValue("safer_tele.biome_check", "true") == "true"

    local check_range = tonumber(GlobalsGetValue("safer_tele.mat_check_range", "10")) or 10

    local valid_dests = {}

    local steps = tonumber(GlobalsGetValue("safer_tele.check_steps", "10")) or 10

    local inc = (2 * math.pi) / tries
    local step_dist = (1024 - 128) / steps

    for i = 1, tries do
        local a = inc * i

        local start_x = x + 128 * math.cos(a)
        local start_y = y - 5 + 128 * math.sin(a)

        for ii = 0, steps - 1 do
            local test_x = start_x + ii * step_dist * math.cos(a)
            local test_y = start_y + ii * step_dist * math.sin(a)
            local rays_ok, dest_x, dest_y = ray_test(test_x, test_y, 8, check_range)
            if rays_ok then
                if DoesWorldExistAt(dest_x - 5, dest_y - 5, dest_x + 5, dest_y + 5) then
                    if check_biome then
                        local dest_biome = BiomeMapGetName(dest_x, dest_y)
                        if current_biome == "$biome_holymountain" or current_biome == dest_biome then
                            table.insert(valid_dests, {x = dest_x, y = dest_y})
                        end
                    else
                        table.insert(valid_dests, {x = dest_x, y = dest_y})
                    end
                end
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

return teleport_random