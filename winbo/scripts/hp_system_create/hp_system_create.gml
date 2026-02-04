/// @function hp_system_create
/// @summary Initialise the health system variables.
function hp_system_create(){
	//Disabled by Default
	hp_enable = false;
	
	//Overhealth
	hp_overhealth_enable = false;
	hp_overhealth = 0;
	hp_overhealth_decay_rate = 1;
	hp_overhealth_decay_countdown_max = SECOND / 1;
	hp_overhealth_decay_countdown = hp_overhealth_decay_countdown_max;
	
	hp = 30;
	hp_set_max(hp);
	hp_max_default = hp_max;
	hp_previous = hp;
	
	hp_percent = hp/hp_max;
	
	hp_regen_rate =  2;
	hp_regen_remaining = 0;
	hp_regen_countdown_max = SECOND / 10;							//Regen applied 10 times a second by default
	hp_regen_countdown = hp_regen_countdown_max;
	
	hp_decay_rate =  1;
	hp_decay_remaining = 0;
	hp_decay_countdown_max = SECOND / 5;							//Decay applied 5 times a second by default
	hp_decay_countdown = hp_decay_countdown_max;
	hp_decay_limit = 0;
	
	hp_regen_passive_enable = false;
	hp_regen_passive_rate =  1;
	hp_regen_passive_max = hp_max;
	hp_regen_passive_countdown_max = SECOND / 10;					//Passive Regen applied 10 times a second by default
	hp_regen_passive_countdown = hp_regen_passive_countdown_max;
	
	hp_decay_passive_enable = false;
	hp_decay_passive_rate =  1;
	hp_decay_passive_min = 0;
	hp_decay_passive_countdown_max = SECOND / 5;					//Passive Decay applied 5 times a second by default
	hp_decay_passive_countdown = hp_decay_passive_countdown_max;
	
	hp_vulnerable = true;
	
	//Text Posters
	hp_text_poster_enable_heal = true;
	hp_text_poster_enable_damage = true;

	//Bar
	hp_bar_health_boost_scale = 1;
	hp_bar_health_boost_scale_target = 1;
	hp_bar_percent_previous = hp_percent;
	hp_bar_width = 10;
	hp_bar_length = floor(hp / 30);
	hp_bar_y_relative_to_bbox_top = -100;
	hp_bar_layers = 1;
	
	hp_bar_layer_colours[0] = c_flat_red_monza;
	hp_bar_layer_colours[1] = c_flat_red_monza;
	hp_bar_layer_colours[2] = c_flat_red_monza;
	hp_bar_layer_colours[3] = c_flat_red_monza;
	
	//States
	hp_state_count = 2;	//Default is just Alive or Dead
						//States progress from full health to zero health
						//State 0 = 100% health
						//State 1 = 0% health
	
	//If HP is above this trigger, state is activated
	//Lower states will take activation priority
	//For example if HP is 50, it is above both state trigger 0 and 1, but only state 0 will be activated as it is the lower state
	hp_state_trigger[0] = 0;
	hp_state_trigger[1] = -1;
	
	hp_state_update();
}