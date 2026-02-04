function image_system_update(){
	if(image != noone){
		image_animate(image);
		
		// Keep the instance draw sprite in sync with the image system.
		// The queue system swaps `image.sprite_current`, and if we don't mirror it here,
		// the Draw event will continue using a stale `sprite_current`.
		sprite_current = image.sprite_current;
	}
}