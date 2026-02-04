// Inherit the parent event
event_inherited();

#region Image
	sprite_idle				= spr_enemy_melee_test_idle;
	sprite_attack_telegraph	= spr_enemy_melee_test_attack_telegraph;
	sprite_attack_active	= spr_enemy_melee_test_attack_active;
	sprite_attack_recover	= spr_enemy_melee_test_attack_recover;
	
	//Idle Sprite
	image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);
#endregion