function flash_system_update(){
	if(flash_alpha > 0){
		flash_alpha = lerp(flash_alpha,0,flash_alpha_lerp_val);
	}
	
	//if(flash_frozen_alpha > 0){
	//	flash_frozen_alpha = lerp(flash_frozen_alpha,0,0.01);
	//}
	
	if(flash_chase_start_alpha > 0){
		flash_chase_start_alpha = lerp(flash_chase_start_alpha,0,FLASH_LERP_FACTOR);
	}
	
	if(flash_damage_boost_alpha > 0){
		flash_damage_boost_alpha = lerp(flash_damage_boost_alpha,0,0.1);
	}
	
	if(flash_weapon_alpha > 0){
		flash_weapon_alpha = lerp(flash_weapon_alpha,0,0.1);
	}
}