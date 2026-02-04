function info_bar_system_create(){
	//Disabled by Default
	info_bar_enable = false;
	
	//Scale
	info_bar_scale = 0;
	info_bar_scale_target = 0;
	
	//Position
	info_bar_y_relative_to_bbox_top = -100;
	
	//Define Necessary Bark Poster Variable
	if(!variable_instance_exists(id,"dialogue_bark_text_poster")){
		dialogue_bark_text_poster = noone;
	}
	
	//Sections
	for(var _i=0;_i<InfoBarSection.SIZE;_i++){
		info_bar_section_enable[_i] = false;
		info_bar_section_scale[_i] = 1;
		info_bar_section_width[_i] = 50;
		info_bar_section_height[_i] = 50;
	}
	
	var _section;
	
	#region HP
		_section = InfoBarSection.hp_bar;
		
		info_bar_section_height[_section] = 10;
	
		info_bar_hp_health_boost_scale = 1;
		info_bar_hp_health_boost_scale_target = 1;
		info_bar_hp_percent_previous = 1;
		
		info_bar_hp_layers = 1;
		info_bar_hp_layer_colours[0] = c_flat_red_monza;
		info_bar_hp_layer_colours[1] = c_flat_red_monza;
		info_bar_hp_layer_colours[2] = c_flat_red_monza;
		info_bar_hp_layer_colours[3] = c_flat_red_monza;
	#endregion
	
	#region Ammo
		_section = InfoBarSection.ammo;
		
		info_bar_section_width[_section] = INFO_BAR_SECTION_DIMENSION_MIMIC_DOWN;
		info_bar_section_height[_section] = 20;
	
		info_bar_ammo_percent_previous = 1;
		info_bar_ammo_colour = c_flat_yellow_ripe_lemon;
		info_bar_ammo_depletion_recovery_draw_enable = false;
		info_bar_ammo_depletion_recovery_draw_percentage = 0;
		info_bar_ammo_depletion_recovery_draw_scale = 0;
	#endregion
	
	#region Status Effects
		_section = InfoBarSection.status_effects;
		
		//Dimensions
		info_bar_section_height[_section] = 100;
	#endregion
	
	#region Names
		//Name
		_section = InfoBarSection.name;
		info_bar_section_enable[_section] = true;
		info_bar_section_height[_section] = 50;
		
		//Character Name
		_section = InfoBarSection.character_name;
		info_bar_section_enable[_section] = true;
		info_bar_section_height[_section] = 30;
	#endregion
	
	#region Objective
		_section = InfoBarSection.objective;
		
		info_bar_section_height[_section] = 50;
	#endregion
	
	#region Alert
		_section = InfoBarSection.alert;
		
		info_bar_section_height[_section] = 50;
	#endregion
	
	#region Interaction
		_section = InfoBarSection.interaction_available;
		
		info_bar_section_height[_section] = 50;
	#endregion
	
	#region Dialogue
		_section = InfoBarSection.dialogue_available_bark;
		info_bar_section_height[_section] = 50;
		
		_section = InfoBarSection.dialogue_available_conversation;
		info_bar_section_height[_section] = 50;
	#endregion
}

enum InfoBarSection{
	hp_bar,
	ammo,
	status_effects,
	attachments,
	name,
	character_name,
	objective,
	alert,
	interaction_available,
	dialogue_available_bark,
	dialogue_available_conversation,
	
	SIZE
}

#macro INFO_BAR_SECTION_DIMENSION_MIMIC_UP -1
#macro INFO_BAR_SECTION_DIMENSION_MIMIC_DOWN -2