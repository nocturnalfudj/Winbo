/// @function status_effect_start_damage_boost
/// @summary Increase the character damage multiplier when this effect begins.
function status_effect_start_damage_boost(){
	//Increase the Character Damage Multiplier
	if(status_effect_active_count_increased)
		damage_multiplier += STATUS_EFFECT_DAMAGE_BOOST_MULTIPLIER_INCREASE;
}