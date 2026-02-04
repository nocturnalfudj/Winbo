function interact_system_update(){
	//Don't Handle Interact System if Not on Camera
	//Unless Set to Ignore This
	if((!interact_operate_when_not_camera_visible) && (!camera_visible_position))
		exit;
	
	var _interact_enable,_interact_attack_enable;
	_interact_enable = interact_enable;
	
	//Reference to Instance
	var _interact_instance;
	_interact_instance = id;
	
	//Go Through All Spaces
	var _space;
	for(var _i=0;_i<interact_space_count;_i++){
		_space = interact_space[_i];
		
		if((interact_attack_enable) && (_i == interact_attack_space))
			_interact_attack_enable = true;
		else
			_interact_attack_enable = false;
			
		with(_space){
			//State Switch
			switch(state){
				case InteractSpaceState.idle:
					interact_space_state_idle(_interact_instance,_space,_interact_enable,_interact_attack_enable);
				break;
		
				case InteractSpaceState.hover:
					interact_space_state_hover(_interact_instance,_space,_interact_enable,_interact_attack_enable);
				break;
		
				case InteractSpaceState.down:
					interact_space_state_down(_interact_instance,_space,_interact_enable,_interact_attack_enable);
				break;
		
				case InteractSpaceState.active:
					interact_space_state_active(_interact_instance,_space,_interact_enable,_interact_attack_enable);
				break;
			}
		}
	}
}