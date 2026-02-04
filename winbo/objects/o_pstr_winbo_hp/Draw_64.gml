if(gui && camera_visible_gui){
	var _gui_scale;
	_gui_scale = o_ui.gui_scale * UI_HUD_SCALE;
	
	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x * _gui_scale;
	_y = y * _gui_scale;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale * _gui_scale;
	_scale_y = image_yscale * _gui_scale;
	
	//Slot
	slot_scale = lerp(slot_scale,slot_scale_target,0.2);
	draw_sprite_ext_ags(spr_hp_slot,0,_x,_y,_scale_x * slot_scale,_scale_y * slot_scale,_angle,_colour,_alpha * slot_scale);
	
	
	if(sprite_current!=noone){
		draw_sprite_ext_ags(sprite_current,sprite_current_frame,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
	}
}