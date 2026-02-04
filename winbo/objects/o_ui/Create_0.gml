#region GUI
	gui_scale = 1;
	gui_scale_inverse = 1/gui_scale;

	gui_width = display_get_gui_width();
	gui_height = display_get_gui_height();

	#region Mouse
		#macro MOUSE_INPUT_COUNT 1
		#macro android:MOUSE_INPUT_COUNT 2
		#macro ios:MOUSE_INPUT_COUNT 2
		
		for(var _i=0;_i<MOUSE_INPUT_COUNT;_i++){
			var _x_gui,_y_gui,_x_gui_inv,_y_gui_inv;
			_x_gui = device_mouse_x_to_gui(_i);
			_y_gui = device_mouse_y_to_gui(_i);
			_x_gui_inv = _x_gui*gui_scale_inverse;
			_y_gui_inv = _y_gui*gui_scale_inverse;
		
			mouse_gui[_i] = new Vector2(_x_gui,_y_gui);
			mouse_gui_scale_inverted[_i] = new Vector2(_x_gui_inv,_y_gui_inv);
		
			mouse_active[_i] = false;
		
			var _pressed,_down,_released;
			_pressed = device_mouse_check_button_pressed(_i,mb_any);
			_released = device_mouse_check_button_released(_i,mb_any);
			_down = device_mouse_check_button(_i,mb_any);
	
			if(_down || _pressed || _released)
				mouse_active[_i] = true;
		}
		
		mouse_collision_list = ds_list_create();
		
		mouse_collision_any = false;
	#endregion
#endregion

#region Groups
	#region UI Groups
		enum UIGroup{
			persistent,
			
			menu,
			
			tab_credits,
			tab_shop,
			tab_home,
			tab_scores,
			tab_friends,
			tab_settings,
			tab_level_select,
			
			tab_settings_game,
			tab_settings_display,
			tab_settings_audio,
			tab_settings_input,
			tab_settings_language,
			
			advert,
			
			profile,
	
			hud,
			
			results,
			
			dialogue,
			
			pause,
	
			game,
			interact_system,
			
			cutscene,
			
			gameover,
	
			SIZE
		}

		for(var _i=0;_i<UIGroup.SIZE;_i++){
			ui_group_list[_i] = ds_list_create();
		}
	#endregion
	
	#region Button Toggle Groups
		enum ButtonToggleGroup{
			language,
			navigation_bar,
			settings_bar,
			
			SIZE
		}
	#endregion
	
	#region Slider Groups
		enum SliderGroup{
			SIZE
		}
	#endregion
#endregion

#region Tabs
	//Set Up Groups
	enum TabGroup{
		menu,
		settings,
		
		SIZE
	}
	
	//Setup Tab Current for Each Group
	for(var _i=0;_i<TabGroup.SIZE;_i++){
		tab_current[_i] = noone;
	}
	
	//Tab Variables
	var _position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab;
	
	#region Menu
		enum MenuTab{
			credits,
			shop,
			home,
			scores,
			friends,
			settings,
			level_select,
		
			SIZE
		}
		
		//Set Starting Tab
		tab_current[TabGroup.menu] = MenuTab.home;
		
		//Menu Start with Default Tab Toggle
		menu_create_default_tab = true;
		
		_layer = "lyr_menu";
		_tab_group = TabGroup.menu;
		_entrance_script = tab_entrance_horizontal;
		_exit_script = tab_exit_horizontal;
		_remove_other_tab_group_tab = false;
		_parent_tab = noone;
	
		#region Tabs
			//Credits
			_position = MenuTab.credits;
			_object = o_tab_credits;
			_ui_group = UIGroup.tab_credits;
			_sprite = spr_tabBtn_ags;
			menu_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
	
			//Shop
			_position = MenuTab.shop;
			_object = o_tab_shop;
			_ui_group = UIGroup.tab_shop;
			_sprite = spr_tabBtn_shop;
			menu_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
	
			//Home
			_position = MenuTab.home;
			_object = o_tab_home;
			_ui_group = UIGroup.tab_home;
			_sprite = spr_tabBtn_home;
			menu_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
	
			//Scores
			_position = MenuTab.scores;
			_object = o_tab_scores;
			_ui_group = UIGroup.tab_scores;
			_sprite = spr_tabBtn_scores;
			menu_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
	
			//Friends
			_position = MenuTab.friends;
			_object = o_tab_friends;
			_ui_group = UIGroup.tab_friends;
			_sprite = spr_tabBtn_friends;
			menu_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
		
			//Settings
			_position = MenuTab.settings;
			_object = o_tab_settings;
			_ui_group = UIGroup.tab_settings;
			_sprite = spr_tabBtn_settings;
			menu_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
		
			//Level Select
			_position = MenuTab.level_select;
			_object = o_tab_level_select;
			_ui_group = UIGroup.tab_level_select;
			_sprite = noone;
			menu_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
		#endregion
	#endregion
	
	#region Settings
		enum SettingsTab{
			game,
			display,
			audio,
			input,
			language,
		
			SIZE
		}
		
		//Set Starting Tab
		tab_current[TabGroup.settings] = SettingsTab.input;
		
		_layer = "lyr_menu";
		_tab_group = TabGroup.settings;
		_entrance_script = tab_entrance_horizontal;
		_exit_script = tab_exit_horizontal;
		_remove_other_tab_group_tab = false;
		_parent_tab = menu_tab[MenuTab.settings];
	
		#region Tabs
			//Game
			_position = SettingsTab.game;
			_object = o_tab_settings_game;
			_ui_group = UIGroup.tab_settings_game;
			_sprite = spr_tabBtn_settings_game;
			settings_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
			
			//Display
			_position = SettingsTab.display;
			_object = o_tab_settings_display;
			_ui_group = UIGroup.tab_settings_display;
			_sprite = spr_tabBtn_settings_display;
			settings_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
			
			//Audio
			_position = SettingsTab.audio;
			_object = o_tab_settings_audio;
			_ui_group = UIGroup.tab_settings_audio;
			_sprite = spr_tabBtn_settings_audio;
			settings_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
			
			//Input
			_position = SettingsTab.input;
			_object = o_tab_settings_input;
			_ui_group = UIGroup.tab_settings_input;
			_sprite = spr_tabBtn_settings_input;
			settings_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
			
			//Language
			_position = SettingsTab.language;
			_object = o_tab_settings_language;
			_ui_group = UIGroup.tab_settings_language;
			_sprite = spr_tabBtn_settings_language;
			settings_tab[_position] = new Tab(_position,_object,_layer,_tab_group,_ui_group,_sprite,_entrance_script,_exit_script,_remove_other_tab_group_tab,_parent_tab);
		#endregion
	#endregion
#endregion

#region HUD
	hud_enable = true;
#endregion

#region Game Text Posters
	game_text_poster_damage_enable = true;
	game_text_poster_heal_enable = true;
#endregion

#region Info Bars
	info_bar_show_name = true;
	info_bar_show_health = true;
	info_bar_show_effects = true;
#endregion

#region UI Reset
	ui_reset_menu_active = false;
#endregion

//Screenshot Pause
os_paused_pause = false;

#region Debug Overlay
	if(DEBUG_OVERLAY_ENABLE){
		var _reference;
	
		//View
		dbg_view("UI",false);
	
		#region Settings
			dbg_section("Settings",false);
			
			//Image Title
			dbg_text("HUD");
			
			_reference = ref_create(self,"hud_enable");
			dbg_checkbox(_reference,"HUD Enable");
			
			////Image Title
			//dbg_text("Game Text Posters");
			
			//_reference = ref_create(self,"game_text_poster_damage_enable");
			//dbg_checkbox(_reference,"Enable Damage Text");
			
			//_reference = ref_create(self,"game_text_poster_heal_enable");
			//dbg_checkbox(_reference,"Enable Heal Text");
			
			////Image Title
			//dbg_text("Info Bar");
			
			//_reference = ref_create(self,"info_bar_show_name");
			//dbg_checkbox(_reference,"Show Target Name");
			
			//_reference = ref_create(self,"info_bar_show_health");
			//dbg_checkbox(_reference,"Show Target Health");
			
			//_reference = ref_create(self,"info_bar_show_effects");
			//dbg_checkbox(_reference,"Show Target Effects");
		#endregion
	}
#endregion

#region Save & Load
	#macro SAVE_FILE_UI "ui.save"
	//save_map = ds_map_secure_load(SAVE_FILE_UI);
	save_map = load_json(SAVE_FILE_UI);
	epoch_update();
	
	bad_load = false;
	bad_load_string = "UI BAD LOAD: ";
	
	if(save_map == -1 || SAVE_REFRESH || SAVE_REFRESH_SETTINGS){
		save_map = ds_map_create();
		//ui_save();
	}
	else{
		//ui_load();
	}
	
	#macro UI_SAVE_NOTIFICATION_STRING "notification_"
#endregion