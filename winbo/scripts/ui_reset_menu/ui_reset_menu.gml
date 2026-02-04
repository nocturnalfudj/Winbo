function ui_reset_menu(){
	with(o_anchor_menu){
		//Destroy
		ui_object_state_set(UIState.destroy);
	}
	
	o_ui.menu_create_default_tab = false;
	
	o_ui.ui_reset_menu_active = true;
}