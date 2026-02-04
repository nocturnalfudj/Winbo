function interact_system_create(){
	//Enable Toggle
	interact_enable = true;
	
	//Camera Visible Operate
	interact_operate_when_not_camera_visible = false;
	
	//Spaces
	interact_space[0] = noone;
	interact_space_count = 0;
	//interact_system_create_space();
	
	//Attack
	interact_attack_enable = false;
	interact_attack_team = noone;
	interact_attack_trigger = false;
	interact_attack_space = 0;				//The space to consider for the attack
	interact_attack_space_interaction = 0;	//The interaction within the space to consider for the attack
}

enum InteractSpaceState{
	idle,
	hover,
	down,
	active
}

enum InteractSpaceStateStage{
	start,
	main,
	stop,
		
	SIZE
}

enum InteractUserPosition{
	specifc,
	box,
	range
}

#macro INTERACT_DOWN_TIME_REDUCE_SPEED_INSTANT -1