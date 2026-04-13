function audio_player_air_dash_play() {
	audio_sound_play(choose(snd_player_air_dash_1, snd_player_air_dash_2, snd_player_air_dash_3, snd_player_air_dash_4), AudioChannel.sfx, false, 0, 0, true, 1, 1);
}
