// Inherit the parent event
event_inherited();

//Checkpoint
checkpoint_active = false;

enum CheckPointColour{
	green,
	purple,
	cyan
}
var _colour;
_colour = choose(CheckPointColour.green,CheckPointColour.purple,CheckPointColour.cyan);
switch(_colour){
	case CheckPointColour.green:
		sprite_idle = spr_checkpoint_idle_green;
		sprite_jump = spr_checkpoint_jump_green;
	break;
	
	case CheckPointColour.purple:
		sprite_idle = spr_checkpoint_idle_purple;
		sprite_jump = spr_checkpoint_jump_purple;
	break;
	
	case CheckPointColour.cyan:
		sprite_idle = spr_checkpoint_idle_cyan;
		sprite_jump = spr_checkpoint_jump_cyan;
	break;
}

image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);