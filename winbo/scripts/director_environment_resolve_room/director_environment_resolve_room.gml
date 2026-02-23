/// @function director_environment_resolve_room
/// @summary Resolve room -> director environment mapping.
/// @param {Asset.GMRoom} _room Room asset.
/// @returns {real} Environment enum value.
function director_environment_resolve_room(_room) {
	// Artist Level 1 -> r_game_level_0 family
	if (_room == r_game_level_0 || _room == r_game_level_0_bonus_a || _room == r_game_level_0_bonus_b) {
		return Environment.level_1_environment;
	}
	
	// Artist Level 2 -> r_game_level_1 family
	if (_room == r_game_level_1 || _room == r_game_level_1_bonus_a || _room == r_game_level_1_bonus_b) {
		return Environment.level_2_environment;
	}
	
	// Forest fallback for all unmatched gameplay rooms
	return Environment.default_environment;
}
