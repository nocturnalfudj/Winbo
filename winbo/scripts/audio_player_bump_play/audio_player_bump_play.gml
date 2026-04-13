function audio_player_bump_play() {
	audio_sound_play(choose(snd_player_bump_1, snd_player_bump_2, snd_player_bump_3), AudioChannel.sfx, false, 0, 0, true, 1, 1);
}
