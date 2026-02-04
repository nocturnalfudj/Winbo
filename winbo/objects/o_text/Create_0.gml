language_current = "eng-uk";
language_new = "";
language_swap = false;

#region Enums
	enum TextGroup{
		ui			= 0,
		//dialogue	= 1,
	
		SIZE
	}

	enum TextRow{
		language,
		author,
		version,
		date,
		name
	}
#endregion

#macro TEXT_CURRENT 1
#macro TEXT_DEFAULT 2

//Text Grids
text_grid_create_group(TextGroup.ui,"language/text/ui",text_group_default_ui);
//text_grid_create_group(TextGroup.dialogue,"language/text/dialogue",text_group_default_dialogue);

//Text Lists
for(var _i=0;_i<TextGroup.SIZE;_i++){
	text_list[_i] = ds_list_create();
}

#region Save & Load
	#macro SAVE_FILE_TEXT "text.save"
	//save_map = ds_map_secure_load(SAVE_FILE_TEXT);
	save_map = load_json(SAVE_FILE_TEXT);
	epoch_update();
	
	bad_load = false;
	bad_load_string = "Text BAD LOAD: ";
	
	if(save_map == -1 || SAVE_REFRESH || SAVE_REFRESH_SETTINGS){
		save_map = ds_map_create();
		text_save();
	}
	else{
		text_load();
	}
#endregion