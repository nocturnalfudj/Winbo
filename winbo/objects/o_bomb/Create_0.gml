// Inherit the parent event
event_inherited();

//Layer
depth_object_layer = DepthObjectLayer.top;

//Enable Transform Relative
transform_system_relative_enable();

//Start Invisible
image_alpha = 0;
image_xscale = 0;
//image_yscale = 0;
var _transform;
_transform = transform[TransformType.anchor];
transform_set(_transform,TransformValue.alpha,0,false);
transform_set(_transform,TransformValue.xscale,0,false);
transform_set(_transform,TransformValue.yscale,0,false);
_transform = transform[TransformType.relative];
transform_set(_transform,TransformValue.alpha,0,false);
transform_set(_transform,TransformValue.xscale,0,false);
transform_set(_transform,TransformValue.yscale,0,false);

enum BombState{
	create,
	countdown,
	detonate,
	explode,
	fade,
	death,
	destroy,
	
	SIZE
}

state = BombState.create;

//Repeat
repeat_count = 0;
repeat_current = 0;

//Movement
movement_velocity_retention_and_acceleration_max_set(0.95,2);
move_trapped_free_self = false;

//Owner
owner = noone;
owners_owner = noone;

//Collision List
collision_list = ds_list_create();

//SFX
detonate_snd = noone;

//Countdown
countdown_max = SECOND;
countdown = countdown_max;
countdown_sprite = sprite_index;

//Explode
explode_time_max = SECOND * 2;
explode_countdown = explode_time_max;
explode_curve_scale = ease_expo_out;
explode_curve_angle = ease_expo_out;
explode_curve_alpha = ease_expo_out;
explode_sprite = sprite_index;
explode_script = noone;
explode_scale_target = 0.5;
explode_alpha_target = 0;
explode_angle_target = 0;

//Fade
fade_time_max = SECOND * 2;
fade_countdown = fade_time_max;
fade_curve_scale = ease_sine_in_out;
fade_curve_angle = ease_sine_in_out;
fade_curve_alpha = ease_sine_in_out;
fade_script = noone;
fade_scale_target = 0.5;
fade_alpha_target = 0;
fade_angle_target = 0;

//Spin
spin_current = 0;
spin_max = 0;			//Value not 0 will disable angle animations
spin_lerp_value = 0.3;

#region Homing
	homing_target = noone;
	homing_target_object = noone;
	homing_acceleration = 0;
	homing_find_new_target = true;
#endregion