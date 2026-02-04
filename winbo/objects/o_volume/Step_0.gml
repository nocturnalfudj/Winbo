if(level_space_id == noone){
	//Space ID
	var _space_id;
	_space_id = noone;
	with(instance_place(x,y,o_level_space)){
		_space_id = space_id;
	}
	level_space_id = _space_id;
}