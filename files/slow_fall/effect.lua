local effect = GetUpdatedEntityID()
local root = EntityGetRootEntity(effect)
local comp_vel = EntityGetFirstComponent(root, "CharacterDataComponent")
if comp_vel ~= nil then
    local vel_x, vel_y = ComponentGetValue2(comp_vel, "mVelocity")
    local vel_cap = 45
    if GlobalsGetValue("safer_tele.slower_fall", "false") == "true" then
        vel_cap = 8
    end
    vel_y = math.min(vel_y, vel_cap)
    ComponentSetValue2(comp_vel, "mVelocity", vel_x, vel_y)
end