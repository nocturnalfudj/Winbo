//Do Not Run this Event in Boot/Intro/Loading Rooms
//as the correct layers do not exist
if((room == r_boot) || (room == r_intro) || (room == r_loading_app))
	exit;
	
//Move Part Systems to Correct Layers
part_system_layer(part_system_foreground,"lyr_pfx_foreground");
part_system_layer(part_system_midground,"lyr_pfx_midground");
part_system_layer(part_system_background,"lyr_pfx_background");
part_system_layer(part_system_gui,"lyr_pfx_gui");