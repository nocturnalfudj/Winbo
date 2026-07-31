if(instance_number(o_player) > 0) {
	var _player;
	_player = instance_find(o_player,0);
	_player.visible = true;
}
if(instance_number(o_camera) > 0) o_camera.lighting_enable = lighting_was_enabled;
if(voice_snd_id != noone) {
	opening_cutscene_sfx_stop(voice_snd_id);
	voice_snd_id = noone;
}
if(ambience_snd_id != noone) {
	opening_cutscene_sfx_stop(ambience_snd_id);
	ambience_snd_id = noone;
}
