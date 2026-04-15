/// @desc Play one checkpoint activation sound.
function audio_checkpoint_activate_play() {
	var _voice_sound;

	if (irandom(999) == 0) {
		_voice_sound = snd_checkpoint_4;
	}
	else {
		_voice_sound = choose(snd_checkpoint_1, snd_checkpoint_2, snd_checkpoint_3);
	}

	audio_sound_play(_voice_sound, AudioChannel.sfx, false, 0, 0, true, 1, 1);
	audio_sound_play(snd_checkpoint_twinkle, AudioChannel.sfx, false, 0, 0, true, 1, 1);
}
