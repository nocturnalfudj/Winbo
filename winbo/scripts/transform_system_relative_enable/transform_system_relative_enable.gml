function transform_system_relative_enable(_x,_y,_xscale,_yscale,_alpha,_angle,_colour){
	if(is_undefined(_x))		_x		= 0;
	if(is_undefined(_y))		_y		= 0;
	if(is_undefined(_xscale))	_xscale = 1;
	if(is_undefined(_yscale))	_yscale = 1;
	if(is_undefined(_alpha))	_alpha	= 1;
	if(is_undefined(_angle))	_angle	= 0;
	if(is_undefined(_colour))	_colour = c_white;
	transform[TransformType.relative] = new Transform(_x,_y,_xscale,_yscale,_alpha,_angle,_colour);
}