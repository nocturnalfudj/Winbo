function pickup_collect_orb(){
	with(o_director){
		resource[Resource.cash][Team.player] += other.orb_value;
	}
	
	//Track orb collection
	level_stat_add(LevelStat.orbs_collected);
	
	with(instance_create_layer(x,y,"lyr_pfx_foreground",o_txtPstr_orb)){
		text_string = string(other.orb_value);
	}

	var _collect_sprite = (object_index == o_orb_silver) ? spr_fx_collect_orb_silver : spr_fx_collect_orb_red;
	fx_spawn_sprite_once(x, y, "lyr_pfx_foreground", _collect_sprite, 1, 1, 0, 20);
	
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
