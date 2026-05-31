function presence_dialogue_stage_get() {
	if(instance_number(o_director) <= 0) {
		return "level_1";
	}

	var _target_room;
	_target_room = o_director.next_level;

	switch(_target_room) {
		case r_game_level_0:
			return "level_1";

		default:
			return "level_1";
	}
}
