/// @function status_effect_system_update
/// @summary Update active status effects each step.
function status_effect_system_update(){
	var _delta_time_scaled;
	_delta_time_scaled = global.delta_time_factor_scaled;
	
	var _status_effect_data_array,_status_effect_data;
	_status_effect_data_array = o_director.status_effect;
	
	//Go Through Each Effect
	for(var _i=0;_i<StatusEffect.SIZE;_i++){
		//Effect is Active
		if(status_effect_active_count[_i] > 0){
			//Get Data
			_status_effect_data = _status_effect_data_array[_i];
			
			//Run Effect Passive Script
			var _passive_script;
			_passive_script = _status_effect_data.passive_script;
			if(_passive_script != noone)
				script_execute(_passive_script);
			
			var _countdown;
			var _active_script;
			
			//Duration Switch
			switch(_status_effect_data.duration_type){
				case StatusEffectDurationType.permanent:
					#region Permanent
						//Trigger Switch
						switch(_status_effect_data.trigger_type){
							case StatusEffectTriggerType.passive:
								//Run Effect Active Script
								_active_script = _status_effect_data.active_script;
								if(_active_script != noone)
									script_execute(_active_script);
							break;
						
							case StatusEffectTriggerType.custom:
								if(status_effect_trigger_custom[_i]){
									//Deactivate Custome Trigger
									status_effect_trigger_custom[_i] = false;
								
									//Run Effect Active Script
									_active_script = _status_effect_data.active_script;
									if(_active_script != noone)
										script_execute(_active_script);
								}
							break;
						
							case StatusEffectTriggerType.countdown:
								_countdown = status_effect_trigger_countdown[_i];
							
								//Update Countdown
								_countdown.Update();
							
								//Countdown Trigger
								if(_countdown.trigger_active){
									//Run Effect Active Script
									_active_script = _status_effect_data.active_script;
									if(_active_script != noone)
										script_execute(_active_script);
								}
							break;
						}
					#endregion
				break;
				
				case StatusEffectDurationType.countdown:
					#region Countdown
						//Countdown Effect Duration
						if(status_effect_duration[_i] > 0){
							status_effect_duration[_i] -= _delta_time_scaled;
					
							//Trigger Switch
							switch(_status_effect_data.trigger_type){
								case StatusEffectTriggerType.passive:
									//Run Effect Active Script
									_active_script = _status_effect_data.active_script;
									if(_active_script != noone)
										script_execute(_active_script);
								break;
						
								case StatusEffectTriggerType.custom:
									if(status_effect_trigger_custom[_i]){
										//Deactivate Custome Trigger
										status_effect_trigger_custom[_i] = false;
								
										//Run Effect Active Script
										_active_script = _status_effect_data.active_script;
										if(_active_script != noone)
											script_execute(_active_script);
									}
								break;
						
								case StatusEffectTriggerType.countdown:
									_countdown = status_effect_trigger_countdown[_i];
							
									//Update Countdown
									_countdown.Update();
							
									//Countdown Trigger
									if(_countdown.trigger_active){
										//Run Effect Active Script
										_active_script = _status_effect_data.active_script;
										if(_active_script != noone)
											script_execute(_active_script);
									}
								break;
							}
						}
						else{
							//Reduce Active Count
							status_effect_reduce(_i);
						}
					#endregion
				break;
				
				case StatusEffectDurationType.number:
					#region Countdown
						//Countdown Effect Duration
						if(status_effect_duration[_i] > 0){
							//Trigger Switch
							switch(_status_effect_data.trigger_type){
								case StatusEffectTriggerType.passive:
									//Run Effect Active Script
									_active_script = _status_effect_data.active_script;
									if(_active_script != noone)
										script_execute(_active_script);
									
									//Reduce Effect Duration
									status_effect_duration[_i] -= 1;
								break;
						
								case StatusEffectTriggerType.custom:
									if(status_effect_trigger_custom[_i]){
										//Deactivate Custome Trigger
										status_effect_trigger_custom[_i] = false;
								
										//Run Effect Active Script
										_active_script = _status_effect_data.active_script;
										if(_active_script != noone)
											script_execute(_active_script);
											
										//Reduce Effect Duration
										status_effect_duration[_i] -= 1;
									}
								break;
						
								case StatusEffectTriggerType.countdown:
									_countdown = status_effect_trigger_countdown[_i];
							
									//Update Countdown
									_countdown.Update();
							
									//Countdown Trigger
									if(_countdown.trigger_active){
										//Run Effect Active Script
										_active_script = _status_effect_data.active_script;
										if(_active_script != noone)
											script_execute(_active_script);
											
										//Reduce Effect Duration
										status_effect_duration[_i] -= 1;
									}
								break;
							}
						}
						else{
							//Reduce Active Count
							status_effect_reduce(_i);
						}
					#endregion
				break;
			}
		}
	}
}