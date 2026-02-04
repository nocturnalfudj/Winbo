/// @function hp_system_update
/// @summary Apply passive health regeneration and decay.
/// @description
///   Handles death state checks and adjusts current hp each step
///   based on regeneration or decay rates.
function hp_system_update(){
	//If Dead
	if(hp <= 0){
		//TODO - KILL LOGIC GOES HERE
	}
	//If Not Dead
	else{
		//Detla Time Factor
		var _delta_time;
		_delta_time = global.delta_time_factor_scaled;
		
		var _heal_amount,_heal_amount_total,_decay_amount,_decay_amount_total;
		_heal_amount_total = 0;
		_decay_amount_total = 0;

		#region Regen
			//Passive
			if(hp_regen_passive_enable){
				//Run Countdown
				if(hp_regen_passive_countdown > 0){
					hp_regen_passive_countdown -= _delta_time;
				}
				
				//Countdown Complete
				if(hp_regen_passive_countdown <= 0){
					//Apply Regen
					if(hp < hp_regen_passive_max){
						_heal_amount = hp_regen_passive_rate;
						_heal_amount_total += _heal_amount;
						
						hp_add(_heal_amount);
					}
					
					//Reset Countdown
					hp_regen_passive_countdown = hp_regen_passive_countdown_max;
				}
			}
			
			//Normal
			if(hp_regen_remaining > 0){
				//Run Countdown
				if(hp_regen_countdown > 0){
					hp_regen_countdown -= _delta_time;
				}
				
				//Countdown Complete
				if(hp_regen_countdown <= 0){
					//Apply Regen
					_heal_amount = hp_regen_rate * _delta_time;
					_heal_amount_total += _heal_amount;
	
					hp_add(_heal_amount);
					hp_regen_remaining -= _heal_amount;
					
					//Reset Countdown
					hp_regen_countdown = hp_regen_countdown_max;
				}
			}
			
			//Heal
			if(_heal_amount_total > 0){
				//Flash
				//flash_alpha = 0.4;
				//flash_colour = c_lime;
				//flash_alpha_lerp_val = FLASH_LERP_FACTOR * 0.3;
				
				//Text Poster
				hp_text_poster_heal(_heal_amount_total);
			}
		#endregion
		
		#region Decay
			//Decay Limit
			var _decay_limit;
			_decay_limit = 0;
			if(is_player){
				_decay_limit = 1;
			}
			
			if(hp > _decay_limit){
				//Passive
				if(hp_decay_passive_enable){
					//Run Countdown
					if(hp_decay_passive_countdown > 0){
						hp_decay_passive_countdown -= _delta_time;
					}
				
					//Countdown Complete
					if(hp_decay_passive_countdown <= 0){
						//Apply Decay
						if(hp > hp_decay_passive_min){
							_decay_amount = hp_decay_passive_rate;
							_decay_amount_total += _decay_amount;
					
							if(hp_vulnerable){
								var _damage_resistance;
								_damage_resistance = min(1,damage_resistance_multiplier);
								hp_subtract(_decay_amount * (1 - _damage_resistance),,_decay_limit);
							}
						}
					
						//Reset Countdown
						hp_decay_passive_countdown = hp_decay_passive_countdown_max;
					}
				}
			
				//Normal
				if(hp_decay_remaining > 0){
					//Run Countdown
					if(hp_decay_countdown > 0){
						hp_decay_countdown -= _delta_time;
					}
				
					//Countdown Complete
					if(hp_decay_countdown <= 0){
						//Apply Decay
						_decay_amount = hp_decay_rate * _delta_time;
						_decay_amount_total += _decay_amount;
			
						if(hp_vulnerable){
							var _damage_resistance;
							_damage_resistance = min(1,damage_resistance_multiplier);
							hp_subtract(_decay_amount * (1 - _damage_resistance),,_decay_limit);
						}
			
						hp_decay_remaining -= _decay_amount;
					
						//Reset Countdown
						hp_decay_countdown = hp_decay_countdown_max;
					}
				}
				
				//Decay Damage
				if(_decay_amount_total > 0){
					//Flash
					flash_alpha = 0.4;
					flash_colour = c_red;
					flash_alpha_lerp_val = FLASH_LERP_FACTOR * 0.3;
					
					//Text Poster
					hp_text_poster_damage(_decay_amount_total);
				}
			}
		#endregion
		
		#region Overhealth
			if(hp_overhealth > 0){
				//Run Countdown
				if(hp_overhealth_decay_countdown > 0){
					hp_overhealth_decay_countdown -= _delta_time;
				}
				
				//Countdown Complete
				if(hp_overhealth_decay_countdown <= 0){
					//Apply Decay
					_decay_amount = hp_overhealth_decay_rate * _delta_time;
					_decay_amount_total += _decay_amount;
					
					//Cap Decay to Amount of OverHealth Left
					_decay_amount = min(_decay_amount,hp_overhealth);
					
					hp -= _decay_amount;
			
					hp_overhealth -= _decay_amount;
					
					//Reset Countdown
					hp_overhealth_decay_countdown = hp_overhealth_decay_countdown_max;
				}
			}
		#endregion
	}
	
	//HP Change
	if(hp != hp_previous){
		//Keep HP at or below HP Max
		if(!hp_overhealth_enable)
			hp = min(hp_max,hp);
		
		//Percent
		hp_percent = hp/hp_max;
	
		//Update Health State
		hp_state_update();
	}
	
	#region HP Bar
		if(info_bar_enable){
			hp_bar_percent_previous = lerp_with_gap_close(hp_bar_percent_previous,hp_percent,0.1,0.01,false);
			
			hp_bar_health_boost_scale = lerp_with_gap_close(hp_bar_health_boost_scale,hp_bar_health_boost_scale_target,0.25,0.1,false);
		}
	#endregion
}