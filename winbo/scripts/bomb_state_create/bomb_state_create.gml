/// @function bomb_state_create
/// @summary Initialise bomb settings and start the countdown.
function bomb_state_create() {
	//Make Sure Explode Sprite is Up to Date
	explode_sprite = sprite_index;
	
	//Transform Update Scale
	transform_system_update_scale();
	
	//Dimensions
	dimensions_system_update(sprite_current);
	
	//Camera Visible Dimensions
	camera_visible_dimensions();

	//Go to Countdown
	countdown = countdown_max;
	state = BombState.countdown;

	//Appear
	transform_animate_grow_and_appear();
}