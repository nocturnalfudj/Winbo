/// @function image_system_queue_add_to_back
/// @summary Add an animation to the back of the image queue.
/// @param _sprite Sprite asset to animate.
/// @param {real} _frames_per_second Playback speed in frames per second.
/// @description
///   Adds an animation to the end of the queue.
///   If not currently playing queued animations, starts the queue immediately.
function image_system_queue_add_to_back(_sprite, _frames_per_second) {
	array_push(image.queue, new ImageQueueAnimation(_sprite, _frames_per_second));
	
	// If not currently playing anything queued, start the queue
	if (!image.is_playing_queued && array_length(image.queue) > 0) {
		var first_item = image.queue[0];
		array_delete(image.queue, 0, 1);
		
		image_set_all(image, first_item.sprite, first_item.frames_per_second, true, false, 0, IMAGE_LOOP_FULL);
		// Ensure the draw system doesn't use a stale sprite_current_frame for one step
		image_set_frame(image, 0);
		image.is_playing_queued = true;
	}
}