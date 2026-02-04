function movement_effects_enable(){
	//Enable
	move_effects_enable = true;
	
	//Velocity Percent
	move_effects_velocity_percent_max = 3;
		
	//Effect Scale
	move_effects_scale = new Vector2(1,1);
		
	//Speed Stretch
	speed_stretch_enable = false;
	speed_stretch_scale = new Vector2(0.5,-0.5);
		
	//Wobble
	wobble_enable = false;
	wobble_scale = new Vector2(0.1,-0.1);
	wobble_wave = MasterWave.sine_0_scaled;
	
	//Acceleration Sway
	acceleration_sway_enable = false;
	acceleration_sway = 0;
	acceleration_sway_max = 10;
	acceleration_sway_lerp_val = 0.2;
}