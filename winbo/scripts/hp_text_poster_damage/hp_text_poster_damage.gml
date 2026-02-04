function hp_text_poster_damage(_damage){
	//Ignore if Not Enabled
	if(!hp_text_poster_enable_damage)
		exit;
	
	var _x,_y;
	_x = x;
	_y = y;
	_x += irandom_range(-50,50);
	_y += irandom_range(-50,50);
					
	var _status_effect_fire_active;
	_status_effect_fire_active = false;
	
	//Uncomment this if fire status effect is being used
	//_status_effect_fire_active = (status_effect_active_count[StatusEffect.fire] > 0);
					
	var _damage_text_poster;
	_damage_text_poster = instance_create_layer(_x,_y,"lyr_pfx_midground",o_txtPstr_damage);
	with(_damage_text_poster){
		text_string = string(_damage);
		
		if(_damage < 1){
			font = fnt_default_16;
		}
		else if(_damage < 5){
			font = fnt_default_30;
		}
		else if(_damage < 25){
			font = fnt_default_42;
		}
		else if(_damage < 50){
			font = fnt_default_52;
		}
		else{
			font = fnt_default_64;
		}
						
		//Turn Light Off if character is on fire
		//So the lighting effects of the fire are not interfered with
		if(_status_effect_fire_active){
			with(tracking_light){
				offset_alpha = 0;
			}
		}
	}
}