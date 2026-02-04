/// @function status_effect_active_fire
/// @summary Apply ongoing fire damage and spreading logic each step.
/// @returns {void} No return value.
function status_effect_active_fire(){
	//Don't Run if Already Dead
	if((state == death_state) || (hp == 0))
		exit;
	
	//Get Delta time
	var _delta_time_factor_scaled;
	_delta_time_factor_scaled = global.delta_time_factor_scaled;
	
	//Get Fire Count
	var _fire_count;
	_fire_count = status_effect_active_count[StatusEffect.fire];
	
	#region Damage
		//Countdown
		if(status_effect_fire_damage_countdown > 0){
			status_effect_fire_damage_countdown -= _delta_time_factor_scaled;
		}
		
		//Countdown Complete
		if(status_effect_fire_damage_countdown <= 0){
			//Reset Countdown
			status_effect_fire_damage_countdown = status_effect_fire_damage_countdown_max;
		
			//Increase HP Decay
			if(fire_damage_resistance < 1){
				hp_decay_remaining += 1 * _fire_count * (1 - fire_damage_resistance);
							
				//character_hit(noone,status_effect_fire_attacker_instance,status_effect_fire_attacker_team,1 * _fire_count * (1 - fire_damage_resistance),0,0,0,0,-1,false,noone,noone,false);
			}
		}
	#endregion
	
	#region Trail
		//Countdown
		if(status_effect_fire_trail_countdown > 0){
			status_effect_fire_trail_countdown -= _delta_time_factor_scaled;
		}
		
		//Countdown Complete
		if(status_effect_fire_trail_countdown <= 0){
			//Reset Countdown
			status_effect_fire_trail_countdown = status_effect_fire_trail_countdown_max;
			
			var _damage_multiplier;
			_damage_multiplier = damage_multiplier;
		
			//Fire Object to Spawn
			var _fire_object;
			if(_fire_count > 4){
				_fire_object = o_fire_huge;
			}
			else if(_fire_count > 3){
				_fire_object = o_fire_big;
			}
			else if(_fire_count > 2){
				_fire_object = o_fire_small;
			}
			else{
				_fire_object = noone;
			}
		
			//Spawn Trail
			if(_fire_object != noone){
				var _fire_trail;
				_fire_trail = instance_create_layer(x,y,"lyr_enemy",_fire_object);
				with(_fire_trail){
					owner = other.id;
			
					//Damage
					damage *= _damage_multiplier;
				}
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
}