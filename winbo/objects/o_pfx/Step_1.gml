#region GameState Switch
	switch(global.game_state){
		case GameState.menu:
		case GameState.start:
		case GameState.play:
		case GameState.stop:
			//Continue Particle Effects Updates
			if(part_system_auto_update == false){
				part_system_automatic_update(part_system_foreground,true);
				part_system_automatic_update(part_system_midground,true);
				part_system_automatic_update(part_system_background,true);
				part_system_automatic_update(part_system_gui,true);
	
				part_system_auto_update = true;
			}
		break;
	
		case GameState.pause:
			//Pause Particle Effects Updates
			if(part_system_auto_update == true){
				part_system_automatic_update(part_system_foreground,false);
				part_system_automatic_update(part_system_midground,false);
				part_system_automatic_update(part_system_background,false);
	
				part_system_auto_update = false;
			}
		break;
	
		case GameState.freeze:
			//Pause Particle Effects Updates
			if(part_system_auto_update == true){
				part_system_automatic_update(part_system_foreground,false);
				part_system_automatic_update(part_system_midground,false);
				part_system_automatic_update(part_system_background,false);
				part_system_automatic_update(part_system_gui,false);
	
				part_system_auto_update = false;
			}
		break;
	}
#endregion