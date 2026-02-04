function flash_system_create(){
	flash_alpha = 0;
	flash_colour = c_white;
	flash_alpha_lerp_val = FLASH_LERP_FACTOR;
	
	flash_frozen_alpha = 0;
	flash_frozen_colour = c_flat_blue_jordy_blue;
	
	flash_chase_start_alpha = 0;
	flash_chase_start_colour = c_red;
	
	flash_damage_boost_alpha = 0;
	flash_damage_boost_colour = c_flat_green_shamrock;
	
	flash_weapon_alpha = 0;
	flash_weapon_colour = c_white;
}

#macro FLASH_LERP_FACTOR 0.15