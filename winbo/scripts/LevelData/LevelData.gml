/// @function LevelData
/// @summary Constructor for level data.
/// @param {string} _id Unique level identifier (e.g., "level_0")
/// @param {asset.GMRoom} _level_room Room asset for this level
/// @param {string} _name Display name for the level
/// @param {real} _order Order in level sequence (0, 1, 2, etc.)
/// @returns {struct} Level data struct
function LevelData(_id, _level_room, _name, _order) constructor {
	id = _id;
	level_room = _level_room;
	name = _name;
	order = _order;
	unlocked = (_order == 0); // First level starts unlocked
	completed = false;
}
