enum AudioAlarm{
	sfx_sound_list_clear
}

//Master Volume
volume_master = 1;
volume_master_ini = volume_master;

#region Music
	music_snd_id_game = noone;
	music_snd_id_menu = noone;
	
	music_menu = music_main_menu;
	music_menu_skip_intro = true;
	music_game = noone;
#endregion

// Track previous game state so we can handle cross-state audio transitions robustly
prev_game_state = global.game_state;

#region Music - Room Specific Configuration
	// Map to store music tracks for each room (keys are room name strings)
	room_music_map = ds_map_create();
	room_music_loop_start_map = ds_map_create();
	
	// Define music for r_game_level_0
	ds_map_add(room_music_map, "r_game_level_0", music_level_test);
	ds_map_add(room_music_loop_start_map, "r_game_level_0", 3.97);
	
	// Track current room to detect changes
	current_room_for_music = room_get_name(room);
	
	// Variable to store current music's loop point
	music_game_loop_start = 0;
#endregion

#region Channels
	enum AudioChannel{
		music,
		sfx,
		
		SIZE
	}

	enum AudioChannelProperty{
		volume,
		volume_ini,
		sound_list,
		sound_num
	}

	for(var _i=0;_i<AudioChannel.SIZE;_i++){
		channel[_i][AudioChannelProperty.volume] = 1;
		channel[_i][AudioChannelProperty.volume_ini] = 1;
		channel[_i][AudioChannelProperty.sound_list] = ds_list_create();
		channel[_i][AudioChannelProperty.sound_num] = 0;
	}
	
	#macro AUDIO_SOUND_LIST_CLEAR_BATCH_SIZE 10
	sound_list_clear_alarm_time_menu = SECOND * 10;
	sound_list_clear_alarm_time_play = SECOND * 2;
	sound_list_clear_alarm_time = sound_list_clear_alarm_time_menu;
	alarm[AudioAlarm.sfx_sound_list_clear] = sound_list_clear_alarm_time;
#endregion

#region Save & Load
	#macro SAVE_FILE_AUDIO "audio.save"
	//save_map = ds_map_secure_load(SAVE_FILE_AUDIO);
	save_map = load_json(SAVE_FILE_AUDIO);
	epoch_update();
	
	bad_load = false;
	bad_load_string = "Audio BAD LOAD: ";
	
	if(save_map == -1){
		save_map = ds_map_create();
		audio_save();
	}
	else{
		audio_load();
	}
#endregion

//Remove Sprite
sprite_index = noone;