// Inherit the parent event
event_inherited();

//Transform Update
transform_system_update();

//Tab
tab = noone;

#region Scroll
	//scroll = new Scroll(0,0);
	//scroll.transform_parent = transform_child[0];
#endregion

#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = tab_destroy_main;
#endregion