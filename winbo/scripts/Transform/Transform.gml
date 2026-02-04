#region Enums
	enum TransformType{
		anchor,
		relative,
		
		SIZE
	}
	
	enum TransformValue{
		x,
		y,
		xscale,
		yscale,
		alpha,
		colour,
		angle,
		
		SIZE
	}
	
	enum AnchorTransformChild{
		top_left,
		top_center,
		top_right,
		center_right,
		bottom_right,
		bottom_center,
		bottom_left,
		center_left,
		center,
	
		SIZE
	}
#endregion

/// @function Transform
/// @summary Stores transform values for an instance.
/// @param _x Starting x position or TRANSFORM_VALUE_DISABLED.
/// @param _y Starting y position or TRANSFORM_VALUE_DISABLED.
/// @param _xscale Starting horizontal scale or TRANSFORM_VALUE_DISABLED.
/// @param _yscale Starting vertical scale or TRANSFORM_VALUE_DISABLED.
/// @param _alpha Starting image alpha or TRANSFORM_VALUE_DISABLED.
/// @param _angle Starting angle in degrees or TRANSFORM_VALUE_DISABLED.
/// @param _colour Starting blend colour or TRANSFORM_VALUE_DISABLED.
/// @returns {struct} Transform struct.
/// @description
///   Use with instances that need animated position, scale, or alpha values.
function Transform(_x,_y,_xscale,_yscale,_alpha,_angle,_colour) constructor{
	for(var _i=0;_i<TransformValue.SIZE;_i++){
		value[_i] = noone;
	}
	
	if(_x		!= TRANSFORM_VALUE_DISABLED)	value[TransformValue.x]			= new TransValue(_x);
	if(_y		!= TRANSFORM_VALUE_DISABLED)	value[TransformValue.y]			= new TransValue(_y);
	if(_xscale	!= TRANSFORM_VALUE_DISABLED)	value[TransformValue.xscale]	= new TransValue(_xscale);
	if(_yscale	!= TRANSFORM_VALUE_DISABLED)	value[TransformValue.yscale]	= new TransValue(_yscale);
	if(_alpha	!= TRANSFORM_VALUE_DISABLED)	value[TransformValue.alpha]		= new TransValue(_alpha);
	if(_angle	!= TRANSFORM_VALUE_DISABLED)	value[TransformValue.angle]		= new TransValue(_angle);
	if(_colour	!= TRANSFORM_VALUE_DISABLED)	value[TransformValue.colour]	= new TransValue(_colour);
	
	if(_colour != TRANSFORM_VALUE_DISABLED) value[TransformValue.colour].recoil_curve = ease_linear;
	
	animating = false;
}

#macro TRANSFORM_VALUE_DISABLED infinity