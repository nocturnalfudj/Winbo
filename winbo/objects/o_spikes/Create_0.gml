// Inherit the parent event
event_inherited();

//Image
sprite_current = sprite_index;
sprite_grate_front = noone;
sprite_grate_back = noone;
grate_scale_x = transform[TransformType.anchor].value[TransformValue.xscale].rest;
grate_scale_y = transform[TransformType.anchor].value[TransformValue.yscale].rest;

//Update Transform to Match Angle
transform_set(transform[TransformType.anchor],TransformValue.angle,image_angle,false);
transform_set_rest_to_current(transform[TransformType.anchor],TransformValue.angle);

#region Retractable
	enum SpikeRetractableState{
		out_idle,
		out_countdown,
		in_active,
		in_idle,
		in_countdown,
		out_active,
	}
	
	retractable_state = SpikeRetractableState.out_idle;
	
	retractable_enable = false;
	
	retractable_out_countdown_max = SECOND * 3;
	retractable_out_countdown = retractable_out_countdown_max;
	
	retractable_in_countdown_max = SECOND * 3;
	retractable_in_countdown = retractable_in_countdown_max;
#endregion