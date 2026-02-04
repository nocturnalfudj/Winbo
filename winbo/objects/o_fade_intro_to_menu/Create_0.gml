// Inherit the parent event
event_inherited();

//UI Group
ui_group_set(UIGroup.menu,id);

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = fade_intro_to_menu_create_main;
#endregion