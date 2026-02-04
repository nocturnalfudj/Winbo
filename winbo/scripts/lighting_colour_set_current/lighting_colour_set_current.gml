function lighting_colour_set_current(_red,_green,_blue){
	var _colour;
	
	//Red
	_colour = LightingColour.red;
	lighting_colour_current[_colour] = _red/255;
	
	//Green
	_colour = LightingColour.green;
	lighting_colour_current[_colour] = _green/255;
	
	//Blue
	_colour = LightingColour.blue;
	lighting_colour_current[_colour] = _blue/255;
	
	//Lighting Shader Needs Updating
	lighting_shader_update = true;
}