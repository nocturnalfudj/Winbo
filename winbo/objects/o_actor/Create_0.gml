//Inherit Parent
event_inherited();

//Create Position
create_x = x;
create_y = y;

//Camera Visible System
camera_visible_system_create();

//Create Dimensions System
dimension_system_create();

//Transform System
transform_system_create();
transform_animation_time_scale_enable = true;

//Movement System
movement_system_create();
//movement_limit_enable(0,room_width,0,room_height);

#region Path Finding
	path_finding_path = path_add();
	path_finding_path_found = false;
	path_finding_tick = choose(Tick.a,Tick.b,Tick.c,Tick.d);
#endregion

#region Target
	target_system_create();
	
	target[TargetType.attack].set_distance_trigger(1000);
	target[TargetType.move].set_distance_trigger(2);
#endregion

//Image
image_system_create();
image_animation_time_scale_enable = true;
animation_fps_multiplier = 1.0;

//Start with No Scale
image_xscale = 0;
image_yscale = 0;

//Info Bar
info_bar_system_create();

//Flash
flash_system_create();

//State
move_state = noone;
death_state = noone;
destroy_state = noone;
float_state = noone;