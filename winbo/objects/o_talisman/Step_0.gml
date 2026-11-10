// Inherit the parent event
event_inherited();

//Already Found
if(o_director.talisman_found[talisman_id]){
	//Destory Instance as it Should Not Exist
	instance_destroy();
}

//Animate Flame
image_animate(image_flame,false);