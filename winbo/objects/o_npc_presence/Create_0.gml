// Inherit the parent event
event_inherited();

#region Movement
	movement_velocity_retention_and_acceleration_max_set(0.7,1000);
	movement_input_move_acceleration_default_set(0);
#endregion

#region Interact System Setup
	//Interaction Scripts
	interact_active_script[NPCInteraction.dialogue] = npc_presence_interact_state_active_main;
#endregion

#region Lighting
	tracking_light = lighting_light_create_track(spr_light_circular,c_white,"lyr_lighting",3,3,0,0,0,1);
#endregion