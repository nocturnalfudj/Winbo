/// @function VFXScheme
/// @summary Container for lighting and post-processing settings.
/// @returns {struct} Visual effects configuration.
/// @description
///   Modify the fields of this struct to tweak global visual effects.
function VFXScheme() constructor{
	#region Lighting
		////Light Intensity
		//lighting_light_intensity = 1;
	
		////Colour
		//lighting_colour[LightingColour.red]		= 0.46 * 255;
		//lighting_colour[LightingColour.green]	= 0.46 * 255;
		//lighting_colour[LightingColour.blue]	= 0.46 * 255;
	
		////Image
		//lighting_image[LightingImage.contrast]		= 1;
		//lighting_image[LightingImage.saturation]	= 1;
		//lighting_image[LightingImage.brightness]	= -0.027;
		//lighting_image[LightingImage.pop_strength]	= 0.02;
		//lighting_image[LightingImage.pop_threshold]	= 0.65;
		//lighting_image[LightingImage.gamma]			= 2.0;
		
		////Bloom
		//lighting_bloom_enabled = false;
		//lighting_bloom_intensity = 0.03;
		//lighting_bloom_blur_size = 0.002;
	#endregion
	
	#region Noise & Vignette
		vignette_noise_enable = false;
		
		//Colour
		vignette_colour[VignetteNoiseColour.red]	= 255;
		vignette_colour[VignetteNoiseColour.green]	= 255;
		vignette_colour[VignetteNoiseColour.blue]	= 255;
		
		//Circles
		vignette_circle_inner = 2;
		vignette_circle_outer = 1;
		
		//Noise
		noise_strength = 0;
	#endregion
}