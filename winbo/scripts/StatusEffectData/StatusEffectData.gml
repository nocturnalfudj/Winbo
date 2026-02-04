/// @function StatusEffectData
/// @summary Defines a status effect with scripts and timing information.
/// @param _status_effect_id Unique numeric identifier.
/// @param _name Display name for the effect.
/// @param _sprite Sprite used for UI icons.
/// @param _active_max Maximum stack count.
/// @param _start_script Script executed when effect begins.
/// @param _active_script Per-step update script.
/// @param _end_script Script run when the effect ends.
/// @param _passive_script Passive tick script.
/// @param _duration_type How duration is handled (e.g. countdown).
/// @param _duration Duration amount based on the type.
/// @param _trigger_type What event type triggers state changes.
/// @param _trigger_countdown_max Countdown maximum for trigger.
/// @returns {struct} Status effect data struct.
/// @description
///   Provides all information needed for runtime status effect behaviour.
function StatusEffectData(_status_effect_id,_name,_sprite,_active_max,_start_script,_active_script,_end_script,_passive_script,_duration_type,_duration,_trigger_type,_trigger_countdown_max) constructor{
	//Info
	status_effect_id = _status_effect_id;
	name = _name;
	sprite = _sprite;
	active_max = _active_max;	//Largest stack count
	
	//Scripts
	start_script = _start_script;
	active_script = _active_script;
	end_script = _end_script;
	passive_script = _passive_script;
	
	//Duration
	duration_type = _duration_type;
	duration = _duration;
	
	//Trigger
	trigger_type = _trigger_type;
	if(trigger_type == StatusEffectTriggerType.countdown){
		trigger_countdown_max = _trigger_countdown_max;//new Countdown(_trigger_countdown_max,_trigger_countdown_max);
	}
}

enum StatusEffectDurationType{
	permanent,
	countdown,
	number,
	
	SIZE
}

enum StatusEffectTriggerType{
	passive,	//Active every update
	countdown,	//Active every countdown trigger
	custom,		//Trigger is activated elsewhere in code
	
	SIZE
}