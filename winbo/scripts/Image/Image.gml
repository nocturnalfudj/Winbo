/// @function Image
/// @summary Container for sprite animation state.
/// @param _sprite_current Initial sprite asset or noone.
/// @param {real} _frames_per_second Playback speed in frames per second.
/// @param {bool} _animate Should the image advance frames.
/// @param {bool} _loop Enable looping animation.
/// @param {real} _loop_start First frame to loop from.
/// @param {real} _loop_end Last frame before restarting.
/// @returns {struct} Image animation state struct.
/// @description
///   Manages sprite playback. Callers should update position based on
///   `frames_per_second` each step.
function Image(_sprite_current,_frames_per_second,_animate,_loop,_loop_start,_loop_end) constructor{
	sprite_current = _sprite_current
	sprite_previous = noone;
	if(sprite_current == noone)
		sprite_number = 0;
	else
		sprite_number = sprite_get_number(sprite_current);
	position = 0;
	frame = 0;
	frames_per_second = _frames_per_second/SECOND;
	animate = _animate;
	loop = _loop;
	loop_start = _loop_start;
	loop_end = _loop_end;	//Set this to IMAGE_LOOP_FULL to loop at the last frame
	
	//Whether or not the transform uses timescale for animation
	//default to false
	//true is for anything that should obey slow/fast motion
	image_animation_time_scale_enable = false;
	
	// Queue system variables
	queue = [];  // Array of ImageQueueAnimation items
	target_sprite = _sprite_current;
	target_frames_per_second = _frames_per_second;
	target_animate = _animate;
	target_loop = _loop;
	target_loop_start = _loop_start;
	target_loop_end = _loop_end;
	is_playing_queued = false;
}

#macro IMAGE_LOOP_FULL -1