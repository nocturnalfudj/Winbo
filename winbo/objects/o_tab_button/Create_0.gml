//Inherit UI Object Parent
event_inherited();

#region Toggle
	toggle_enable			= true;
	toggle					= false;
	toggle_group_enable		= true;
	toggle_group			= noone;		//NEED TO SET
	toggle_group_mono		= true;								//Only one in group allowed to be toggled on
	toggle_oneway_enable	= true;
	toggle_oneway_direction = true;								//Can only be toggle to this value if oneway enabled
#endregion

//Tab
tab = noone;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = tabBtn_create_main;
	
	state_script[UIState.active][UIStateStage.main] = tabBtn_active_main;
#endregion