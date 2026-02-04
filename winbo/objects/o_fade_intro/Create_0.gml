// Inherit the parent event
event_inherited();

#region State Scripts
	state_script[UIState.idle][UIStateStage.main] = fade_intro_idle_main;
#endregion