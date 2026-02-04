// Inherit the parent event
event_inherited();

//Bar Colour
colour = c_ags_red;
distance = 125;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = bar_menu_create_main;
#endregion