/// @function lighting_colour_set_lerpval
/// @summary Assign target lerp values for lighting color channels.
/// @param _red Value for the red channel.
/// @param _green Value for the green channel.
/// @param _blue Value for the blue channel.
function lighting_colour_set_lerpval(_red,_green,_blue){
	var _colour;
	
	//Red
	_colour = LightingColour.red;
	lighting_colour_lerpval[_colour] = _red;
	
	//Green
	_colour = LightingColour.green;
	lighting_colour_lerpval[_colour] = _green;
	
	//Blue
	_colour = LightingColour.blue;
	lighting_colour_lerpval[_colour] = _blue;
}