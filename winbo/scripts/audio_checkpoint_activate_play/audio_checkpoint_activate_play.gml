/// @desc Play one checkpoint activation sound.
function audio_checkpoint_activate_play() {
	var _sound;

	if (irandom(999) == 0) {
		_sound = snd_checkpoint_4;
	}
	else {
		_sound = choose(snd_checkpoint_1, snd_checkpoint_2, snd_checkpoint_3);
	}

	audio_sound_play(_sound, AudioChannel.sfx, false, 0, 0, true, 1, 1);
}
