dofile_once("mods/safer_tele/files/teleport/teleport.lua")

local effect = GetUpdatedEntityID()
local root = EntityGetRootEntity(effect)

local comp_frame = EntityGetFirstComponentIncludingDisabled(effect, "VariableStorageComponent", "safer_tele_frame")
local comp_min_frame = EntityGetFirstComponentIncludingDisabled(effect, "VariableStorageComponent", "safer_tele_min_frame")

local frame = ComponentGetValue2(comp_frame, "value_int")
local min_frame = ComponentGetValue2(comp_min_frame, "value_int")
local frame_now = GameGetFrameNum()

if frame_now > frame + min_frame then
    UnstableTeleportatiumTele(root)
    ComponentSetValue2(comp_frame, "value_int", frame_now)
end