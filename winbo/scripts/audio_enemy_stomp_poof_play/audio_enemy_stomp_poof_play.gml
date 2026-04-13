function audio_enemy_stomp_poof_play() {
	audio_sound_play(choose(snd_enemy_stomp_poof_1, snd_enemy_stomp_poof_2), AudioChannel.sfx, false, 0, 0, true, 1, 1);
}
