// Inherit the parent event
event_inherited();

#region Tab Creation
	var _x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
	
	//Settings Tab
	var _tab_current,_tab;
	_tab_current = o_ui.tab_current[TabGroup.settings];
	_tab = o_ui.settings_tab[_tab_current];
	tab_create(_tab,0);
	
	#region Nav Bar
		var _tab_separation_x;
		_tab_separation_x = (_x_width/2) / SettingsTab.SIZE;
		_x = (_tab_separation_x * (SettingsTab.SIZE + 1))/2;
		_y = 1859;
		
		var _tab_group_tab_array;
		_tab_group_tab_array = o_ui.settings_tab;
		
		var _nav_bar_tab_btn;
		for(var _i=0;_i<SettingsTab.SIZE;_i++){
			_nav_bar_tab_btn = instance_create_layer(_x,_y,"lyr_menu_bar_front",o_tabBtn_settings_bar);
			_nav_bar_tab_btn.tab = _tab_group_tab_array[_i];
			
			if(_i == _tab_current){
				with(_nav_bar_tab_btn){
					button_toggle_set(true);
				}
			}
			
			_x += _tab_separation_x;
		}
	#endregion
	
	#region Back Button
		_x = 0;
		_y = -100;
		with(instance_create_layer(_x,_y,"lyr_menu",o_txt_btn_back_to_home)){
			transform_parent_anchor_child_id = AnchorTransformChild.bottom_center;
			state_script[UIState.create][UIStateStage.main] = ui_tab_settings_create_main;
		}
	#endregion
#endregion