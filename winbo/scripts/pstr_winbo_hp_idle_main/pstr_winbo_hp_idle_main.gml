function pstr_winbo_hp_idle_main(){
	//Get Player HP
	var _hp;
	_hp = PLAYER_HP_MAX_DEFAULT;
	with(o_input){
		with(user[0]){
			_hp = hp;
		}
	}
	
	//Determine Show Target
	if((_hp - 1) >= hp_id){
		show_target = true;
	}
	else{
		show_target = false;
	}
	
	//Handle Show Update
	if(show != show_target){
		if(show_target){
			image_system_setup(sprite_regenerate,ANIMATION_FPS_DEFAULT,true,false,0,IMAGE_LOOP_FULL);
		}
		else{
			image_system_setup(sprite_shatter,ANIMATION_FPS_DEFAULT,true,false,0,IMAGE_LOOP_FULL);
		}
		
		show = show_target;
	}
	else{
		//Animation Stopped
		if((show_target) && (image.frame + 1 >= image.sprite_number)){
			image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,false,false,0,IMAGE_LOOP_FULL);
		}
	}
	
	//Slot Scale Target
	slot_scale_target = !show;
	
	//Image Update
	image_system_update();
}