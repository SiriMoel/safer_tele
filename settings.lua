dofile("data/scripts/lib/mod_settings.lua")
dofile_once("data/scripts/lib/utilities.lua")

function mod_setting_bool_st(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "boolean" then value = setting.value_default or false end

	local text = "" 

    text = value and "ON!" or "Off"

    if value then
        GuiColorSetForNextWidget(gui, 0.5, 0.81, 0.92, 1.0)
    else
        GuiColorSetForNextWidget(gui, 0.6, 0.4, 0.4, 1.0)
    end

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)

    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    local clicked,right_clicked = GuiButton(gui, im_id, mod_setting_group_x_offset + 24, -11, setting.ui_name)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    if clicked then
		ModSettingSetNextValue(mod_setting_get_id(mod_id,setting), not value, false)
		mod_setting_handle_change_callback(mod_id, gui, in_main_menu, setting, value, not value)
	end
	if right_clicked then
		local new_value = setting.value_default or false
		ModSettingSetNextValue(mod_setting_get_id(mod_id,setting), new_value, false)
		mod_setting_handle_change_callback(mod_id, gui, in_main_menu, setting, value, new_value)
	end

	mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
end

function mod_setting_enum_st(mod_id, gui, in_main_menu, im_id, setting)
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	if type(value) ~= "string" then value = setting.value_default or "" end

	local value_id = 1
	for i,val in ipairs(setting.values) do
		if val[1] == value then
			value_id = i
			break
		end
	end

	local text = setting.values[value_id][2]

    local p = value_id / #setting.values

    GuiColorSetForNextWidget(gui, 0.5 - 0.4 * p, 0.41 + 0.4 * p, 0.52 + 0.4 * p, 1.0)

	GuiText(gui, mod_setting_group_x_offset, 0, text, 1, "", true)
	
    GuiColorSetForNextWidget(gui, 0.6, 0.6, 0.6, 1)

    local clicked,right_clicked = GuiButton(gui, im_id, mod_setting_group_x_offset + 24, -11, setting.ui_name)

    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)

    if clicked then
		local value_old = value
		value_id = value_id + 1
		if value_id > #(setting.values) then
			value_id = 1
		end
		value = setting.values[value_id][1]
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), value, false  )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value_old, value )
	end
	if right_clicked and setting.value_default then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), setting.value_default, false  )
		mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, setting.value_default )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_category_button_st(mod_id, gui, im_id, im_id2, category)
	local image_file = "mods/safer_tele/files/button_fold_close.png"
	if category._folded then
		image_file = "mods/safer_tele/files/button_fold_open.png"
	end

	GuiLayoutBeginHorizontal( gui, 0, 0 )
	GuiIdPush( gui, 892304589 )

	--GuiOptionsAddForNextWidget( gui, GUI_OPTION.DrawSemiTransparent )
    GuiColorSetForNextWidget(gui, 0.7, 0.7, 0.7, 0.8)
	local clicked1 = GuiButton( gui, im_id, mod_setting_group_x_offset, 0, category.ui_name )
    GuiColorSetForNextWidget(gui, 1, 1, 1, 1)
	if is_visible_string( category.ui_description ) then
		GuiTooltip( gui, category.ui_description, "" )
	end

	GuiOptionsAddForNextWidget( gui, GUI_OPTION.DrawActiveWidgetCursorOff )
	GuiOptionsAddForNextWidget( gui, GUI_OPTION.NoPositionTween )
	local clicked2 = GuiImageButton( gui, im_id2, 0, 0, "", image_file )
	if is_visible_string( category.ui_description ) then
		GuiTooltip( gui, category.ui_description, "" )
	end

	local clicked = clicked1 or clicked2
	if clicked then
		category._folded = not category._folded
	end

	GuiIdPop( gui )
	GuiLayoutEnd( gui )

	return clicked
end

function mod_setting_change_callback(mod_id, gui, in_main_menu, setting, old_value, new_value)

end

local mod_id = "safer_tele"
mod_settings_version = 1
mod_settings = {
    {
        category_id = "safety",
        ui_name = "Teleportation Safety",
        ui_description = "Settings for adjusting teleportation safety.",
        foldable = true,
        _folded = true,
        settings = {
            {
                id = "mat_check_range",
                ui_name = "Material check range",
                ui_description = "How far around a possible destination should solids & liquids be checked for?",
                value_default = "10",
                values = {{"6", "6"}, {"8", "8"}, {"10", "10"}, {"12", "12"}, {"16", "16"}, {"20", "20"}},
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_enum_st,
            },
            {
                id = "check_steps",
                ui_name = "Destination check steps",
                ui_description = "who knows",
                value_default = "10",
                values = {{"5", "5"}, {"10", "10"}, {"15", "15"}, {"20", "20"}},
                scope = MOD_SETTING_SCOPE_RUNTIME,
                ui_fn = mod_setting_enum_st,
            },
        },
    },
    {
        category_id = "tele_liquids",
        ui_name = "Teleporting liquids",
        ui_description = "Settings for Teleportatium & Unstable Teleportatium.",
        foldable = true,
        _folded = true,
        settings = {
            {
                id = "safer_teleportatium",
                ui_name = "Safer Teleportatium",
                ui_description = "Should Teleportatium be safer?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
                ui_fn = mod_setting_bool_st,
            },
            {
                id = "safer_unstable_teleportatium",
                ui_name = "Safer Unstable Teleportatium",
                ui_description = "Should Unstable Teleportatium be safer?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
                ui_fn = mod_setting_bool_st,
            },
        },
    },
    {
        category_id = "other_tele",
        ui_name = "Other teleporting",
        ui_description = "Settings for other causes of teleportation.",
        foldable = true,
        _folded = true,
        settings = {
            {
                id = "safer_mage_tele",
                ui_name = "Safer Master of Teleportation",
                ui_description = "Should the effect inflicted be safer?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
                ui_fn = mod_setting_bool_st,
            },
        },
    },
}

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

function st_mod_settings_gui( mod_id, settings, gui, in_main_menu )
	local im_id = 1

	for i,setting in ipairs(settings) do
		if setting.category_id ~= nil then
			-- setting category
			GuiIdPush( gui, im_id )
			if setting.foldable then
				local im_id2 = im_id
				im_id = im_id + 1
				local clicked_category_heading = mod_setting_category_button_st( mod_id, gui, im_id, im_id2, setting )
				if not setting._folded then
					GuiAnimateBegin( gui )
					GuiAnimateAlphaFadeIn( gui, 3458923234, 0.1, 0.0, clicked_category_heading )
					mod_setting_group_x_offset = mod_setting_group_x_offset + 6
					st_mod_settings_gui( mod_id, setting.settings, gui, in_main_menu )
					mod_setting_group_x_offset = mod_setting_group_x_offset - 6
					GuiAnimateEnd( gui )
					GuiLayoutAddVerticalSpacing( gui, 4 )
				end
			else
				GuiOptionsAddForNextWidget( gui, GUI_OPTION.DrawSemiTransparent )
				GuiText( gui, mod_setting_group_x_offset, 0, setting.ui_name )
				if is_visible_string( setting.ui_description ) then
					GuiTooltip( gui, setting.ui_description, "" )
				end
				mod_setting_group_x_offset = mod_setting_group_x_offset + 2
				st_mod_settings_gui( mod_id, setting.settings, gui, in_main_menu )
				mod_setting_group_x_offset = mod_setting_group_x_offset - 2
				GuiLayoutAddVerticalSpacing( gui, 4 )
			end
			GuiIdPop( gui )
		else
			-- setting
			local auto_gui = setting.ui_fn == nil
			local visible = (setting.hidden == nil or not setting.hidden)
			if auto_gui and visible then
				local value_type = type(setting.value_default)
				if setting.not_setting then
					mod_setting_title( mod_id, gui, in_main_menu, im_id, setting )
				elseif value_type == "boolean" then
					mod_setting_bool( mod_id, gui, in_main_menu, im_id, setting )
				elseif value_type == "number" then
					mod_setting_number( mod_id, gui, in_main_menu, im_id, setting )
				elseif value_type == "string" and setting.values ~= nil then
					mod_setting_enum( mod_id, gui, in_main_menu, im_id, setting )
				elseif value_type == "string" then
					mod_setting_text( mod_id, gui, in_main_menu, im_id, setting )
				end
			elseif visible then
				setting.ui_fn( mod_id, gui, in_main_menu, im_id, setting )
			end
		end

		im_id = im_id+1
	end
end

function ModSettingsGui(gui, in_main_menu)
	st_mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end