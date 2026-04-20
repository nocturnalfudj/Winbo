if(!_fx_started){
	_fx_started = true;

	if(fx_sprite == noone){
		instance_destroy();
		exit;
	}

	image_system_setup(fx_sprite, fx_fps, true, !fx_destroy_on_end, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);

	camera_visible_buff_width = sprite_get_width(fx_sprite) * abs(image_xscale) * camera_visible_buff_factor;
	camera_visible_buff_height = sprite_get_height(fx_sprite) * abs(image_yscale) * camera_visible_buff_factor;

	exit;
}

if(fx_follow_owner){
	x = fx_owner.x + fx_offset_x;
	y = fx_owner.y + fx_offset_y;
}

if(fx_fade_speed > 0){
	var _fade_step;
	_fade_step = fx_fade_speed * global.delta_time_factor_scaled;

	if(image_alpha < fx_fade_target){
		image_alpha = min(fx_fade_target, image_alpha + _fade_step);
	}
	else if(image_alpha > fx_fade_target){
		image_alpha = max(fx_fade_target, image_alpha - _fade_step);
	}
}

switch(global.game_state){
	case GameState.play:
		if(fx_destroy_on_end && (image == noone || !image.animate)){
			instance_destroy();
			exit;
		}

		image_system_update();
	break;

	default:
		// no-op
	break;
}
