function status_effect_active_damage_boost(){
	//Green Tint
	var _colour;
	_colour = merge_color(c_white,c_flat_green_shamrock,global.wave_sine_4_scaled);
	flash_damage_boost_alpha = global.wave_sine_4_scaled * 0.2;
	transform_set(transform[TransformType.anchor],TransformValue.colour,_colour,false);
}