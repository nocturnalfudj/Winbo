/// @function set_r_game_layers_visible
/// @summary Toggle visibility of gameplay layers in the room.
/// @param enable Whether to show or hide the layers.
/// @returns {void}
function set_r_game_layers_visible(_enable) {
	layer_set_visible("lyr_hud",_enable);
	layer_set_visible("lyr_pfx_foreground",_enable);
	layer_set_visible("lyr_pfx_midground",_enable);
	layer_set_visible("lyr_pfx_background",_enable);
}