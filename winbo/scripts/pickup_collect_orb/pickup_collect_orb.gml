function pickup_collect_orb(){
	with(o_director){
		resource[Resource.cash][Team.player] += other.orb_value;
	}
	
	//Track orb collection
	level_stat_add(LevelStat.orbs_collected);
	
	with(instance_create_layer(x,y,"lyr_pfx_foreground",o_txtPstr_orb)){
		text_string = string(other.orb_value);
	}

	var _silver = (object_index == o_orb_silver);
	var _collect_sprite = _silver ? spr_fx_collect_orb_silver : spr_fx_collect_orb_red;
	pickup_collect_sparkle(_collect_sprite);
	audio_orb_pickup_play(_silver);
	
	//Camera Shake
	camera_shake_add(0.1,250,10,5,false,false,false,1,,false,100,);
	
	//Heal
	if(heal_value > 0){
		with(o_player){
			//Apply Heal
			hp += other.heal_value;
			
			//Limit to Max
			if(hp > hp_max){
				hp = hp_max;
			}
			
			//Update User Data
			user.hp = hp;
		}
	}
}

/// Draw the burst at the visible pickup, including pickups authored on top of the water.
function pickup_collect_sparkle(_sprite){
	var _burst = fx_spawn_sprite_once(x + adjustment_x, y + adjustment_y,
		"lyr_pfx_foreground", _sprite, abs(image_xscale), abs(image_yscale), 0, 20);
	_burst.depth = min(depth, _burst.depth) - 1;
}
