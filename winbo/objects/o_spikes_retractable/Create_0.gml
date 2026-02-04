// Inherit the parent event
event_inherited();

//Image
//sprite_current = director_get_custom_sprite(spr_spikes);

sprite_grate_front = spr_spikes_retractable_grate_front_metal;

#region Retractable
	retractable_enable = true;
	
	retractable_out_countdown_max = SECOND * 2;
	retractable_out_countdown = retractable_out_countdown_max;
	
	retractable_in_countdown_max = SECOND * 2;
	retractable_in_countdown = retractable_in_countdown_max;
#endregion