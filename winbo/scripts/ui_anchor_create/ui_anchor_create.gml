/// @function ui_anchor_create
/// @summary Create a menu anchor instance if none exists.
/// @param _menu_anchor Anchor object type to create
/// @param _layer       Room layer to spawn the anchor on
/// @returns {void} No return value.
function ui_anchor_create(_menu_anchor,_layer){
	if(instance_number(_menu_anchor) == 0){
		instance_create_layer(0,0,_layer,_menu_anchor);
	}
	else{
		ui_anchor_show(_menu_anchor);
	}
}