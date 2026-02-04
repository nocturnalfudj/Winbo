// Inherit the parent event
event_inherited();

//UI Group
ui_group_set(UIGroup.menu,id);

#region Transform
	var _transform;
	_transform = transform[TransformType.anchor];
	
	//Set Coords to 0,0
	transform_set(_transform,TransformValue.x,0,false);
	transform_set(_transform,TransformValue.y,0,false);
	transform_set_rest(_transform,TransformValue.x,0,false);
	transform_set_rest(_transform,TransformValue.y,0,false);
	
	//Appear
	var _time_current,_time_max,_curve,_target;
	_time_current = -0.2*SECOND;
	_time_max = 0.6*SECOND;
	_curve = ease_back_out;
	_target = 1;
	transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
	transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
	transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
	
	//Transform Update
	transform_system_update();
#endregion

#region Menu Creation
	var _x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
	
	//Get Current Tab for Menu
	var _current_tab;
	with(o_ui){
		if(menu_create_default_tab){
			_current_tab = MenuTab.home;
		}
		else{
			_current_tab = tab_current[TabGroup.menu];
			
			//Turn Default Tab Back to True
			menu_create_default_tab = true;
		}
	}
	
	////Logo
	//_x = 230;
	//_y = 63;
	//with(instance_create_layer(_x,_y,"lyr_menu_bar_front",o_pstr_logo)){
	//	transform_parent_anchor_child_id = AnchorTransformChild.top_left;
	//}
	
	////Version
	//_x = 550;
	//_y = 63;
	//with(instance_create_layer(_x,_y,"lyr_menu_bar_front",o_txtPstr_version)){
	//	transform_parent_anchor_child_id = AnchorTransformChild.top_left;
	//}
	
	//#region Nav Bar
	//	var _tab_separation_x;
	//	_tab_separation_x = 300;
	//	_x = - (_tab_separation_x * (MenuTab.SIZE-1))/2;
	//	
	//	_y = -500;
	//	
	//	var _menu_tab;
	//	_menu_tab = o_ui.menu_tab;
	//	
	//	var _nav_bar_tab_btn;
	//	for(var _i=0;_i<MenuTab.SIZE;_i++){
	//		_nav_bar_tab_btn = instance_create_layer(_x,_y,"lyr_menu_bar_front",o_tabBtn_navigation_bar);
	//		_nav_bar_tab_btn.tab = _menu_tab[_i];
	//		_nav_bar_tab_btn.transform_parent_anchor_child_id = AnchorTransformChild.bottom_center;
	//		
	//		if(_i == _current_tab){
	//			with(_nav_bar_tab_btn){
	//				button_toggle_set(true);
	//			}
	//		}
	//		
	//		_x += _tab_separation_x;
	//	}
	//#endregion
	
	#region Bars
		//var _shadow_bar;
		
		////Top
		//_x = 0;
		//_y = 0;
		//_shadow_bar = instance_create_layer(_x,_y,"lyr_menu_bar",o_bar_menu);
		//_shadow_bar.bar_direction = BarDirection.up;
		
		////Bottom
		//_x = 0;
		//_y = 0;
		//_shadow_bar = instance_create_layer(_x,_y,"lyr_menu_bar",o_bar_menu);
		//_shadow_bar.bar_direction = BarDirection.down;
	#endregion
	
	//Current Menu Tab
	tab_create(o_ui.menu_tab[_current_tab],0);
#endregion

#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = anchor_menu_destroy_main;
#endregion