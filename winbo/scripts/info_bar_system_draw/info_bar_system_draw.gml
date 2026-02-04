/// @function info_bar_system_draw
/// @summary Draw the on-screen information bar if enabled.
function info_bar_system_draw(){
	if((info_bar_enable) && (info_bar_scale > 0)){
		var _x,_y;
		var _bar_scale,_bar_height,_bar_width,_bar_x1,_bar_x2,_bar_y1,_bar_y2;
		var _section_scale,_section_x,_section_y,_section_height,_section_width;
		_section_x = x;
		_section_y = bbox_top + info_bar_y_relative_to_bbox_top * info_bar_scale;

		//Adjust for Bark Text Posters
		//TODO - also adjust for other dialogue text posters
		with(dialogue_bark_text_poster){
			_section_y -= height/2;
		}

		//Go Through Sections
		for(var _i=0;_i<InfoBarSection.SIZE;_i++){
			//Skip if Not Enabled
			if(!info_bar_section_enable[_i])
				continue;

			//Get Section Scale
			_section_scale = info_bar_section_scale[_i] * info_bar_scale;

			//Skip if No Scale
			if(_section_scale <= 0)
				continue;

			#region Get Section Dimensions
				//Height
				_section_height = info_bar_section_height[_i] * _section_scale;
				if(info_bar_section_height[_i] == INFO_BAR_SECTION_DIMENSION_MIMIC_DOWN){
					if(_i != 0){
						_section_height = info_bar_section_height[_i-1] * _section_scale;
					}
				}
				else if(info_bar_section_height[_i] == INFO_BAR_SECTION_DIMENSION_MIMIC_UP){
					if(_i != InfoBarSection.SIZE - 1){
						_section_height = info_bar_section_height[_i+1] * _section_scale;
					}
				}

				//Width
				_section_width = info_bar_section_width[_i] * _section_scale;
				if(info_bar_section_width[_i] == INFO_BAR_SECTION_DIMENSION_MIMIC_DOWN){
					if(_i != 0){
						_section_width = info_bar_section_width[_i-1] * _section_scale;
					}
				}
				else if(info_bar_section_width[_i] == INFO_BAR_SECTION_DIMENSION_MIMIC_UP){
					if(_i != InfoBarSection.SIZE - 1){
						_section_width = info_bar_section_width[_i+1] * _section_scale;
					}
				}
			#endregion

			//Adjust Position
			_section_x = _section_x;
			_section_y = _section_y - _section_height/2;

			//Handle Sections
			switch(_i){
				case InfoBarSection.hp_bar:
					#region HP Bar
						//Set Bar Scale
						_bar_scale = _section_scale * info_bar_hp_health_boost_scale;

						var _bar_height,_bar_width,_bar_x1,_bar_x2,_bar_y1,_bar_y2;
						_bar_height = _section_height * _bar_scale;
						_bar_width = _section_width * _bar_scale;
						_bar_x1 = _section_x - _bar_width/2;
						_bar_x2 = _section_x + _bar_width/2;
						_bar_y1 = _section_y - _bar_height/2;
						_bar_y2 = _section_y + _bar_height/2;

						if (hp_vulnerable && o_ui.info_bar_show_health) {
							//--------------------------------------------------------
							// 1) Basic setup and clamp HP
							//--------------------------------------------------------
							var _layers = max(info_bar_hp_layers, 1);
							var _segment_fraction = 1 / _layers;

							var _current_fraction = clamp(hp_percent, 0, 1);
							var _prev_fraction = clamp(info_bar_hp_percent_previous, 0, 1);

							//--------------------------------------------------------
							// 2) Which layer is CURRENT HP in? => for background color
							//--------------------------------------------------------
							var _layerIndex_current = floor(_current_fraction / _segment_fraction);
							if (_layerIndex_current >= _layers) _layerIndex_current = _layers - 1;
							if (_layerIndex_current < 0) _layerIndex_current = 0;

							// If we're in layer 0, background = black.
							// Otherwise, use color of layer beneath.
							var _background_colour;
							if (_layerIndex_current == 0) {
								_background_colour = c_black;
							} else {
								var _beneath_index = _layerIndex_current - 1;
								if (_beneath_index < 0) _beneath_index = 0;
								var _beneath_colour_index = _beneath_index mod array_length(info_bar_hp_layer_colours);
								_background_colour = info_bar_hp_layer_colours[_beneath_colour_index];
							}

							//--------------------------------------------------------
							// 3) Draw BACKGROUND (Rectangle #1, full bar width)
							//--------------------------------------------------------
							draw_set_color(_background_colour);
							draw_set_alpha(_bar_scale);
							draw_rectangle(_bar_x1, _bar_y1, _bar_x2, _bar_y2, false);

							//--------------------------------------------------------
							// 4) WHITE "Previous HP" (Rectangle #2)
							//--------------------------------------------------------
							var _layerIndex_prev = floor(_prev_fraction / _segment_fraction);
							if (_layerIndex_prev >= _layers) _layerIndex_prev = _layers - 1;
							if (_layerIndex_prev < 0) _layerIndex_prev = 0;

							var _layer_start_prev = _layerIndex_prev * _segment_fraction;
							var _layer_end_prev = (_layerIndex_prev + 1) * _segment_fraction;
							var _fill_prev = clamp((_prev_fraction - _layer_start_prev) / (_layer_end_prev - _layer_start_prev), 0, 1);

							if (_fill_prev > 0) {
								var _prev_x2 = _bar_x1 + (_fill_prev * _bar_width);
								draw_set_color(c_white);
								draw_set_alpha(_bar_scale);
								draw_rectangle(_bar_x1, _bar_y1, _prev_x2, _bar_y2, false);
							}

							//--------------------------------------------------------
							// 5) CURRENT HP (Rectangle #3)
							//--------------------------------------------------------
							var _layer_start_cur = _layerIndex_current * _segment_fraction;
							var _layer_end_cur = (_layerIndex_current + 1) * _segment_fraction;
							var _fill_cur = clamp((_current_fraction - _layer_start_cur) / (_layer_end_cur - _layer_start_cur), 0, 1);

							if (_fill_cur > 0) {
								var _colour_index = _layerIndex_current mod array_length(info_bar_hp_layer_colours);
								var _cur_x2 = _bar_x1 + (_fill_cur * _bar_width);
								draw_set_color(info_bar_hp_layer_colours[_colour_index]);
								draw_set_alpha(_bar_scale);
								draw_rectangle(_bar_x1, _bar_y1, _cur_x2, _bar_y2, false);
							}
						}
					#endregion
				break;

				case InfoBarSection.ammo:
					#region Ammo
						//Weapon Data
						var _weapon_ammo,_weapon_ammo_max,_weapon_ammo_depletion_recovery_glow_alpha;
						with(weapon_data){
							_weapon_ammo = ammo;
							_weapon_ammo_max = ammo_max;
							_weapon_ammo_depletion_recovery_glow_alpha = ammo_depletion_recovery_glow_alpha;
						}

						//Dimensions
						var _ammo_bar_height,_ammo_bar_width;
						_ammo_bar_height = _section_height * _section_scale;
						_ammo_bar_width = _section_width * _section_scale;

						//Position
						_x = _section_x;
						_y = _section_y;
						//_y = (_hp_bar_y1 - _ammo_bar_height/2) - 1;
						//_y -= 5;

						var _ammo_bar_x1,_ammo_bar_x2,_ammo_bar_y1,_ammo_bar_y2;
						_ammo_bar_x1 = _x - _ammo_bar_width/2;
						_ammo_bar_x2 = _x + _ammo_bar_width/2;
						_ammo_bar_y1 = _y - _ammo_bar_height/2;
						_ammo_bar_y2 = _y + _ammo_bar_height/2;

						//Calculate %s
						var _ammo_percent;
						_ammo_percent = _weapon_ammo / _weapon_ammo_max;
						info_bar_ammo_percent_previous = lerp_with_gap_close(info_bar_ammo_percent_previous,_ammo_percent,0.1,0.01,false);
						if(info_bar_ammo_percent_previous < _ammo_percent)
							_ammo_percent = info_bar_ammo_percent_previous;

						draw_set_color(c_black);
						draw_set_alpha(0.8*_section_scale);
						draw_rectangle(_ammo_bar_x1,_ammo_bar_y1,_ammo_bar_x2,_ammo_bar_y2,false);

						//Previous
						if(info_bar_ammo_percent_previous > 0.01){
							_ammo_bar_x2 = _ammo_bar_x1 + _ammo_bar_width*info_bar_ammo_percent_previous;
							draw_set_color(c_white);
							draw_set_alpha(1*_section_scale);
							draw_rectangle(_ammo_bar_x1,_ammo_bar_y1,_ammo_bar_x2,_ammo_bar_y2,false);
						}

						//Current
						if(_ammo_percent > 0.01){
							_ammo_bar_x2 = _ammo_bar_x1 + _ammo_bar_width*_ammo_percent;
							draw_set_color(info_bar_ammo_colour);
							draw_set_alpha(1*_section_scale);
							draw_rectangle(_ammo_bar_x1,_ammo_bar_y1,_ammo_bar_x2,_ammo_bar_y2,false);
						}

						#region Recovery Ring
							if(info_bar_ammo_depletion_recovery_draw_enable){
								info_bar_ammo_depletion_recovery_draw_percentage = lerp(info_bar_ammo_depletion_recovery_draw_percentage,_ammo_depltion_recovery_percent,0.2);
								info_bar_ammo_depletion_recovery_draw_scale = lerp(info_bar_ammo_depletion_recovery_draw_scale,1,0.2);

								if(info_bar_ammo_depletion_recovery_draw_scale > 0){
									var _percent;
									_percent =  info_bar_ammo_depletion_recovery_draw_percentage;

									if(_percent < 1){
										draw_ring(_ammo_depletion_recovery_x,_ammo_depletion_recovery_y,45*info_bar_ammo_depletion_recovery_draw_scale,35*info_bar_ammo_depletion_recovery_draw_scale,c_black,_weapon_ammo_depletion_recovery_glow_alpha*0.5,100,1,-90,true);
									}
									draw_ring(_ammo_depletion_recovery_x,_ammo_depletion_recovery_y,45*info_bar_ammo_depletion_recovery_draw_scale,35*info_bar_ammo_depletion_recovery_draw_scale,c_yellow,_weapon_ammo_depletion_recovery_glow_alpha,100,_percent,-90,true);

									var _bullet_scale;
									_bullet_scale = 0.8*info_bar_ammo_depletion_recovery_draw_scale;
									draw_sprite_ext(spr_bullet_pistol,0,_ammo_depletion_recovery_x,_ammo_depletion_recovery_y,_bullet_scale,_bullet_scale,90,c_white,_weapon_ammo_depletion_recovery_glow_alpha);
								}
							}
						#endregion
					#endregion
				break;

				case InfoBarSection.status_effects:
					#region Status Effects
						if(o_ui.info_bar_show_effects){
						////HIDDEN
						//if(status_effect_active_count[StatusEffect.hidden] > 0){
						//	_x = _section_x;
						//	_y = _section_y;
						//	draw_text_ags(	_x,_y,
						//					"HIDDEN",
						//					_section_scale,_section_scale,image_angle,c_white,image_alpha,
						//					fa_middle,fa_center,fnt_default_38
						//					);
						//}
					}
					#endregion
				break;

				case InfoBarSection.attachments:
					#region Attachments
						//Position
						_x = _section_x;
						_y = _section_y;

						with(weapon_data){
							//Distribution
							var _attachment_separation,_attachment_length;
							_attachment_separation = 75*_section_scale;
							_attachment_length = (attachment_slot_count - 1) * _attachment_separation;

							//Position
							var _attachment_start_x;
							_attachment_start_x = _x - (_attachment_length/2);
							_y = _y - 50*_section_scale;

							//Scale
							var _attachment_scale;
							_attachment_scale = _section_scale * 0.8;

							//Loop Through Attachment Slots
							var _icon,_name;
							for(var _i=0;_i<attachment_slot_count;_i++){
								//Occupied Attachment Slot Found
								if((attachment_slot[_i] != noone) && (attachment_slot[_i] != 0)){
									with(attachment_slot[_i]){
										_icon = icon;
										_name = name;

										//Position
										_x = _attachment_start_x + _i*_attachment_separation;

										if(_icon!=noone){
											draw_sprite_ext(_icon,0,_x,_y,_attachment_scale,_attachment_scale,0,c_yellow,1*_section_scale);
										}
									}
								}
							}
						}
					#endregion
				break;


				case InfoBarSection.character_name:
					#region Character Name
						if((o_ui.info_bar_show_name) && (character_name != "")){
							_x = _section_x;
							_y = _section_y;
							draw_text_ags(	_x-3,_y+3,
											character_name,
											_section_scale,_section_scale,image_angle,c_black,_section_scale,
											fa_middle,fa_center,fnt_default_24
											);
							draw_text_ags(	_x,_y,
											character_name,
											_section_scale,_section_scale,image_angle,c_white,_section_scale,
											fa_middle,fa_center,fnt_default_24
											);

							//draw_text_outline(	_x,_y,
							//					character_name,
							//					_section_scale,_section_scale,
							//					c_black,c_flat_green_shamrock,2
							//					);
						}
					#endregion
				break;

				case InfoBarSection.name:
					#region Name
						if((o_ui.info_bar_show_name) && (name != "")){
							_x = _section_x;
							_y = _section_y;
							draw_text_ags(	_x-3,_y+3,
											name,
											_section_scale,_section_scale,image_angle,c_black,_section_scale,
											fa_middle,fa_center,fnt_default_16
											);
							draw_text_ags(	_x,_y,
											name,
											_section_scale,_section_scale,image_angle,c_white,_section_scale,
											fa_middle,fa_center,fnt_default_16
											);
						}
					#endregion
				break;

				case InfoBarSection.objective:
					#region Objective

					#endregion
				break;

				case InfoBarSection.alert:
					#region Alert

					#endregion
				break;

				case InfoBarSection.interaction_available:
					#region Interaction Available

					#endregion
				break;

				case InfoBarSection.dialogue_available_bark:
					#region Dialogue Available - Bark

					#endregion
				break;

				case InfoBarSection.dialogue_available_conversation:
					#region Dialogue Available - Conversation

					#endregion
				break;
			}

			//Adjust Position
			_section_x = x;
			_section_y = _section_y - _section_height/2;
		}

		draw_set_alpha(1);
	}
}