//Inherit
event_inherited();

//Camera Visible System
camera_visible_system_create();

#region State
	enum SpawnerState{
		create,
		idle,
		spawn,
		destroy,
		
		SIZE
	}
	
	state = SpawnerState.create;
#endregion

#region Spawn
	spawn_object = noone;

	spawn_dist_x = sprite_width/2;
	spawn_dist_y = sprite_height/2;
	
	spawn_layer = "lyr_spawner";
	
	spawn_avoid_player = true;
	
	spawn_off_camera = false;
	
	spawn_check_tick_enable = true;
	spawn_check_tick = choose(Tick.a,Tick.b,Tick.c,Tick.d);
	
	spawn_check_condition_script = noone;
	
	spawn_object_weight_array = noone;
	spawn_object_array = noone;
	
	spawn_count = 1;
#endregion