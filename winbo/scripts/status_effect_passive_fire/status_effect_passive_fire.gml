function status_effect_passive_fire(){
	//Don't Run if Already Dead
	if((state == death_state) || (hp == 0))
		exit;
	
	//Get Delta time
	var _delta_time_factor_scaled;
	_delta_time_factor_scaled = global.delta_time_factor_scaled;
	
	//Get Fire Count
	var _fire_count;
	_fire_count = status_effect_active_count[StatusEffect.fire];
	
	#region PFX
		//Small
		if(chance(0.33 * (_fire_count / 5))){
			pfx_trigger(pfx_fire_small_foreground);
			pfx_trigger(pfx_fire_small_background);
		}
		
		//Big
		if(_fire_count > 3){
			if(chance(0.1 * (_fire_count / 5))){
				//pfx_trigger(pfx_fire_big_foreground);
				pfx_trigger(pfx_fire_big_background);
			}
		}
	#endregion
	
	#region Give Fire to Nearby Characters
		if(global.tick_now){
			var _x,_y,_distance,_width,_fire_spread_range
			_x = x;
			_y = y;
			_width = width;
			_fire_spread_range = 200 * fire_spread_range_factor;
			with(o_character){
				//Ignore Self
				if(id == other.id)
					continue;
				
				if(status_effect_active_count[StatusEffect.fire] <= 0){
					_distance = point_distance(x,y,_x,_y);
					if(_distance < (width/2) + _fire_spread_range){
						status_effect_fire_attacker_instance = other.status_effect_fire_attacker_instance;
						status_effect_fire_attacker_team = other.status_effect_fire_attacker_team;
						status_effect_start(StatusEffect.fire,SECOND * 0.5);
					}
				}
			}
		}
	#endregion
	
	#region Lighting
		with(tracking_light){
			var _circle_scale;
			_circle_scale = 2;
	
			var _t;
			_t = current_time;
	
			var _perlin_noise_scale,_perlin_noise,_perlin_noise_position;
			_perlin_noise_position = _t * 0.15;
			_perlin_noise = o_director.fire_noise.GetNoise(_perlin_noise_position,0);
			_perlin_noise_scale = 0.15 * _perlin_noise;
	
			_circle_scale += _perlin_noise_scale
	
			var _amplitude,_amplitude_min,_amplitude_max,_frequency,_wave_position,_wave_scale;
			_amplitude = 0.02;
			_frequency = 3.5;
			_wave_position = _t * 0.001;
			_wave_scale = _amplitude * sin(_frequency * _wave_position);
	
			_circle_scale += _wave_scale;
			
			offset_xscale	= _circle_scale;
			offset_yscale	= _circle_scale;
			
			image_blend		= c_flat_yellow_ripe_lemon;
			
			offset_alpha	= 1*_circle_scale;
			
			//Set Offset Targets to Current
			lighting_light_tracking_set_offset_targets_to_current();
		}
	#endregion
}