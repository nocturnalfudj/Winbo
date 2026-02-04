/// @function Countdown
/// @summary Timer that counts down and optionally triggers a script.
/// @param {real} _time         Starting time in steps.
/// @param {real} _time_max     Maximum time in steps.
/// @param {bool} [_active=true]    If false the timer will not tick.
/// @param {real} [_reset_count]    Number of automatic resets.
/// @param [_trigger_script]        Script to call when time reaches zero.
/// @returns {struct} Countdown timer struct.
/// @description
///   Useful for delayed actions. Call `Update()` on the returned struct every
///   step to tick the timer.
function Countdown(_time,_time_max,_active,_reset_count,_trigger_script) constructor{
	time = _time;
	time_max = _time_max;
	percent = time / time_max;
	_active ??= true;
	active = _active;
	trigger_active = false;
	trigger_active_one_step_only = false;
	_reset_count ??= COUNTDOWN_RESET_COUNT_INFINITE;
	reset_count = _reset_count;
	reset_count_current = 0;
	_trigger_script ??= noone;
	trigger_script = _trigger_script;
	
	
	static Set =
	/// @function	Set(_time,_time_max)
	function(_time,_time_max){
		time = _time;
		time_max = _time_max;
		
		//Update Percent
		COUNTDOWN_PERCENT_UPDATE;
		//Update Trigger Active
		COUNTDOWN_TRIGGER_ACTIVE_UPDATE;
	}
	
	static Reset =
	/// @function	Reset()
	function(){
		time = time_max;
		
		//Update Percent
		COUNTDOWN_PERCENT_UPDATE;
		//Update Trigger Active
		COUNTDOWN_TRIGGER_ACTIVE_UPDATE;
	}
	
	static SetTime =
	/// @function	SetTime(_time)
	function(_time){
		time = _time;
		
		//Update Percent
		COUNTDOWN_PERCENT_UPDATE;
		//Update Trigger Active
		COUNTDOWN_TRIGGER_ACTIVE_UPDATE;
	}
	
	static SetTimeMax =
	/// @function	SetTimeMax(_time_max)
	function(_time_max){
		time_max = _time_max;
	}
	
	static SetTimePercent =
	/// @function	SetTime(_time_percent)
	function(_time_percent){
		time = _time_percent * _time_max;
		percent = _time_percent;
		
		//Update Trigger Active
		COUNTDOWN_TRIGGER_ACTIVE_UPDATE;
	}
	
	static SetActive =
	/// @function	Set(_active)
	function(_active){
		active = _active;
	}
	
	static Update =
	/// @function	Update(_time_factor)
	function(_time_factor){	
		//Only Consider Active Countdowns
		if(!active)
			exit;
		
		//Only Consider Countdowns with Time
		if(time <= 0){
			//Trigger Should Only Be Active for 1 Step
			if(trigger_active_one_step_only){
				//Deactivate Trigger
				trigger_active = false;
			}
			//Trigger Can Be Active for Multiple Steps
			else{
				//Trigger is Active
				if(trigger_active){
					//Run Trigger Script
					if(trigger_script != noone){
						script_execute(trigger_script);
					}
				}
			}
			
			//Reset Count
			if((reset_count == COUNTDOWN_RESET_COUNT_INFINITE) || ((reset_count > 0) && (reset_count_current < reset_count))){
				//Reset
				Reset();
				
				//Increase Count
				reset_count_current++;
			}
			
			exit;
		}
		
		//Default to Default Delta Time Factor
		_time_factor ??= global.delta_time_factor;
		
		//Reduce Countdown
		time -= _time_factor;
		
		//Deactivate Trigger by Default
		//if the trigger is meant to stay active even after the countdown is complete it will,
		//as this line is never reached until the trigger is reset
		trigger_active = false;
		
		//Countdown Complete Check
		if(time <= 0){
			time = 0;
			trigger_active = true;
			
			//Run Trigger Script
			if(trigger_script != noone){
				script_execute(trigger_script);
			}
		}
		
		//Update Percent
		COUNTDOWN_PERCENT_UPDATE;
	}
}

#macro COUNTDOWN_PERCENT_UPDATE percent = time / time_max
#macro COUNTDOWN_TRIGGER_ACTIVE_UPDATE if(time > 0) trigger_active = false
#macro COUNTDOWN_RESET_COUNT_INFINITE -1
#macro COUNTDOWN_RESET_COUNT_NEVER 0