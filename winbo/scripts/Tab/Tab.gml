/// @function Tab
/// @summary Represents a selectable tab in a UI.
/// @param _position Screen position struct.
/// @param _object Object index created when selected.
/// @param _layer Layer name used for the tab instance.
/// @param _tab_group Group ID for related tabs.
/// @param _ui_group UI group to assign instances to.
/// @param _sprite Icon sprite.
/// @param _entrance_script Script called when entering.
/// @param _exit_script Script called when exiting.
/// @param _remove_other_tab_group_tab Whether to remove other tabs when selected.
/// @param _parent_tab Parent tab for nested hierarchies.
function Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab) constructor{
	position = _position;
	object = _object;
	layer = _layer;
	tab_group = _tab_group;
	ui_group = _ui_group;
	sprite = _sprite;
	entrance_script = _entrance_script;
	exit_script = _exit_script;
	remove_other_tab_group_tab = _remove_other_tab_group_tab;
	parent_tab = _parent_tab;
}