var _open_image_index_before = bonus_door_open_image_index;

event_inherited();

// Frames 0–31 are the approach/glow phase. Trigger when the two door panels
// first separate at frame 32, which is the requested start of the opening.
if (bonus_door_open_image_index < bonus_door_creak_frame) {
	bonus_door_creak_armed = true;
}
else if (bonus_door_creak_armed && _open_image_index_before < bonus_door_creak_frame) {
	var _bonus_door_creak_sound;
	_bonus_door_creak_sound = choose(
		snd_bonus_door_creak_1,
		snd_bonus_door_creak_2
	);
	audio_sound_play(_bonus_door_creak_sound, AudioChannel.sfx, false, 0, 0, true, 1, 1);
	bonus_door_creak_armed = false;
}
