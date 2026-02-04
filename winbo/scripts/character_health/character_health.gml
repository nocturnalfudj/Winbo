/// @function character_health
/// @summary Handle HP changes and death triggers.
function character_health(){
	//If Dead
	if(hp <= 0){
		character_kill();
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
					if(hp_regen_passive_countdown <= 0){
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
		
		#region Stats
			//TODO - Add Stats
		
			//var _team;
			//_team = team;
			//switch(team){
			//	case Team.enemy:
			//		if(_decay_amount_total != 0){
			//			var _group,_enemy;
			//			_group = enemy_group;
			//			_enemy = enemy_id;
						
			//			with(o_director){
			//				stat_add(stat[Stat.damage_dealt_any],_decay_amount_total);
			//				stat_add(stat[Stat.damage_dealt_group][_group],_decay_amount_total);
			//				stat_add(stat[Stat.damage_dealt_enemy][_enemy],_decay_amount_total);
			//			}
			//		}
			//	break;
			
			//	case Team.player:
			//	case Team.player_group_a:
			//	case Team.player_group_b:
			//	case Team.player_group_c:
			//	case Team.player_group_d:
			//		if((_decay_amount_total != 0) || (_heal_amount_total != 0)){
			//			if(is_player){
			//				with(o_director){
			//					stat_add(stat[Stat.heal],_heal_amount_total,_team);
			//					stat_add(stat[Stat.damage_received_any],_decay_amount_total,_team);
			//				}
			//			}
			//		}
			//	break;
			//}
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
	
		#region Player Health
			if(is_player){
				//Damage Taken
				if((user.hp > hp) && (hp < hp_max)){
					//Damage Fade
					with(o_fade_hud_damage){
						fade_factor = fade_factor_target_active;
					}
				}
			
				//Update User HP
				user.hp = hp;
			
				//Match User HP Vulnerable
				hp_vulnerable = user.hp_vulnerable;
			
				#region Camera Effects
					//var _hp_percent,_hp_percent_start_effect,_effect_percent;
					//_hp_percent = hp_percent;
					//_hp_percent_start_effect = 0.5;
				
					//var _hidden,_hidden_effect_colour_reduction,_hidden_effect_inner_circle_increase,_hidden_effect_outer_circle_increase;
					//_hidden = (status_effect_active_count[StatusEffect.hidden] > 0);
					//_hidden_effect_colour_reduction = 0;
					//_hidden_effect_inner_circle_increase = 0;
					//_hidden_effect_outer_circle_increase = 0;
				
					//with(o_camera){
					//	//If Debug Override Active
					//	//Ignore this Logic
					//	if(vfx_scheme_debug_override)
					//		break;
					
					//	var _colour;
					
					//	if(_hp_percent > _hp_percent_start_effect){
					//		//Hidden
					//		if(_hidden){
					//			_hidden_effect_colour_reduction = 100;
					//			_hidden_effect_inner_circle_increase = -0.2;
					//			_hidden_effect_outer_circle_increase = 2;
					//		}
						
					//		_colour = 255 - _hidden_effect_colour_reduction;
					//		vignette_noise_colour_set_target(_colour,_colour,_colour);
					//		vignette_noise_setting_set_target(2 + _hidden_effect_inner_circle_increase,1 + _hidden_effect_outer_circle_increase,0);
					//	}
					//	else{
					//		//Hidden
					//		if(_hidden){
					//			_hidden_effect_colour_reduction = 50;
					//			_hidden_effect_inner_circle_increase = -0.025;
					//			_hidden_effect_outer_circle_increase = 0.25;
					//		}
						
					//		_effect_percent = 1 - (_hp_percent / _hp_percent_start_effect);
					//		_effect_percent = max(0,_effect_percent);
					
					//		_colour = ease_circ_out(255,50,false,_effect_percent,1) - _hidden_effect_colour_reduction;
					//		vignette_noise_colour_set_target(255 - _hidden_effect_colour_reduction,_colour,_colour);
					
					//		var _target_inner_circle,_target_outer_circle,_target_noise;
					//		_target_inner_circle = (1.9 + _hidden_effect_inner_circle_increase) - 0.2*global.wave_sine_1_scaled;
					//		_target_outer_circle = (3 + _hidden_effect_outer_circle_increase) + 0.2*global.wave_sine_1_scaled;
					//		_target_noise = 0.05;
					//		vignette_noise_setting_set_target(ease_circ_out(2,_target_inner_circle,false,_effect_percent,1),ease_circ_out(1,_target_outer_circle,false,_effect_percent,1),ease_circ_out(0,_target_noise,false,_effect_percent,1));
					//	}
					//}
				#endregion
			}
		#endregion
	}
	
	#region HP Bar
		if(info_bar_enable){
			//Scale Lerp to Target
			info_bar_scale = lerp_with_gap_close(info_bar_scale,info_bar_scale_target,0.25,0.1,false);
			info_bar_hp_percent_previous = lerp_with_gap_close(info_bar_hp_percent_previous,hp_percent,0.1,0.01,false);
			
			info_bar_hp_health_boost_scale = lerp_with_gap_close(info_bar_hp_health_boost_scale,info_bar_hp_health_boost_scale_target,0.25,0.1,false);
		}
	#endregion
	
	//Update Previous
	hp_previous = hp;
}