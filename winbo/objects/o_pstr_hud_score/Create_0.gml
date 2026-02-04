// Inherit the parent event
event_inherited();

sprite_current = sprite_index;

//Don't Inherit Anchor Angle
transform_parent_inherit[TransformValue.angle]	= false;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_hud_create_main;
#endregion