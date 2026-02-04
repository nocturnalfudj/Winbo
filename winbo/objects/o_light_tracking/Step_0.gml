//Inherit
event_inherited();

//Track
if (!instance_exists(follow)) {
	instance_destroy();
}
else{
	#region Update Targets
		if(offset_targets_updated == false){
			//Don't Update Again
			offset_targets_updated = true;
			
			//Set Offset Targets to Current
			lighting_light_tracking_set_offset_targets_to_current();
		}
	#endregion
	
	#region Target
		//X
		if(offset_x != offset_x_target){
			offset_x = lerp(offset_x,offset_x_target,0.2);
		}
		
		//Y
		if(offset_y != offset_y_target){
			offset_y = lerp(offset_y,offset_y_target,0.2);
		}
		
		//X Scale
		if(offset_xscale != offset_xscale_target){
			offset_xscale = lerp(offset_xscale,offset_xscale_target,0.2);
		}
		
		//Y Scale
		if(offset_yscale != offset_yscale_target){
			offset_yscale = lerp(offset_yscale,offset_yscale_target,0.2);
		}
		
		//Alpha
		if(offset_alpha != offset_alpha_target){
			offset_alpha = lerp(offset_alpha,offset_alpha_target,0.2);
		}
		
		//Blend
		if(image_blend != image_blend_target){
			image_blend = merge_color(image_blend,image_blend_target,0.2);
		}
	#endregion
	
	x = follow.x+offset_x;
	y = follow.y+offset_y;
	image_xscale = follow.image_xscale * offset_xscale;
	image_yscale = follow.image_yscale * offset_yscale;
	image_alpha = follow.image_alpha * offset_alpha;
	
	camera_visible_buff_width = sprite_width * camera_visible_buff_factor;
	camera_visible_buff_height = sprite_height * camera_visible_buff_factor;
}