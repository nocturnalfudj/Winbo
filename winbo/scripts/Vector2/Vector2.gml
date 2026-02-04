/// @function Vector2
/// @summary Basic two dimensional vector struct.
/// @param {real} _x X component value.
/// @param {real} _y Y component value.
/// @returns {struct} Vector2 struct.
function Vector2(_x, _y) constructor{
	x = _x;
	y = _y;
	
	static Set =
	/// @function	Set(_x,_y)
	function(_x,_y){
		x = _x;
		y = _y;
	}
					
	static Copy =
	/// @function	Copy(_other_vector2)
	function(_other_vector2){
		x = _other_vector2.x;
		y = _other_vector2.y;
	}
	
	static Equals =
	/// @function	Equals(_other_vector2)
	function(_other_vector2){
		if((x == _other_vector2.x) && (y == _other_vector2.y))
			return true;
		else
			return false;
	}
					
	static EqualsValues =
	/// @function	EqualsValues(_x,_y)
	function(_x,_y){
		if((x == _x) && (y == _y))
			return true;
		else
			return false;
	}
	
	static Add =
	/// @function	Add(_other_vector2)
	function(_other_vector2){
		x += _other_vector2.x;
		y += _other_vector2.y;
	}
					
	static AddValue =
	/// @function	AddValue(_value)
	function(_value){
		x += _value;
		y += _value;
	}
						
	static AddValues =
	/// @function	AddValues(_x,_y)
	function(_x,_y){
		x += _x;
		y += _y;
	}
	
	static Subtract =
	/// @function	Subtract(_other_vector2)
	function(_other_vector2){
		x -= _other_vector2.x;
		y -= _other_vector2.y;
	}
	
	static Multiply =
	/// @function	Multiply(_other_vector2)
	function(_other_vector2){
		x *= _other_vector2.x;
		y *= _other_vector2.y;
	}
	
	static MultiplyFactor =
	/// @function	MultiplyFactor(_factor)
	function(_factor){
		x *= _factor;
		y *= _factor;
	}
	
	static MultiplyFactors =
	/// @function	MultiplyFactors(_factor_x,_factor_y)
	function(_factor_x,_factor_y){
		x *= _factor_x;
		y *= _factor_y;
	}
							
	static Lerp =
	/// @function	Lerp(_target_vector2,_factor_vector2)
	function(_target_vector2,_factor_vector2){
		x = lerp(x,_target_vector2.x,_factor_vector2.x);
		y = lerp(y,_target_vector2.y,_factor_vector2.y);
	}				
	
	static LerpFactor =
	/// @function	LerpFactor(_target_vector2,_factor)
	function(_target_vector2,_factor){
		x = lerp(x,_target_vector2.x,_factor);
		y = lerp(y,_target_vector2.y,_factor);
	}
						
	static LerpFactors =
	/// @function	LerpFactors(_target_vector2,_factor_x,_factor_y)
	function(_target_vector2,_factor_x,_factor_y){
		x = lerp(x,_target_vector2.x,_factor_x);
		y = lerp(y,_target_vector2.y,_factor_y);
	}
		
	static Magnitude =
	/// @function	Magnitude()
	function(){
		return point_distance(0,0,x,y);
	}
	
	static Direction =
	/// @function	Direction()
	function(){
		return point_direction(0,0,x,y);
	}
	
	static SetMagnitudeDirection =
	/// @function	AddMagnitudeDirection(_magnitude,_direction)
	function(_magnitude,_direction){
		x = lengthdir_x(_magnitude,_direction);
		y = lengthdir_y(_magnitude,_direction);
	}
	
	static AddMagnitudeDirection =
	/// @function	AddMagnitudeDirection(_magnitude,_direction)
	function(_magnitude,_direction){
		x += lengthdir_x(_magnitude,_direction);
		y += lengthdir_y(_magnitude,_direction);
	}
		
	static Clamp =
	/// @function	Clamp(_min,_max)
	function(_min,_max){
		x = clamp(x,_min,_max);
		y = clamp(y,_min,_max);
	}
}