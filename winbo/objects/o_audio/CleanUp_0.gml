//Delete Channel Sound Lists
var _lst;
for(var _i=0;_i<AudioChannel.SIZE;_i++){
	_lst = channel[_i][AudioChannelProperty.sound_list];
	if(ds_exists(_lst,ds_type_list)){
		ds_list_destroy(_lst);
		if(DEBUG_CLEANUP) sdm("Sound list destroyed id : " + string(_lst));
	}
}

#region Save
	var _map;
	_map = save_map;
	if(ds_exists(_map,ds_type_map)){
		ds_map_destroy(_map);
	}	
#endregion

// Clean up room music maps
ds_map_destroy(room_music_map);
ds_map_destroy(room_music_loop_start_map);