event_inherited();

sprite_current = spr_breakable_wall_molten;
sprite_idle = spr_breakable_wall_molten;
sprite_break = spr_breakable_wall_molten_break;
sprite_index = sprite_idle;
image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
