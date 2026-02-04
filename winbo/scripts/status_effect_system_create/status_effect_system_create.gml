/// @function status_effect_system_create
/// @summary Initialise arrays used for status effects.
/// @returns {void}
function status_effect_system_create(){
	var _status_effect_data_array,_status_effect_data;
	_status_effect_data_array = o_director.status_effect;
	
	//Set Up Each Effect
	for(var _i=0;_i<StatusEffect.SIZE;_i++){
		status_effect_active_count[_i] = 0;
		status_effect_duration[_i] = false;
		status_effect_trigger_custom[_i] = false;
		status_effect_trigger_countdown[_i] = false;
	}
	
	//This is used whenever an Effect is started,
	//by default it is true,
	//but set to false if the effect start doesn't result in increased active count
	//(for example when the effect has already reached max count, and all the start does is increase the timer)
	status_effect_active_count_increased = false;
}