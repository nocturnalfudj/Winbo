event_inherited();

sprite_current = spr_breakable_wall_molten;
sprite_idle = spr_breakable_wall_molten;
sprite_break = sprite_idle;
sprite_index = sprite_idle;
break_fx_enable = true;
break_fx_sprite = sprite_idle;
break_fx_smoke_sprite = spr_breakable_wall_smoke;
break_fx_columns = 4;
break_fx_rows = 3;
image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
