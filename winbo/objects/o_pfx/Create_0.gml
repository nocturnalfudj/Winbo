#region Particle Effects
	enum PFXSetting{
		off		= 0,
		low		= 1,
		medium	= 2,
		high	= 3,
		
		SIZE
	}
	
	pfx_setting = PFXSetting.high;
	
	enum PFXProperty{
		system,
		type,
		
		gui,
		
		emitter,
		emitter_relative_x,
		emitter_relative_y,
		emitter_width_half,
		emitter_height_half,
		emitter_shape,
		emitter_distribution,
		emitter_region_script,
		
		burst_num,
		burst_script,
		burst_active
	}

	//Particle Systems
	part_system_foreground = part_system_create();
	part_system_midground = part_system_create();
	part_system_background = part_system_create();
	part_system_gui = part_system_create();

	part_system_auto_update = true;
	
	part_system_automatic_draw(part_system_gui,false);
	
	//Create Particle Effect System
	pfx_system_create();
	
	#region Effects
		#region Example
			//enum PFXExample{
			//	example,
			//	SIZE
			//}
			
			//pfx_example_emitter_width_half = 100;
			
			//pfx_type_example = pfx_type_create_example();
			
			//pfx_example_how_to_setup;
		#endregion
	#endregion
#endregion

#region Save & Load
	#macro SAVE_FILE_PFX "pfx.save"
	//save_map = ds_map_secure_load(SAVE_FILE_PFX);
	save_map = load_json(SAVE_FILE_PFX);
	epoch_update();
	
	bad_load = false;
	bad_load_string = "PFX BAD LOAD: ";
	
	if(save_map == -1 || SAVE_REFRESH || SAVE_REFRESH_SETTINGS){
		save_map = ds_map_create();
		//pfx_save();
	}
	else{
		//pfx_load();
	}
#endregion