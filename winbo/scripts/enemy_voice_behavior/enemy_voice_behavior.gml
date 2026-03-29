function enemy_voice_behavior() {
}

function enemy_voice_melee_commando_on_first_aggro(_enemy){
	enemy_voice_play(_enemy, enemy_voice_choose(_enemy.voice_melee_gasp_sounds), false);
}

function enemy_voice_melee_commando_on_attack_start(_enemy){
	var _sound = _enemy.voice_melee_followup_pending;

	if(_sound != noone){
		_enemy.voice_melee_followup_pending = noone;
	}
	else{
		_sound = enemy_voice_choose(_enemy.voice_melee_attack_sounds);

		if(_sound == snd_enemy_melee_attack_die_winbo_1){
			_enemy.voice_melee_followup_pending = snd_enemy_melee_attack_die_immediately_1;
		}
	}

	enemy_voice_play(_enemy, _sound, true);
}

function enemy_voice_space_ranger_reset_aggro(_enemy){
	_enemy.voice_flying_fire_count_this_aggro = 0;
	_enemy.voice_flying_missiles_this_aggro = 0;
	_enemy.voice_flying_slippery_played = false;
	_enemy.voice_flying_cant_hit_played = false;
}

function enemy_voice_space_ranger_on_aggro(_enemy){
	enemy_voice_space_ranger_reset_aggro(_enemy);
	enemy_voice_play(_enemy, enemy_voice_choose(_enemy.voice_flying_aggro_sounds), false);
}

function enemy_voice_space_ranger_on_missile_fire(_enemy){
	_enemy.voice_flying_missiles_this_aggro += 1;

	if(enemy_voice_is_playing(_enemy)){
		return;
	}

	if(o_player.state == PlayerState.death || o_player.state == PlayerState.destroy){
		return;
	}

	if((!_enemy.voice_flying_slippery_played) && (_enemy.voice_flying_missiles_this_aggro >= 3)){
		if(enemy_voice_play(_enemy, enemy_voice_choose(_enemy.voice_flying_slippery_sounds), false)){
			_enemy.voice_flying_slippery_played = true;
		}
		return;
	}

	if((!_enemy.voice_flying_cant_hit_played) && (_enemy.voice_flying_missiles_this_aggro >= 5)){
		if(enemy_voice_play(_enemy, enemy_voice_choose(_enemy.voice_flying_cant_hit_sounds), false)){
			_enemy.voice_flying_cant_hit_played = true;
		}
		return;
	}

	if((_enemy.voice_flying_fire_count_this_aggro < 2) && (irandom(2) == 0)){
		if(enemy_voice_play(_enemy, enemy_voice_choose(_enemy.voice_flying_fire_sounds), false)){
			_enemy.voice_flying_fire_count_this_aggro += 1;
		}
	}
}
