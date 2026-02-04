#region Input
	//Keyboard Keycodes & Sprites
	input_kb_codes();
	input_kb_sprites();
	
	//Mouse Keycodes & Sprites
	input_mouse_codes();
	input_mouse_sprites();
	
	//Gamepad Keycodes & Sprites
	input_gp_codes();
	input_gp_sprites();
	
	enum Input{
		ai								= 0,
		gamepad							= 1,
		mouse_and_keyboard_and_gamepad	= 2,
		mouse_and_keyboard				= 3,
		mouse							= 4,
		keyboard						= 5,
		remote							= 6,
		remote_ai						= 7,
		
		SIZE
	}

	enum InputProperty{
		key,
		sprite,
	
		SIZE
	}
#endregion

#region Controls
	enum ControlType{
		app		= 0,
		user	= 1,
		
		SIZE
	}
	
	enum AppControl{
		console				= 0,
	
		menu_start			= 1,
		
		pause				= 2,
		pause_continue		= 3,
		pause_stop			= 4,
		pause_mute_music	= 5,
		pause_mute_sfx		= 6,
		
		SIZE
	}
	
	enum UserControl{
		up				= 0,
		down			= 1,
		left			= 2,
		right			= 3,
		jump			= 4,
		dash			= 5,
		attack			= 6,
		interact		= 7,
		interact_equip  = 8,
		float			= 9,
		
		SIZE
	}

	#region App Controls
		var _control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard;
		var _kb_kc_list = global.keyboard_keycode_list;
	
		//Console
		_control = AppControl.console;
		_name = new Text(TextGroup.ui,100);//"CONSOLE"
		_key_gamepad = noone;
		_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"F4");
		sdm("INPUT KEYCODE: " + string(_key_mouse_and_keyboard));
		_key_mouse = noone;
		_key_keyboard = _key_mouse_and_keyboard;
		app_control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
		
		//Menu Start
		_control = AppControl.menu_start;
		_name = new Text(TextGroup.ui,101);//"START"
		_key_gamepad = gp_start;
		_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"Enter");
		_key_mouse = noone;
		_key_keyboard = _key_mouse_and_keyboard;
		app_control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
		
		//Pause
		_control = AppControl.pause;
		_name = new Text(TextGroup.ui,102);//"PAUSE"
		_key_gamepad = gp_start;
		_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"Escape");
		_key_mouse = noone;
		_key_keyboard = _key_mouse_and_keyboard;
		app_control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
		
		//Pause Continue
		_control = AppControl.pause_continue;
		_name = new Text(TextGroup.ui,103);//"PAUSE CONTINUE"
		_key_gamepad = gp_face1;
		_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"Escape");
		_key_mouse = noone;
		_key_keyboard = _key_mouse_and_keyboard;
		app_control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
		
		//Pause Stop
		_control = AppControl.pause_stop;
		_name = new Text(TextGroup.ui,104);//"PAUSE STOP"
		_key_gamepad = gp_face2;
		_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"X");
		_key_mouse = noone;
		_key_keyboard = _key_mouse_and_keyboard;
		app_control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
		
		//Pause Mute Music
		_control = AppControl.pause_mute_music;
		_name = new Text(TextGroup.ui,105);//"PAUSE MUTE MUSIC"
		_key_gamepad = gp_face3;
		_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"M");
		_key_mouse = noone;
		_key_keyboard = _key_mouse_and_keyboard;
		app_control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
		
		//Pause Mute Music
		_control = AppControl.pause_mute_sfx;
		_name = new Text(TextGroup.ui,106);//"PAUSE MUTE SFX"
		_key_gamepad = gp_face3;
		_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"N");
		_key_mouse = noone;
		_key_keyboard = _key_mouse_and_keyboard;
		app_control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
	#endregion
#endregion

#region Users
	#macro USER_NUM_MAX 1
	
	var _user;
	var _name,_joined,_input,_input_device;
	_joined = false;
	_input = Input.mouse_and_keyboard_and_gamepad; //Default to mouse and keyboard and gamepad
	_input_device = -1;
	for(var _i=0;_i<USER_NUM_MAX;_i++){
		_name = "Player " + string(_i);
		_user = new User(_i,_name,_joined,_input,_input_device);
		user[_i] = _user;
	}
	
	//Primary User Joined By Default
	user[0].joined = true;
	
	//Number of Users Who have Joined the Game
	//and are actively part of the current play session
	user_joined_count = 1;
	
	#region User Controls
		var _control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard;
		var _kb_kc_list = global.keyboard_keycode_list;
		var _m_kc_list = global.mouse_keycode_list;
		
		#region 0
			with(user[0]){
				//Up
				_control = UserControl.up;
				_name = new Text(TextGroup.ui,110);//"UP"
				_key_gamepad = gp_padu;
				_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"W");
				_key_mouse = noone;
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
		
				//Down
				_control = UserControl.down;
				_name = new Text(TextGroup.ui,111);//"DOWN"
				_key_gamepad = gp_padu;
				_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"S");
				_key_mouse = noone;
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
		
				//Left
				_control = UserControl.left;
				_name = new Text(TextGroup.ui,112);//"LEFT"
				_key_gamepad = gp_padl;
				_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"A");
				_key_mouse = noone;
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
		
				//Right
				_control = UserControl.right;
				_name = new Text(TextGroup.ui,113);//"RIGHT"
				_key_gamepad = gp_padr;
				_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"D");
				_key_mouse = noone;
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
				
				//Jump
				_control = UserControl.jump;
				_name = new Text(TextGroup.ui,114);//"JUMP"
				_key_gamepad = gp_face1;
				_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"W");
				_key_mouse = noone;
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
				
				//Dash
				_control = UserControl.dash;
				_name = new Text(TextGroup.ui,115);//"DASH"
				_key_gamepad = gp_face2;
				_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"Shift");
				_key_mouse = noone;
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
				
				//Attack
				_control = UserControl.attack;
				_name = new Text(TextGroup.ui,116);//"ATTACK"
				_key_gamepad = gp_shoulderrb;
				_key_mouse_and_keyboard = ds_list_find_index(_m_kc_list,"mb_left");
				_key_mouse = noone
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
				
				//Interact
				_control = UserControl.interact;
				_name = new Text(TextGroup.ui,117);//"INTERACT"
				_key_gamepad = gp_face3;
				_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"E");
				_key_mouse = noone;
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
				
				//Interact Equip
				_control = UserControl.interact_equip;
				_name = new Text(TextGroup.ui,118);//"EQUIP"
				_key_gamepad = gp_face3;
				_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"F");
				_key_mouse = noone;
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
				
				//Float
				_control = UserControl.float;
				_name = new Text(TextGroup.ui,119);//"FLOAT"
				_key_gamepad = gp_padu;
				_key_mouse_and_keyboard = ds_list_find_index(_kb_kc_list,"W");
				_key_mouse = noone;
				_key_keyboard = _key_mouse_and_keyboard;
				control[_control] = new Control(_control,_name,_key_gamepad,_key_mouse_and_keyboard,_key_mouse,_key_keyboard);
			}
		#endregion
	#endregion
#endregion

#region GamePad
	#macro GAMEPAD_ENABLE true
	#macro GAMEPAD_DEVICE_MAX 11
	
	if(GAMEPAD_ENABLE){
		for(var _i=0;_i<GAMEPAD_DEVICE_MAX;_i++){
			gamepad[_i] = new Gamepad();
			gamepad_set_axis_deadzone(_i, 0.2);
		}
		
		#region Using Gamepad
			for(var _i=0;_i<USER_NUM_MAX;_i++){
				with(user[_i]){
					gamepad_using = false;
					gamepad_aim_x = 0;
					gamepad_aim_y = 0;
					gamepad_crosshair = spr_crosshair;
				}
			}
		
			#macro GAMEPAD_DIST_MIN 300
			#macro GAMEPAD_DIST_MAX 600
		#endregion
	}
		
	global.gamepad_device_ui_control = -1;
#endregion

#region Save & Load
	#macro SAVE_FILE_INPUT "input.save"
	//save_map = ds_map_secure_load(SAVE_FILE_INPUT);
	save_map = -1;//load_json(SAVE_FILE_INPUT);
	
	bad_load = false;
	bad_load_string = "Input BAD LOAD: ";
	
	if(save_map == -1 || SAVE_REFRESH || SAVE_REFRESH_SETTINGS){
		save_map = ds_map_create();
		input_save();
	}
	else{
		//input_load();
	}
#endregion

//Remove Sprite
sprite_index = noone;