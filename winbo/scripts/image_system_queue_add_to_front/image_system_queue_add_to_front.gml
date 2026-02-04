/// @function image_system_queue_add_to_front
/// @summary Add an animation to the front of the image queue and play it immediately.
/// @param _sprite Sprite asset to animate.
/// @param {real} _frames_per_second Playback speed in frames per second.
/// @description
///   Interrupts the current animation and plays the new sprite immediately.
///   If currently playing a queued animation, saves it back to the front of the queue.
///   If currently playing the target animation, the target remains unchanged.
function image_system_queue_add_to_front(_sprite, _frames_per_second) {
	if (image.is_playing_queued) {
		// Currently playing a queued animation - need to save it back to queue
		var current_item = new ImageQueueAnimation(image.sprite_current, image.frames_per_second * SECOND);
		array_insert(image.queue, 0, current_item);
	}
	// If playing target animation, no need to save it - target stays as target
	
	// Switch immediately to the new front item
	image_set_all(image, _sprite, _frames_per_second, true, false, 0, IMAGE_LOOP_FULL);
	// Ensure the draw system doesn't use a stale sprite_current_frame for one step
	image_set_frame(image, 0);
	image.is_playing_queued = true;
}