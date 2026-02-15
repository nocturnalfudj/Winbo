// Start the animation on the first step and exit so frame 0 draws once.
if (!_fx_started) {
	_fx_started = true;

	if (fx_sprite == noone) {
		instance_destroy();
		exit;
	}

	image_system_setup(fx_sprite, fx_fps, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);

	// Parent computed 0-sized buffers at Create-time (no sprite then).
	// Recompute now so camera culling behaves like other actor-based objects.
	camera_visible_buff_width  = sprite_get_width(fx_sprite)  * abs(image_xscale) * camera_visible_buff_factor;
	camera_visible_buff_height = sprite_get_height(fx_sprite) * abs(image_yscale) * camera_visible_buff_factor;

	exit;
}

// Only advance animation during gameplay; freeze/pause keeps the current frame visible.
switch (global.game_state) {
	case GameState.play:
		// Destroy one step AFTER the animation completes so the last frame is rendered once.
		if (image == noone || !image.animate) {
			instance_destroy();
			exit;
		}

		image_system_update();
	break;

	default:
		// no-op
	break;
}
