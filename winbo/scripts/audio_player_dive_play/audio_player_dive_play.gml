function audio_player_dive_play() {
	audio_sound_play(choose(snd_player_dive_1, snd_player_dive_2), AudioChannel.sfx, false, 0, 0, true, 1, 1);
}