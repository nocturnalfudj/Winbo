//Inherit
event_inherited();

//Alpha Target Approach
if(image_alpha != target_alpha){
	image_alpha = lerp_with_gap_close(image_alpha,target_alpha,0.1,0.01,false);
}
else if(image_alpha == 0){
	instance_destroy();
}