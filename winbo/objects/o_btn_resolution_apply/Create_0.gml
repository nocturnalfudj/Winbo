// Inherit the parent event
event_inherited();

//Enable Transform Relative
transform_system_relative_enable();

transform_set(transform[TransformType.relative],TransformValue.xscale,0,false);
transform_set(transform[TransformType.relative],TransformValue.yscale,0,false);

//Image
sprite_current = spr_btn_tick;

//Resolution Apply
apply_ready = false;

#region Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_display_create_main_scroll;
	state_script[UIState.active][UIStateStage.main] = btn_resolution_apply_active_main;
#endregion