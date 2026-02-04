function director_environment_data_setup(){
	var _environment;
	var _environment_name,_environment_tile,_environment_foreground;
	var _environment_decoration_depth_layer;
	
	#region Default
		_environment = Environment.default_environment;
		_environment_name = "Default";
		_environment_tile = noone;
		_environment_foreground = noone;
		environment[_environment] = new EnvironmentData(_environment,_environment_name,_environment_tile,_environment_foreground);
		with(environment[_environment]){
			//Texture Group
			texture_group = "default_environment";
		
			#region VFX Scheme
				with(vfx_scheme){
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
			#endregion
		}
	#endregion
}