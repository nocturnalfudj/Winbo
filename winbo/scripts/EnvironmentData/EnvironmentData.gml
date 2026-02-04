/// @function EnvironmentData
/// @summary Information for a particular environment layout.
/// @param {real} _environment_id Unique identifier for the environment.
/// @param {string} _name Display name used in debugging tools.
/// @param _tile Ground tile sprite index.
/// @param _foreground_sprite Foreground sprite asset.
/// @returns {struct} Environment data struct.
/// @description
///   Used by the level generator when spawning environments.
function EnvironmentData(_environment_id,_name,_tile,_foreground_sprite) constructor{
	environment_id = _environment_id;
	name = _name;
	
	ground_tile_sprite = _tile;
	
	foreground_sprite = _foreground_sprite;
	
	texture_group = "";
	
	#region VFX Scheme
		vfx_scheme = new VFXScheme();
	#endregion
}