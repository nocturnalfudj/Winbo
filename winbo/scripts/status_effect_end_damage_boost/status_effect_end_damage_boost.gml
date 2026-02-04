function status_effect_end_damage_boost(){
	//Decrease the Character Damage Multiplier
	damage_multiplier -= STATUS_EFFECT_DAMAGE_BOOST_MULTIPLIER_INCREASE;
	
	#region Recoil Colour
		var _transform,_target,_time_max,_ease;
		_transform = transform[TransformType.anchor];
		_target = 1;
		_time_max = 0.6 * SECOND;
		_ease = ease_quad_in_out;
		transform_recoil(_transform,TransformValue.colour,0,_time_max,_ease);
	#endregion
}