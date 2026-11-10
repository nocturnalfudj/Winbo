function audio_orb_pickup_play(_silver) {
	var _sound = _silver ? choose(snd_orb_silver_pickup_1, snd_orb_silver_pickup_2) : snd_orb_red_pickup;
	audio_sound_play(_sound, AudioChannel.sfx, false, 0, 0, true, 1, 1);
}