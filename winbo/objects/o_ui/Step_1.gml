#region GameState Switch
	switch(global.game_state){
		case GameState.boot:
		case GameState.intro:
		break;
		
		case GameState.loading_app:
			////Create Persistent UI if it Doesn't Exist
			//if(instance_number(o_anchor_persistent) == 0){
			//	//Add Persistent UI
			//	ui_anchor_create(o_anchor_persistent,"lyr_menu");
			//}
		break;
		
		case GameState.menu:
			ui_mouse_interaction();
			
			#region Create the Menu if it Doesn't Exist
				if(ui_reset_menu_active){
					if(ds_list_size(ui_group_list[UIGroup.menu]) <= 0){
						ui_reset_menu_active = false;
					}
				}
				else if(instance_number(o_anchor_menu) == 0){
					//Add Menu
					ui_anchor_create(o_anchor_menu,"lyr_menu");
				}
			#endregion
			
			//Create Persistent UI if it Doesn't Exist
			if(instance_number(o_anchor_persistent) == 0){
				//Add Persistent UI
				ui_anchor_create(o_anchor_persistent,"lyr_menu");
			}
		break;
		
		case GameState.advert:
			//Mouse & Touch Interaction
			ui_mouse_interaction();
			
			//Add Advert
			if(o_master.advert_active)
				ui_anchor_create(o_anchor_advert,"lyr_advert");
		break;
	
		case GameState.start:
			//Remove Menu
			ui_anchor_remove(o_anchor_menu);
			
			//Remove Bars
			ui_bars_hide(o_bar_menu);
			
			//Remove Pause
			ui_anchor_remove(o_anchor_pause);
			
			//Add HUD
			ui_anchor_create(o_anchor_hud,"lyr_hud");
			
			//Add Game
			ui_anchor_create(o_anchor_game,"lyr_pfx_midground");
		break;
		
		case GameState.play:
			ui_game_state_play();
			
			//No HUD
			if(instance_number(o_anchor_hud) <= 0){
				//Add HUD
				ui_anchor_create(o_anchor_hud,"lyr_hud");
			}
			
			//No Game Anchor
			if(instance_number(o_anchor_game) <= 0){
				//Add Game Anchor
				ui_anchor_create(o_anchor_game,"lyr_pfx_midground");
			}
			
			//Remove Dialogue
			ui_anchor_remove(o_anchor_dialogue);
		break;
		
		case GameState.dialogue:
			ui_game_state_play();
			
			//No Dialogue
			if(instance_number(o_anchor_dialogue) <= 0){
				//Add Dialogue
				ui_anchor_create(o_anchor_dialogue,"lyr_hud");
			}
			
			//TODO - replace when dialouge system is finished
			if(mouse_check_button_pressed(mb_any)){
				//Go back to play gamestate
				game_state_set_target(GameState.play);
				
				//Remove Dialogue
				ui_anchor_remove(o_anchor_dialogue);
			}
		break;
		
		case GameState.gameover:
			//Add Gameover
			ui_anchor_create(o_anchor_gameover,"lyr_hud");
			
			//Remove Pause
			ui_anchor_remove(o_anchor_pause);
			
			//Remove HUD
			ui_anchor_remove(o_anchor_hud);
			
			//Remove Game
			ui_anchor_remove(o_anchor_game);
		break;
	
		case GameState.stop:
			//Add Menu
			ui_anchor_create(o_anchor_menu,"lyr_menu");
			
			//Remove Pause
			ui_anchor_remove(o_anchor_pause);
			
			//Remove HUD
			ui_anchor_remove(o_anchor_hud);
			
			//Remove Game
			ui_anchor_remove(o_anchor_game);
		break;
	
		case GameState.pause:
			ui_game_state_pause();
		break;
	
		case GameState.level_end_flash:
			// Remove HUD during flash
			ui_anchor_remove(o_anchor_hud);
		break;
	
		case GameState.level_end_celebration:
			// Keep HUD removed, don't add anything yet
		break;
	
		case GameState.level_results:
			// Create results anchor if it doesn't exist
			if(instance_number(o_anchor_results) <= 0){
				ui_anchor_create(o_anchor_results, "lyr_hud");
			}
		break;
	
		case GameState.level_end_fade:
			// Remove results anchor during fade
			ui_anchor_remove(o_anchor_results);
		break;
	}
#endregion

#region HUD Toggle
	if(keyboard_check_pressed(vk_f5)){
		hud_enable = !hud_enable;
	}
#endregion