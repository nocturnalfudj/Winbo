function director_environment_data_setup(){
	var _environment;
	var _environment_name,_environment_tile,_environment_foreground;
	
	var _subtle_parallax_y;
	_subtle_parallax_y = function(_parallax_x) {
		return clamp(_parallax_x * 0.12, 0.04, 0.12);
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
				{mode: "normal", sprite: spr_bg_forest_layer_5, parallax_x: 1.0, parallax_y: 1.0, offset_y: -2000},
				{mode: "normal", sprite: spr_bg_forest_layer_4, parallax_x: 0.9, parallax_y: 0.9, offset_y: -2000},
				{mode: "normal", sprite: spr_bg_forest_layer_3, parallax_x: 0.8, parallax_y: 0.8, offset_y: -2000},
				{mode: "normal", sprite: spr_bg_forest_layer_2, parallax_x: 0.7, parallax_y: 0.7, offset_y: -2000},
				{mode: "normal", sprite: spr_bg_forest_layer_1, parallax_x: 0.6, parallax_y: 0.6, offset_y: -2000},
				{mode: "normal", sprite: spr_bg_forest_layer_0, parallax_x: 0.5, parallax_y: 0.5, offset_y: -2000}
			],
			[]
		);
		with(environment[_environment]){
			//Texture Group
			texture_group = "default_environment";
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
				{mode: "normal", sprite: spr_bg_l1_layer_6_sky, parallax_x: 1.00, parallax_y: _subtle_parallax_y(1.00), offset_y: _new_bg_offset_y},
				{mode: "normal", sprite: spr_bg_l1_layer_5_mountains, parallax_x: 0.90, parallax_y: _subtle_parallax_y(0.90), offset_y: _new_bg_offset_y},
				{mode: "normal", sprite: spr_bg_l1_layer_4_riverside, parallax_x: 0.80, parallax_y: _subtle_parallax_y(0.80), offset_y: _new_bg_offset_y},
				{mode: "normal", sprite: spr_bg_l1_layer_3_plains, parallax_x: 0.70, parallax_y: _subtle_parallax_y(0.70), offset_y: _new_bg_offset_y},
				{mode: "normal", sprite: spr_bg_l1_layer_2_treeline_second, parallax_x: 0.60, parallax_y: _subtle_parallax_y(0.60), offset_y: _new_bg_offset_y},
				{mode: "normal", sprite: spr_bg_l1_layer_1_treeline_main, parallax_x: 0.50, parallax_y: _subtle_parallax_y(0.50), offset_y: _new_bg_offset_y}
			],
			[]
		);
		with(environment[_environment]){
			texture_group = "default_environment";
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
				{mode: "normal", sprite: spr_bg_l2_layer_7_sky, parallax_x: 1.00, parallax_y: _subtle_parallax_y(1.00), offset_y: _new_bg_offset_y},
				{mode: "normal", sprite: spr_bg_l2_layer_6_mountains, parallax_x: 0.90, parallax_y: _subtle_parallax_y(0.90), offset_y: _new_bg_offset_y},
				{mode: "normal", sprite: spr_bg_l2_layer_5_treeline_bg, parallax_x: 0.80, parallax_y: _subtle_parallax_y(0.80), offset_y: _new_bg_offset_y},
				{mode: "variant_once", sprite_first: spr_bg_l2_layer_4a_forest_crane, sprite_loop: spr_bg_l2_layer_4b_forest_no_crane, parallax_x: 0.70, parallax_y: _subtle_parallax_y(0.70), offset_y: _new_bg_offset_y},
				{mode: "normal", sprite: spr_bg_l2_layer_3_treeline_main, parallax_x: 0.60, parallax_y: _subtle_parallax_y(0.60), offset_y: _new_bg_offset_y},
				{mode: "normal", sprite: spr_bg_l2_layer_2_shore, parallax_x: 0.50, parallax_y: _subtle_parallax_y(0.50), offset_y: _new_bg_offset_y}
			],
			[
				{mode: "animated", sprite: spr_bg_l2_layer_1_river, parallax_x: 0.45, parallax_y: _subtle_parallax_y(0.45), offset_y: 0, fps: 30}
			]
		);
		with(environment[_environment]){
			texture_group = "default_environment";
		}
		_apply_default_vfx(environment[_environment]);
	#endregion
}
