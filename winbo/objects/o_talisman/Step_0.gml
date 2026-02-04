// Inherit the parent event
event_inherited();

//Check if Talisman is Already Found
if(talisman_id != noone){
	//Already Found
	if(o_director.talisman_found[talisman_id]){
		//Destory Instance as it Should Not Exist
		instance_destroy();
	}
	
	//Make Sure Sprite is Correct
	sprite_index = o_director.talisman_sprite[talisman_id];
}

//Animate Flame
image_animate(image_flame,false);