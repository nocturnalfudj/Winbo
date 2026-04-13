/// @desc Play one checkpoint activation sound.
function audio_checkpoint_activate_play() {
	audio_sound_play(snd_checkpoint_twinkle, AudioChannel.sfx, false, 0, 0, true, 1, 1);
}
