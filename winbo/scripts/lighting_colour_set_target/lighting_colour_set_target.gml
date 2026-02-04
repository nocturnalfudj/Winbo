/// @function lighting_colour_set_target
/// @summary Set RGB lighting targets for interpolation.
/// @param {real} _red Red component 0..255.
/// @param {real} _green Green component 0..255.
/// @param {real} _blue Blue component 0..255.
function lighting_colour_set_target(_red,_green,_blue){
	var _colour;
	
	//Red
	_colour = LightingColour.red;
	lighting_colour_target[_colour] = _red/255;
	
	//Green
	_colour = LightingColour.green;
	lighting_colour_target[_colour] = _green/255;
	
	//Blue
	_colour = LightingColour.blue;
	lighting_colour_target[_colour] = _blue/255;
	
	//Lighting Shader Needs Updating
	lighting_shader_update = true;
}