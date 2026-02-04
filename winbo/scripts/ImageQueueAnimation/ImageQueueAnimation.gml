/// @function ImageQueueAnimation
/// @summary Container for queued sprite animation data.
/// @param _sprite Sprite asset to animate.
/// @param {real} _frames_per_second Playback speed in frames per second.
/// @returns {struct} ImageQueueAnimation struct.
/// @description
///   Simple container for sprite and frames_per_second data used in the image system queue.
///   Queued animations are always animated and never loop.
function ImageQueueAnimation(_sprite, _frames_per_second) constructor {
	sprite = _sprite;
	frames_per_second = _frames_per_second;
}