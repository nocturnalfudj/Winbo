// Inherit the parent event
event_inherited();

//Title System
title_system_create();
title_enable = true;
title_text = noone;
title_string = "DISPLAY STRING";
title_font = fnt_default_52;
title_colour = c_white;
title_halign = fa_center;
title_valign = fa_middle;
title_x = 0;
title_y = -100;
title_shadow_enable = true;
title_shadow_colour = c_black;
title_shadow_x = -4;
title_shadow_y = 4;

//Lighting
lighting_light_create_track(spr_light_circular,c_white,"lyr_lighting",2,2,0,0,0,1);