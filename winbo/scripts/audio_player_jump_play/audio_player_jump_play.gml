function audio_player_jump_play() {
	audio_sound_play(choose(snd_player_jump_1, snd_player_jump_2, snd_player_jump_3), AudioChannel.sfx, false, 0, 0, true, 1, 1);
}