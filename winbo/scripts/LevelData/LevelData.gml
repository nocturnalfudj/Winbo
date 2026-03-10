// Transition routing for campaign rooms.
#macro LEVEL_SELECT_TRANSITION_DIRECT "direct"
#macro LEVEL_SELECT_TRANSITION_VIA_PRESENCE_HUB "via_presence_hub"

/// @function LevelData
/// @summary Constructor for level data.
/// @param {string} _id Unique level identifier (e.g., "level_0")
/// @param {asset.GMRoom} _level_room Room asset for this level
/// @param {string} _name Display name for the level
/// @param {real} _menu_order Order in the level select menu.
/// @param {string} _next_level_id Next campaign level identifier.
/// @param {string} _transition_style How this room exits into the campaign flow.
/// @param {bool} _start_unlocked Whether this room starts unlocked in a fresh session.
/// @returns {struct} Level data struct
function LevelData(_id, _level_room, _name, _menu_order, _next_level_id, _transition_style, _start_unlocked) constructor {
	id = _id;
	level_room = _level_room;
	name = _name;
	menu_order = _menu_order;
	next_level_id = _next_level_id;
	transition_style = _transition_style;
	unlocked = _start_unlocked;
	completed = false;
}
