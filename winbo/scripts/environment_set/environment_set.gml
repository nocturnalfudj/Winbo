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
	if(is_undefined(_environment_data)){
		return;
	}
	
	//Set Ground Tile
	_environment_tile = _environment_data.ground_tile_sprite;
	if(_environment_tile != noone){
		var _layer_id = layer_get_id("lyr_background");
		if(_layer_id != -1){
			var _background_id = layer_background_get_id(_layer_id);
			if(_background_id != -1){
				layer_background_sprite(_background_id,_environment_tile);
			}
		}
	}
			
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
