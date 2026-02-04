#region Debug
	if(dev_mode){
		var _x,_y,_string,_colour;
		#region Draw GameState
			#region GameState Switch
				switch(global.game_state){
					case GameState.boot:
						_string = "BOOT";
					break;
					
					case GameState.intro:
						_string = "INTRO";
					break;
					
					case GameState.loading_app:
						_string = "LOADING APP";
					break;
					
					case GameState.os_paused:
						_string = "OS PAUSED";
					break;
		
					case GameState.menu:
						_string = "MENU";
					break;
					
					case GameState.advert:
						_string = "ADVERT";
					break;
		
					case GameState.start:
						_string = "PLAYSTART";
					break;
					
					case GameState.loading:
						_string = "LOADING";
					break;
		
					case GameState.play:
						_string = "PLAY";
					break;
					
					case GameState.game_menu:
						_string = "GAME MENU";
					break;
		
					case GameState.pause:
						_string = "PAUSE";
					break;
					
					case GameState.cutscene:
						_string = "CUTSCENE";
					break;
					
					case GameState.freeze:
						_string = "FREEZE";
					break;
					
				case GameState.gameover:
					_string = "GAME OVER";
				break;
				
				case GameState.stop:
					_string = "PLAYEND";
				break;
				
				case GameState.level_end_flash:
					_string = "LEVEL END FLASH";
				break;
				
				case GameState.level_end_celebration:
					_string = "LEVEL END CELEBRATION";
				break;
				
			case GameState.level_results:
				_string = "LEVEL RESULTS";
			break;
			
			case GameState.level_end_fade:
				_string = "LEVEL END FADE";
			break;

			case GameState.close:
					_string = "CLOSE";
				break;
				
				default:
					_string = "UNDEFINED GAME STATE";
				break;
				}
			#endregion
		
			_x = 5;
			_y = 50;
			_colour = c_white;
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			draw_set_font(fnt_bahnschrift_32);
			draw_text_color(_x,_y,_string,_colour,_colour,_colour,_colour,1);
		#endregion
	}
#endregion