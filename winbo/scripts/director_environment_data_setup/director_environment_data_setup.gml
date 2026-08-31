function director_environment_data_setup(){
	var _environment;
	var _environment_name,_environment_tile,_environment_foreground;
	
	var _subtle_parallax_y;
	_subtle_parallax_y = function(_parallax_x) {
		return clamp(_parallax_x * 0.12, 0.04, 0.12);
	};
	
	var _gameplay_bg_parallax_y;
	_gameplay_bg_parallax_y = function(_parallax_x) {
		return clamp(0.4 + (_parallax_x * 0.4), 0.60, 0.80);
	};
	
	var _new_bg_offset_y;
	_new_bg_offset_y = -120;
	
	var _apply_default_vfx;
	_apply_default_vfx = function(_environment_data){
		with(_environment_data.vfx_scheme){
			#region Lighting
				//Light Intensity
				lighting_light_intensity = 0.5;

				//Colour
				lighting_colour[LightingColour.red]		= 0.2 * 255;
				lighting_colour[LightingColour.green]	= 0.45 * 255;
				lighting_colour[LightingColour.blue]	= 0.5 * 255;

				//Image
				lighting_image[LightingImage.contrast]		= 1;
				lighting_image[LightingImage.saturation]	= 1;
				lighting_image[LightingImage.brightness]	= -0.06;
				lighting_image[LightingImage.pop_strength]	= 0.02;
				lighting_image[LightingImage.pop_threshold]	= 0.65;
				lighting_image[LightingImage.gamma]			= 2.0;
	
				//Bloom
				lighting_bloom_enabled = false;
				lighting_bloom_intensity = 0.03;
				lighting_bloom_blur_size = 0.002;
			#endregion

			#region Noise & Vignette
				vignette_noise_enable = true;
				
				//Colour
				vignette_colour[VignetteNoiseColour.red]	= 200;
				vignette_colour[VignetteNoiseColour.green]	= 200;
				vignette_colour[VignetteNoiseColour.blue]	= 200;
	
				//Circles
				vignette_circle_inner = 2;
				vignette_circle_outer = 5.1;
	
				//Noise
				noise_strength = 0;
			#endregion
		}
	};
	
	#region Default
		_environment = Environment.default_environment;
		_environment_name = "Default";
		_environment_tile = noone;
		_environment_foreground = noone;
		environment[_environment] = new EnvironmentData(
			_environment,
			_environment_name,
			_environment_tile,
			_environment_foreground,
			[
				{mode: "normal", sprite: spr_bg_forest_layer_5, parallax_x: 1.0, parallax_y: 1.0, offset_y: -2000, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_forest_layer_4, parallax_x: 0.9, parallax_y: 0.9, offset_y: -2000, repeat_x: true, clamp_top: true, clamp_bottom: false},
				{mode: "normal", sprite: spr_bg_forest_layer_3, parallax_x: 0.8, parallax_y: 0.8, offset_y: -2000, repeat_x: true, clamp_top: true, clamp_bottom: false},
				{mode: "normal", sprite: spr_bg_forest_layer_2, parallax_x: 0.7, parallax_y: 0.7, offset_y: -2000, repeat_x: true, clamp_top: true, clamp_bottom: false},
				{mode: "normal", sprite: spr_bg_forest_layer_1, parallax_x: 0.6, parallax_y: 0.6, offset_y: -2000, repeat_x: true, clamp_top: true, clamp_bottom: false},
				{mode: "normal", sprite: spr_bg_forest_layer_0, parallax_x: 0.5, parallax_y: 0.5, offset_y: -2000, repeat_x: true, clamp_top: true, clamp_bottom: false}
			],
			[]
		);
		with(environment[_environment]){
			//Texture Group
			texture_group = "level_1";
		}
		_apply_default_vfx(environment[_environment]);
	#endregion
	
	#region Level 1
		_environment = Environment.level_1_environment;
		_environment_name = "Level 1";
		_environment_tile = noone;
		_environment_foreground = noone;
		environment[_environment] = new EnvironmentData(
			_environment,
			_environment_name,
			_environment_tile,
			_environment_foreground,
			[
				{mode: "normal", sprite: spr_bg_l1_layer_6_sky, parallax_x: 1.00, parallax_y: _gameplay_bg_parallax_y(1.00), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_l1_layer_5_mountains, parallax_x: 0.90, parallax_y: _gameplay_bg_parallax_y(0.90), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_l1_layer_4_riverside, parallax_x: 0.80, parallax_y: _gameplay_bg_parallax_y(0.80), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_l1_layer_3_plains, parallax_x: 0.70, parallax_y: _gameplay_bg_parallax_y(0.70), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_l1_layer_2_treeline_second, parallax_x: 0.60, parallax_y: _gameplay_bg_parallax_y(0.60), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_l1_layer_1_treeline_main, parallax_x: 0.50, parallax_y: _gameplay_bg_parallax_y(0.50), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true}
			],
			[]
		);
		with(environment[_environment]){
			texture_group = "level_1";
		}
		_apply_default_vfx(environment[_environment]);
	#endregion
	
	#region Level 2
		_environment = Environment.level_2_environment;
		_environment_name = "Level 2";
		_environment_tile = noone;
		_environment_foreground = noone;
		environment[_environment] = new EnvironmentData(
			_environment,
			_environment_name,
			_environment_tile,
			_environment_foreground,
			[
				{mode: "normal", sprite: spr_bg_l2_layer_7_sky, parallax_x: 1.00, parallax_y: _gameplay_bg_parallax_y(1.00), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_l2_layer_6_mountains, parallax_x: 0.90, parallax_y: _gameplay_bg_parallax_y(0.90), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: false},
				{mode: "normal", sprite: spr_bg_l2_layer_5_treeline_bg, parallax_x: 0.80, parallax_y: _gameplay_bg_parallax_y(0.80), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: false},
				{mode: "normal", sprite: spr_bg_l2_layer_4a_forest_crane, parallax_x: 0.70, parallax_y: _gameplay_bg_parallax_y(0.70), offset_y: _new_bg_offset_y, repeat_x: false, clamp_top: true, clamp_bottom: false},
				{
					mode: "normal", sprite: spr_bg_l2_layer_3_treeline_main, parallax_x: 0.60, parallax_y: _gameplay_bg_parallax_y(0.60), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: false
				},
				{
					mode: "normal", sprite: spr_bg_l2_layer_2_shore, parallax_x: 0.50, parallax_y: _gameplay_bg_parallax_y(0.59), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: false
				},
				{
					mode: "animated",
					sprite: spr_bg_l2_layer_1_river,
					parallax_x: 0.50,
					parallax_y: _gameplay_bg_parallax_y(0.50),
					offset_y: _new_bg_offset_y,
					fps: 30,
					clamp_top: true,
					clamp_bottom: false
				}
			],
			[]
		);
		with(environment[_environment]){
			texture_group = "level_2";
		}
		_apply_default_vfx(environment[_environment]);
	#endregion
	
	#region Bonus Room
		_environment = Environment.bonus_room_environment;
		_environment_name = "Bonus Room";
		_environment_tile = noone;
		_environment_foreground = noone;
		environment[_environment] = new EnvironmentData(
			_environment,
			_environment_name,
			_environment_tile,
			_environment_foreground,
			[
				{mode: "normal", sprite: spr_bg_bonus_layer_3_wall_paintings_stained_glass, parallax_x: 0.82, parallax_y: _subtle_parallax_y(0.82), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_bonus_layer_2_pillars_arches, parallax_x: 0.68, parallax_y: _subtle_parallax_y(0.68), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: false},
					{
						mode: "anchored_animated_overlay",
						base_sprite: spr_bg_bonus_chandelier_base,
						animated_sprite: spr_bg_bonus_chandelier_candles_anim,
						parallax_x: 0.55,
						parallax_y: _subtle_parallax_y(0.45),
						offset_y: _new_bg_offset_y,
						fps: 15,
						loop_width: 7680,
						anchor_x: [960, 3840, 6720],
						anchor_sprite_x: 298,
						clamp_top: false,
						clamp_bottom: false
					},
				{mode: "normal", sprite: spr_bg_bonus_layer_1_front_bridge_ceiling, parallax_x: 0.55, parallax_y: _subtle_parallax_y(0.55), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: false}
			],
			[]
		);
		with(environment[_environment]){
			texture_group = "bonus";
		}
		_apply_default_vfx(environment[_environment]);
	#endregion

	#region Opening Cutscene
		_environment = Environment.opening_cutscene_environment;
		_environment_name = "Opening Cutscene";
		_environment_tile = noone;
		_environment_foreground = noone;
		environment[_environment] = new EnvironmentData(
			_environment,
			_environment_name,
			_environment_tile,
			_environment_foreground,
			[
				{mode: "view_cover", sprite: spr_bg_opening_layer_4},
				{mode: "view_cover", sprite: spr_bg_opening_layer_3},
				{mode: "view_cover", sprite: spr_bg_opening_layer_2},
				{mode: "view_cover", sprite: spr_bg_opening_layer_1}
			],
			[
				{mode: "view_cover", sprite: spr_bg_opening_layer_0_foreground}
			]
		);
		with(environment[_environment]){
			texture_group = "opening_cutscene";
		}
		_apply_default_vfx(environment[_environment]);
	#endregion

	#region Tutorial
		_environment = Environment.tutorial_environment;
		_environment_name = "Tutorial";
		_environment_tile = noone;
		_environment_foreground = noone;
		environment[_environment] = new EnvironmentData(
			_environment,
			_environment_name,
			_environment_tile,
			_environment_foreground,
			[
				{mode: "normal", sprite: spr_bg_tutorial_layer_4, parallax_x: 1.00, parallax_y: _gameplay_bg_parallax_y(1.00), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_tutorial_layer_3, parallax_x: 0.85, parallax_y: _gameplay_bg_parallax_y(0.85), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_tutorial_layer_2, parallax_x: 0.70, parallax_y: _gameplay_bg_parallax_y(0.70), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true},
				{mode: "normal", sprite: spr_bg_tutorial_layer_1, parallax_x: 0.55, parallax_y: _gameplay_bg_parallax_y(0.55), offset_y: _new_bg_offset_y, repeat_x: true, clamp_top: true, clamp_bottom: true}
			],
			[]
		);
		with(environment[_environment]){
			texture_group = "tutorial";
		}
		_apply_default_vfx(environment[_environment]);
	#endregion

	#region Presence
		_environment = Environment.presence_environment;
		_environment_name = "Presence";
		_environment_tile = noone;
		_environment_foreground = noone;
		// The supplied Presence art is one 2160px-high room composition. Pin it
		// to the bottom of the 4000px room so vertical camera movement cannot
		// separate its painted floor/cave from the world-space Presence actor.
		var _presence_background_y;
		_presence_background_y = 1840;
		environment[_environment] = new EnvironmentData(
			_environment,
			_environment_name,
			_environment_tile,
			_environment_foreground,
			[
				{mode: "normal", sprite: spr_bg_presence_layer_4, parallax_x: 0.0, parallax_y: 0.0, offset_y: _presence_background_y, repeat_x: false, clamp_top: false, clamp_bottom: false},
				{mode: "normal", sprite: spr_bg_presence_layer_3, parallax_x: 0.0, parallax_y: 0.0, offset_y: _presence_background_y, repeat_x: false, clamp_top: false, clamp_bottom: false},
				{mode: "normal", sprite: spr_bg_presence_layer_2, parallax_x: 0.0, parallax_y: 0.0, offset_y: _presence_background_y, repeat_x: false, clamp_top: false, clamp_bottom: false}
			],
			[
				{mode: "normal", sprite: spr_bg_presence_layer_1_foreground, parallax_x: 0.0, parallax_y: 0.0, offset_y: _presence_background_y, repeat_x: false, clamp_top: false, clamp_bottom: false}
			]
		);
		with(environment[_environment]){
			texture_group = "presence";
		}
		_apply_default_vfx(environment[_environment]);
	#endregion
}
