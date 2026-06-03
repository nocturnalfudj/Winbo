//Inherit text_button parent, including UI object and button state setup
event_inherited();

//Initialize rich text character system
rich_text_system_create();

#region Icon and Text Offset
	icon_sprite = noone;
	icon_x = 0;
	icon_y = 0;
	icon_image_index = 0;
	icon_xscale = 1;
	icon_yscale = 1;
	
	text_offset_x = 0;
	text_offset_y = 0;
#endregion
