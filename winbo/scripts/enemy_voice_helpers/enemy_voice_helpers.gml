function enemy_voice_helpers() {
}

function enemy_voice_is_playing(_enemy){
	var _snd_id = _enemy.voice_snd_id;

	if(_snd_id == noone){
		return false;
	}

	if(audio_is_playing(_snd_id) || audio_is_paused(_snd_id)){
		return true;
	}

	_enemy.voice_snd_id = noone;
	return false;
}

function enemy_voice_choose(_sounds){
	var _count = array_length(_sounds);

	if(_count <= 0){
		return noone;
	}

	return _sounds[irandom(_count - 1)];
}

function enemy_voice_play(_enemy, _sound, _interrupt = false){
	if(_sound == noone){
		return false;
	}

	if(enemy_voice_is_playing(_enemy)){
		if(!_interrupt){
			return false;
		}

		audio_stop_sound(_enemy.voice_snd_id);
		_enemy.voice_snd_id = noone;
	}

	_enemy.voice_snd_id = audio_sound_play(_sound, AudioChannel.sfx, false, 0, 0, true, 1, 1);
	return (_enemy.voice_snd_id != noone);
}
