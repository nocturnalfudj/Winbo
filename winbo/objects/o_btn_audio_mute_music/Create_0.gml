// Inherit the parent event
event_inherited();

//Toggle
toggle_enable = true;
button_toggle_set(false);

//Audio
channel = AudioChannel.music;

#region Image
	toggle_sprite_false = spr_btn_audio_mute_music_off;
	toggle_sprite_true = spr_btn_audio_mute_music_on;
	sprite_current = (toggle)? toggle_sprite_true : toggle_sprite_false;
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_audio_create_main;
	
	state_script[UIState.idle][UIStateStage.main] = btn_audio_mute_channel_idle_main;
	
	state_script[UIState.active][UIStateStage.main] = btn_audio_mute_channel_active_main;
#endregion