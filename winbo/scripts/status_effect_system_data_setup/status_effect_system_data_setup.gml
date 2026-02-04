/// @function status_effect_system_data_setup
/// @summary Populate status effect enums and setup related data arrays.
/// @returns {void} No return value.
/// @description
///   Should be run once at game start to configure available status effects.
function status_effect_system_data_setup(){
	enum StatusEffect{
		invincible,
		invincible_dash,
		shield,
		speed_boost,
		damage_boost,
		health_boost,
		size_boost_small,
		size_boost_medium,
		size_boost_big,
		resistance_boost,
		pickup_magnet,
		slow,
		hidden,
		invisible,
		fire,
		buzzed,
		infected,
		
		SIZE
	}
	
	var _status_effect_data;
	var _status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max;
	
	//Invincible
	_status_effect_id = StatusEffect.invincible;
	_status_effect_name = "Invincible";
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = noone;
	_status_effect_active_script = noone;
	_status_effect_end_script = noone;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Invincible Dash
	_status_effect_id = StatusEffect.invincible_dash;
	_status_effect_name = "Invincible";
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = noone;
	_status_effect_active_script = noone;
	_status_effect_end_script = noone;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 0.5;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Shield
	_status_effect_id = StatusEffect.shield;
	_status_effect_name = "Shield";
	_status_effect_sprite = noone;
	_status_effect_active_max = 3;
	_status_effect_start_script = status_effect_start_shield;
	_status_effect_active_script = noone;
	_status_effect_end_script = status_effect_start_shield;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.permanent;
	_status_effect_duration = 0;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Speed Boost
	_status_effect_id = StatusEffect.speed_boost;
	_status_effect_name = "Speed Boost";
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = status_effect_start_speed_boost;
	_status_effect_active_script = noone;
	_status_effect_end_script = status_effect_end_speed_boost;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 5;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Damage Boost
	_status_effect_id = StatusEffect.damage_boost;
	_status_effect_name = "Damage Boost";
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = status_effect_start_damage_boost;
	_status_effect_active_script = status_effect_active_damage_boost;
	_status_effect_end_script = status_effect_end_damage_boost;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 5;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	#macro STATUS_EFFECT_DAMAGE_BOOST_MULTIPLIER_INCREASE 1
	
	//Health Boost
	_status_effect_id = StatusEffect.health_boost;
	_status_effect_name = "Health Boost";
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = status_effect_start_health_boost;
	_status_effect_active_script = noone;
	_status_effect_end_script = status_effect_end_health_boost;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 5;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	#region Size Boost
		//Small
		_status_effect_id = StatusEffect.size_boost_small;
		_status_effect_name = "Size Boost Small"
		_status_effect_sprite = noone;
		_status_effect_active_max = 1;
		_status_effect_start_script = status_effect_start_size_boost_small;
		_status_effect_active_script = noone;
		_status_effect_end_script = status_effect_end_size_boost;
		_status_effect_passive_script = noone;
		_status_effect_duration_type = StatusEffectDurationType.countdown;
		_status_effect_duration = SECOND * 5;
		_status_effect_trigger_type = StatusEffectTriggerType.passive;
		_status_effect_trigger_countdown_max = 0;
		_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
		status_effect[_status_effect_id] = _status_effect_data;
		
		//Medium
		_status_effect_id = StatusEffect.size_boost_medium;
		_status_effect_name = "Size Boost Medium"
		_status_effect_sprite = noone;
		_status_effect_active_max = 1;
		_status_effect_start_script = status_effect_start_size_boost_medium;
		_status_effect_active_script = noone;
		_status_effect_end_script = status_effect_end_size_boost;
		_status_effect_passive_script = noone;
		_status_effect_duration_type = StatusEffectDurationType.countdown;
		_status_effect_duration = SECOND * 5;
		_status_effect_trigger_type = StatusEffectTriggerType.passive;
		_status_effect_trigger_countdown_max = 0;
		_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
		status_effect[_status_effect_id] = _status_effect_data;
		
		//Big
		_status_effect_id = StatusEffect.size_boost_big;
		_status_effect_name = "Size Boost Big"
		_status_effect_sprite = noone;
		_status_effect_active_max = 1;
		_status_effect_start_script = status_effect_start_size_boost_big;
		_status_effect_active_script = noone;
		_status_effect_end_script = status_effect_end_size_boost;
		_status_effect_passive_script = noone;
		_status_effect_duration_type = StatusEffectDurationType.countdown;
		_status_effect_duration = SECOND * 5;
		_status_effect_trigger_type = StatusEffectTriggerType.passive;
		_status_effect_trigger_countdown_max = 0;
		_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
		status_effect[_status_effect_id] = _status_effect_data;
	#endregion
	
	//Resistance Boost
	_status_effect_id = StatusEffect.resistance_boost;
	_status_effect_name = "Resistance Boost";
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = status_effect_start_resistance_boost;
	_status_effect_active_script = noone;
	_status_effect_end_script = status_effect_end_resistance_boost;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 5;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	#macro STATUS_EFFECT_DAMAGE_RESISTANCE_BOOST_MULTIPLIER_INCREASE 0.5
	
	//Pickup Magnet
	_status_effect_id = StatusEffect.pickup_magnet;
	_status_effect_name = "Pickup Magnet"
	_status_effect_sprite = noone;
	_status_effect_active_max = 3;
	_status_effect_start_script = noone;
	_status_effect_active_script = noone;
	_status_effect_end_script = noone;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 5;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Slow
	_status_effect_id = StatusEffect.slow;
	_status_effect_name = "Slow"
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = status_effect_start_slow;
	_status_effect_active_script = noone;
	_status_effect_end_script = status_effect_end_slow;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 5;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Hidden
	_status_effect_id = StatusEffect.hidden;
	_status_effect_name = "Hidden"
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = status_effect_start_hidden;
	_status_effect_active_script = noone;
	_status_effect_end_script = status_effect_end_hidden;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 0.1;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Invisible
	_status_effect_id = StatusEffect.invisible;
	_status_effect_name = "Invisible"
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = status_effect_start_invisible;
	_status_effect_active_script = noone;
	_status_effect_end_script = status_effect_end_invisible;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 0.1;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Fire
	_status_effect_id = StatusEffect.fire;
	_status_effect_name = "Fire"
	_status_effect_sprite = noone;
	_status_effect_active_max = 5;
	_status_effect_start_script = status_effect_start_fire;
	_status_effect_active_script = status_effect_active_fire;
	_status_effect_end_script = status_effect_end_fire;
	_status_effect_passive_script = status_effect_passive_fire;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND*1;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Buzzed
	_status_effect_id = StatusEffect.buzzed;
	_status_effect_name = "Buzzed";
	_status_effect_sprite = noone;
	_status_effect_active_max = 1;
	_status_effect_start_script = status_effect_start_buzzed_boost;
	_status_effect_active_script = status_effect_active_buzzed_boost;
	_status_effect_end_script = status_effect_end_buzzed_boost;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.countdown;
	_status_effect_duration = SECOND * 1;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
	
	//Infected
	_status_effect_id = StatusEffect.infected;
	_status_effect_name = "Infected";
	_status_effect_sprite = noone;
	_status_effect_active_max = 10;
	_status_effect_start_script = noone;
	_status_effect_active_script = noone;
	_status_effect_end_script = noone;
	_status_effect_passive_script = noone;
	_status_effect_duration_type = StatusEffectDurationType.permanent;
	_status_effect_duration = 0;
	_status_effect_trigger_type = StatusEffectTriggerType.passive;
	_status_effect_trigger_countdown_max = 0;
	_status_effect_data = new StatusEffectData(_status_effect_id,_status_effect_name,_status_effect_sprite,_status_effect_active_max,_status_effect_start_script,_status_effect_active_script,_status_effect_end_script,_status_effect_passive_script,_status_effect_duration_type,_status_effect_duration,_status_effect_trigger_type,_status_effect_trigger_countdown_max);
	status_effect[_status_effect_id] = _status_effect_data;
}