function missile_state_explode(){
	// Missile explosion effect
	// Could add particle effects here
	
	// Shrink and fade out
	transform_animate_from_current_shrink_and_fade();
	
	// Transition to destroy state
	state = BulletState.destroy;
}
