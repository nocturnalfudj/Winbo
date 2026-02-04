/// @function status_effect_end_resistance_boost
/// @summary Remove the temporary resistance boost from the character.
/// @returns {void}
function status_effect_end_resistance_boost(){
	//Decrease the Character Damage Resistance Multiplier
	damage_resistance_multiplier -= STATUS_EFFECT_DAMAGE_RESISTANCE_BOOST_MULTIPLIER_INCREASE;
}