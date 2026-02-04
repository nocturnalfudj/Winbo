//Event Inherit
event_inherited();

if(!create_collision_assign_actor){
	var _space_id;
	_space_id = space_id;

	var _collision_list,_collision_list_size;
	_collision_list = ds_list_create();
	instance_place_list(x,y,o_actor,_collision_list,false);
	_collision_list_size = ds_list_size(_collision_list);
	if(_collision_list_size > 0){
		for(var _i=0;_i<_collision_list_size;_i++){
			with(_collision_list[| _i]){
				level_space_id = _space_id;
			}
		}
	}

	//Destroy Collision List
	ds_list_destroy(_collision_list);
}

if(o_director.level_space_active[space_id] == false){
	//Dimensions
	var _space_width,_space_height;
	_space_width = sprite_width;
	_space_height = sprite_height;
	
	if(light_darkness_instance == noone){
		light_darkness_instance = instance_create_layer(x,y,"lyr_lighting",o_light_square);
		with(light_darkness_instance){
			//Dark
			is_darkness = true;
			
			//Level Space ID
			level_space_id_active_off = other.space_id;
			
			//Dimensions
			image_xscale = _space_width / sprite_width;
			image_yscale = _space_height / sprite_height;
		}
	}
}
else{
	with(light_darkness_instance){
		target_alpha = 0;
	}
	light_darkness_instance = noone;
}