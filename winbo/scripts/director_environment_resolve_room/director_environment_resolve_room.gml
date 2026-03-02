/// @function director_environment_resolve_room
/// @summary Resolve room -> director environment mapping.
/// @param {Asset.GMRoom} _room Room asset.
/// @returns {real} Environment enum value.
function director_environment_resolve_room(_room) {
	// Bonus rooms use their own shared environment profile.
	if (
		_room == r_game_level_0_bonus_a
		|| _room == r_game_level_0_bonus_b
		|| _room == r_game_level_1_bonus_a
		|| _room == r_game_level_1_bonus_b
	) {
		return Environment.bonus_room_environment;
	}
	
	// Level 1 -> level_0 room
	if (_room == r_game_level_0) {
		return Environment.level_1_environment;
	}
	
	// Level 2 -> level_1 room
	if (_room == r_game_level_1) {
		return Environment.level_2_environment;
	}
	
	// Forest fallback for all unmatched gameplay rooms
	return Environment.default_environment;
}
