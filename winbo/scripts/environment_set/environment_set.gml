/// @function environment_set
/// @summary Apply the chosen environment visual settings.
/// @param {real} _environment  Index of the environment entry.
/// @description
///   Loads data from o_director.environment and updates the ground
///   tile, foreground sprite and active VFX scheme accordingly.
/// @returns {void} No return value.
function environment_set(_environment){
	//Get Environment Data
	var _environment_data,_environment_tile;
	_environment_data = o_director.environment[_environment];
	
	//Set Ground Tile
	_environment_tile = _environment_data.ground_tile_sprite;
	if(_environment_tile == noone)
		_environment_tile = spr_environment_barren_lands_tile;
	layer_background_sprite(layer_background_get_id(layer_get_id("lyr_background")),_environment_tile);
			
	//Set Foreground Sprite
	o_director.environment_foreground_sprite = _environment_data.foreground_sprite;
			
        #region VFX
                // Retrieve visual effects settings for this environment
                var _vfx_scheme;
                _vfx_scheme = _environment_data.vfx_scheme;

                //Apply Environment Scheme
		with(o_camera){
			vfx_scheme_set_active(_vfx_scheme);
		}
	#endregion
	
	//Update Current Environment
	o_director.environment_current = _environment;
}