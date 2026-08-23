/// @function fx_spawn_sprite_once(_x,_y,_layer,_sprite[_xscale,_yscale,_angle,_fps,_alpha])
/// @description Spawn a one-shot sprite FX instance on a given room layer.
function fx_spawn_sprite_once(_x, _y, _layer, _sprite, _xscale = 1, _yscale = 1, _angle = 0, _fps = ANIMATION_FPS_DEFAULT, _alpha = 1) {
	var _inst = instance_create_layer(_x, _y, _layer, o_fx_sprite_once);
	_inst.fx_sprite = _sprite;
	_inst.fx_fps = _fps;
	_inst.image_xscale = _xscale;
	_inst.image_yscale = _yscale;
	_inst.image_angle = _angle;
	_inst.image_alpha = _alpha;
	
	// Important: objects created during Step can Draw before their own Step runs.
	// Initialise the image system immediately so o_actor.Draw never sees an invalid sprite_current.
	with (_inst) {
		image_system_setup(fx_sprite, fx_fps, true, false, 0, IMAGE_LOOP_FULL);
		image_set_frame(image, 0);
		
		// Parent computed 0-sized buffers at Create-time (no sprite then).
		camera_visible_buff_width  = sprite_get_width(fx_sprite)  * abs(image_xscale) * camera_visible_buff_factor;
		camera_visible_buff_height = sprite_get_height(fx_sprite) * abs(image_yscale) * camera_visible_buff_factor;
		
		_fx_started = true;
	}
	return _inst;
}
