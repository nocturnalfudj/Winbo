// Inherit the parent event
event_inherited();

sprite_current = sprite_index;

//Don't Inherit Anchor Y Scale
transform_parent_inherit[TransformValue.yscale]	= false;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_hud_create_main;
#endregion