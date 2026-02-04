/// @function TargetData
/// @summary Helper struct describing a target object or position for AI.
/// @param _type Target type constant.
/// @param _target Instance or object reference.
/// @param _x Fallback X position when not using an object.
/// @param _y Fallback Y position when not using an object.
/// @returns {struct} Target data struct.
/// @description
///   AI scripts use this to track targets that might be objects or raw positions.
function TargetData(_type,_target,_x,_y) constructor{
	type = Target.position;
	
	enable = true;
	
	object = noone;
	instance = noone;
	x = 0;
	y = 0;
	direction = 0;
	distance = 0;
	
	distance_trigger = 0;
	
	if(_type != undefined){
		type = _type;
		
		switch(type){
			case Target.object:
				object = _target;
				
				with(object){
					other.instance = id;
					break;
				}
				
				if(instance != noone){
					x = instance.x;
					y = instance.y;
					direction = point_direction(other.x,other.y,x,y);
					distance =  point_distance(other.x,other.y,x,y);
				}
			break;
			
			case Target.instance:
				instance = _target;
				if(instance != noone){
					x = instance.x;
					y = instance.y;
					direction = point_direction(other.x,other.y,x,y);
					distance =  point_distance(other.x,other.y,x,y);
				}
			break;
			
			case Target.position:
				x = _x;
				y = _y;
				direction = point_direction(other.x,other.y,x,y);
				distance =  point_distance(other.x,other.y,x,y);
			break;
		}
	}
	
	/// @function is_within_trigger_distance
	/// @summary Check if the target distance is within the trigger distance.
	/// @returns {bool} True if distance is less than or equal to distance_trigger.
	static is_within_trigger_distance = function(){
		return distance <= distance_trigger;
	}
	
	/// @function is_beyond_trigger_distance
	/// @summary Check if the target distance is beyond the trigger distance.
	/// @returns {bool} True if distance is greater than distance_trigger.
	static is_beyond_trigger_distance = function(){
		return distance > distance_trigger;
	}
	
	/// @function is_within_distance
	/// @summary Check if the target distance is within a specified distance.
	/// @param _distance The distance to check against.
	/// @returns {bool} True if current distance is less than or equal to specified distance.
	static is_within_distance = function(_distance){
		return distance <= _distance;
	}
	
	/// @function is_beyond_distance
	/// @summary Check if the target distance is beyond a specified distance.
	/// @param _distance The distance to check against.
	/// @returns {bool} True if current distance is greater than specified distance.
	static is_beyond_distance = function(_distance){
		return distance > _distance;
	}
	
	/// @function has_valid_target
	/// @summary Check if the target has a valid target (exists and is enabled).
	/// @returns {bool} True if target is valid and enabled.
	static has_valid_target = function(){
		if(!enable) return false;
		
		switch(type){
			case Target.object:
				return instance != noone && instance_exists(instance);
			case Target.instance:
				return instance != noone && instance_exists(instance);
			case Target.position:
				return true; // Position targets are always valid if enabled
		}
		
		return false;
	}
	
	/// @function get_distance_ratio
	/// @summary Get the ratio of current distance to trigger distance.
	/// @returns {real} Distance ratio (0.0 = at trigger distance, 1.0 = at double trigger distance, etc.).
	static get_distance_ratio = function(){
		if(distance_trigger <= 0) return 0;
		return distance / distance_trigger;
	}
	
	/// @function is_close_to_trigger
	/// @summary Check if target is close to trigger distance (within a percentage).
	/// @param _percentage The percentage threshold (0.0 to 1.0). Default is 0.1 (10%).
	/// @returns {bool} True if within the percentage of trigger distance.
	static is_close_to_trigger = function(_percentage = 0.1){
		if(distance_trigger <= 0) return false;
		var _threshold = distance_trigger * (1.0 + _percentage);
		return distance <= _threshold;
	}
	
	/// @function get_direction_to_target
	/// @summary Get the direction from a point to this target.
	/// @param _from_x X position to calculate direction from.
	/// @param _from_y Y position to calculate direction from.
	/// @returns {real} Direction in degrees from the specified point to target.
	static get_direction_to_target = function(_from_x, _from_y){
		return point_direction(_from_x, _from_y, x, y);
	}
	
	/// @function get_distance_to_target
	/// @summary Get the distance from a point to this target.
	/// @param _from_x X position to calculate distance from.
	/// @param _from_y Y position to calculate distance from.
	/// @returns {real} Distance from the specified point to target.
	static get_distance_to_target = function(_from_x, _from_y){
		return point_distance(_from_x, _from_y, x, y);
	}
	
	/// @function set_distance_trigger
	/// @summary Set the distance trigger value.
	/// @param _distance The new distance trigger value.
	static set_distance_trigger = function(_distance){
		distance_trigger = _distance;
	}
	
	/// @function enable_target
	/// @summary Enable this target.
	static enable_target = function(){
		enable = true;
	}
	
	/// @function disable_target
	/// @summary Disable this target.
	static disable_target = function(){
		enable = false;
	}
	
	/// @function is_enabled
	/// @summary Check if this target is enabled.
	/// @returns {bool} True if target is enabled.
	static is_enabled = function(){
		return enable;
	}
}

enum Target{
	object,
	instance,
	position,
	
	SIZE
}