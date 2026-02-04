/// @function title_system_create
/// @summary Initialise title and subtitle defaults.
/// @returns {void}
function title_system_create(){
	#region Title
		title_enable = false;
		title_text = noone;
		title_string = "TITLE";
		title_font = fnt_bahnschrift_16;
		title_colour = c_white;
		title_halign = fa_center;
		title_valign = fa_middle;
		title_x = 0;
		title_y = -100;
		title_width = 1000;
		
		//Shadow
		title_shadow_enable = false;
		title_shadow_colour = c_black;
		title_shadow_x = 3;
		title_shadow_y = 3;
		title_shadow_alpha = 0.75;
	#endregion
	
	#region Subtitle
		subtitle_enable = false;
		subtitle_text = noone;
		subtitle_string = "subtitle";
		subtitle_font = fnt_bahnschrift_16;
		subtitle_colour = c_white;
		subtitle_halign = fa_center;
		subtitle_valign = fa_middle;
		subtitle_x = 0;
		subtitle_y = -50;
		subtitle_width = 1000;
		
		//Shadow
		subtitle_shadow_enable = false;
		subtitle_shadow_colour = c_black;
		subtitle_shadow_x = 3;
		subtitle_shadow_y = 3;
		subtitle_shadow_alpha = 0.75;
	#endregion
}