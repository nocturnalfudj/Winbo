function ui_gui_scale_update(_gui_scale){
	with(o_ui){
		gui_scale = _gui_scale;
		gui_scale_inverse = 1/gui_scale;
		
		sdm("gui scl: " + string(gui_scale));
		sdm("gui sclInv: " + string(gui_scale_inverse));
		
		gui_width = display_get_gui_width();
		gui_height = display_get_gui_height();
		
		sdm("gui width: " + string(gui_width));
		sdm("gui height: " + string(gui_height));
	}
}