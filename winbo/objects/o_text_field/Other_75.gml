//Mobile Virtual Keyboard
if(IS_MOBILE){
	mobile_virtual_keyboard_display = ds_map_find_value(async_load,"keyboard_status");
	
	if(mobile_virtual_keyboard_display == "visible"){
		mobile_virtual_keyboard_show = true;
	}
	else if((mobile_virtual_keyboard_show) && (mobile_virtual_keyboard_display != "showing")){
		mobile_virtual_keyboard_show =  false;
		
		if(state == UIState.edit){
			//State to Active
			ui_object_state_set(UIState.active);
			
			//Custom Edit Stop Script
			ui_object_state_script_stage_execute(UIState.edit,UIStateStage.stop);
		}
	}
}