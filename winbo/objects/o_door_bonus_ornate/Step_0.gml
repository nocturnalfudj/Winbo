var _open_image_index_before = bonus_door_open_image_index;

event_inherited();

if (bonus_door_open_image_index <= 0) {
	bonus_door_creak_armed = true;
}
else if (bonus_door_creak_armed && _open_image_index_before <= 0) {
	audio_sound_play(snd_bonus_door_creak, AudioChannel.sfx, false, 0, 0, true, 1, 1);
	bonus_door_creak_armed = false;
}
