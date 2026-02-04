// Inherit the parent event
event_inherited();

sprite_current = sprite_index;

sprite_idle = sprite_index;
sprite_shatter = spr_hp_shatter;
sprite_regenerate = spr_hp_regenerate;

image_system_create();
image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,false,false,0,IMAGE_LOOP_FULL);

hp_id = 0;

show_target = true;
show = show_target;

slot_scale = 0;
slot_scale_target = 0;

slot_scale = lerp(slot_scale,slot_scale_target,0.2);

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_hud_create_main;
	state_script[UIState.idle][UIStateStage.main] = pstr_winbo_hp_idle_main;
#endregion