function vfx_scheme_set_active(_vfx_scheme){
	vfx_scheme_active = _vfx_scheme;
	
	//Lighting
	lighting_light_intensity_target = _vfx_scheme.lighting_light_intensity;
	lighting_colour_set_target(	_vfx_scheme.lighting_colour[LightingColour.red],
										_vfx_scheme.lighting_colour[LightingColour.green],
										_vfx_scheme.lighting_colour[LightingColour.blue]);
	lighting_image_set_target(	_vfx_scheme.lighting_image[LightingImage.contrast],
										_vfx_scheme.lighting_image[LightingImage.saturation],
										_vfx_scheme.lighting_image[LightingImage.brightness],
										_vfx_scheme.lighting_image[LightingImage.pop_strength],
										_vfx_scheme.lighting_image[LightingImage.pop_threshold],
										_vfx_scheme.lighting_image[LightingImage.gamma]);
	lighting_bloom_enabled = _vfx_scheme.lighting_bloom_enabled;
	lighting_bloom_intensity = _vfx_scheme.lighting_bloom_intensity;
	lighting_bloom_blur_size = _vfx_scheme.lighting_bloom_blur_size;
	
	
	
	//Noise & Vignette
	vignette_noise_enable = _vfx_scheme.vignette_noise_enable;
	vignette_noise_colour_set_target(	_vfx_scheme.vignette_colour[VignetteNoiseColour.red],
												_vfx_scheme.vignette_colour[VignetteNoiseColour.green],
												_vfx_scheme.vignette_colour[VignetteNoiseColour.blue]);
	vignette_noise_setting_set_target(	_vfx_scheme.vignette_circle_inner,
												_vfx_scheme.vignette_circle_outer,
												_vfx_scheme.noise_strength);
}