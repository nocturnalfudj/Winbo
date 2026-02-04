/// @function status_effect_start_resistance_boost
/// @summary Begin resistance boost status effect logic.
/// @returns {void} No return value.
function status_effect_start_resistance_boost(){
	//Increase the Character Damage Resistance Multiplier
	if(status_effect_active_count_increased)
		damage_resistance_multiplier += STATUS_EFFECT_DAMAGE_RESISTANCE_BOOST_MULTIPLIER_INCREASE;
}