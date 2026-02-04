//States
enum CameraState{
	idle,
	stationary,
	follow,
	move
}
state = CameraState.stationary;

enum CameraAlarm{
	apply_resolution_current
}

//Window Scale
#macro WINDOW_SCALE_X 0.75
#macro android:WINDOW_SCALE_X 0.25
#macro ios:WINDOW_SCALE_X 0.25

#macro WINDOW_SCALE_Y WINDOW_SCALE_X

//Create Dimensions System
dimension_system_create();

#region Settings
	fullscreen = false;
	vsync = false;
	
	#region Anti Aliasing
		anti_aliasing = 0;
	
		for(var _i=0;_i<=8;_i++){
			anti_aliasing_supported[_i] = false;
		}
		
		anti_aliasing_supported[0] = true;
	
		switch(display_aa){
			case 2:
				anti_aliasing_supported[2] = true;
				anti_aliasing = 2;
			break;
		
			case 6:
				anti_aliasing_supported[2] = true;
				anti_aliasing_supported[4] = true;
				anti_aliasing = 4;
			break;
		
			case 12:
				anti_aliasing_supported[4] = true;
				anti_aliasing_supported[8] = true;
				anti_aliasing = 8;
			break;
		
			case 14:
				anti_aliasing_supported[2] = true;
				anti_aliasing_supported[4] = true;
				anti_aliasing_supported[8] = true;
				anti_aliasing = 8;
			break;
		}
	#endregion
	
	#region Filters
		enum CameraFilter{
			saturation,
			contrast,
			brightness,
			gamma,				//NOT a layer filter - applied via the vfx lighting system
			bloom,				//NOT a layer filter - applied via the vfx lighting system
			noise_intensity,	//NOT a layer filter - applied via the vfx lighting system
			noise_additional,
			vignette,
			
			SIZE
		}
		
		for(var _i=0;_i<CameraFilter.SIZE;_i++){			
			filter_setting[_i] = 1;
			filter_setting_min[_i] = 0;
			filter_setting_max[_i] = 2;
			filter_setting_previous[_i] = filter_setting[_i];
		}
		
		var _filter;
		_filter = CameraFilter.saturation;
		filter_setting_min[_filter] = 0;
		filter_setting_max[_filter] = 5;
		
		_filter = CameraFilter.noise_additional;
		filter_setting[_filter] = 0;
		filter_setting_min[_filter] = 0;
		filter_setting_max[_filter] = 0.2;
		
		_filter = CameraFilter.vignette;
		filter_setting[_filter] = 0;
		filter_setting_min[_filter] = 0;
		filter_setting_max[_filter] = 1;
	#endregion
#endregion

#region Resolution
	#region Orientation
		enum Orientation{
			portrait,
			landscape
		}
	
		//Get the Starting Orientation
		var _orientation;
		_orientation = camera_get_orientation();
		switch(_orientation){
			case display_landscape:
			case display_landscape_flipped:
				orientation = Orientation.landscape;
			break;
			
			case display_portrait:
			case display_portrait_flipped:
				orientation = Orientation.portrait;
			break;
			
			default:
				orientation = Orientation.portrait;
			break;
		}
			
		//orientation = Orientation.portrait;
	#endregion
	
	camera_w_inteded[Orientation.portrait] = 2160;
	camera_h_inteded[Orientation.portrait] = 3840;
		
	camera_w_inteded[Orientation.landscape] = 3840;
	camera_h_inteded[Orientation.landscape] = 2160;
	
	display_width = display_get_width();
	display_height = display_get_height();
	
	#region Resolution Options
		#macro RES_W 0
		#macro RES_H 1
		
		resolution_slot_count = 0;
		resolution_slot_display = -1;
		
		#region Slots
			if(IS_MOBILE){
				//OnePlus 6
				camera_add_resolution(1080,2280);
			
				//iPhone XR
				camera_add_resolution(828,1792);
			
				//iPhone XS
				camera_add_resolution(1125,2436);
				
				//iPhone 6s Plus
				camera_add_resolution(1242,2208);
			
				//iPhone XS Max
				camera_add_resolution(1242,2688);
				
				//iPad Pro
				camera_add_resolution(2048,2732);
			}
			else{
				camera_add_resolution(1024,768);
				camera_add_resolution(1024,800);
				camera_add_resolution(1280,1024);
				camera_add_resolution(1280,720);
				camera_add_resolution(1360,768);
				camera_add_resolution(1366,768);
				camera_add_resolution(1440,900);
				camera_add_resolution(1600,900);
				camera_add_resolution(1680,1050);
				camera_add_resolution(1920,1080);
				camera_add_resolution(1920,1200);
				camera_add_resolution(2560,1080);
				camera_add_resolution(2560,1440);
				camera_add_resolution(2560,1600);
				camera_add_resolution(3440,1440);
				camera_add_resolution(3840,2160);
			}
			
			//CUSTOM RESOLUTION
			if(resolution_slot_display == -1){
				if(TESTING_MOBILE_ON_DESKTOP){
					camera_add_resolution(camera_get_intended_width(),camera_get_intended_height());
					//Set Slot as Display Resolution Slot
					resolution_slot_display = resolution_slot_count - 1;
				}
				else{
					camera_add_resolution(display_width,display_height);
				}
			}
		#endregion
		
		resolution_slot_current = resolution_slot_display;
		resolution_slot_next = resolution_slot_display;
	#endregion
	
	//Initialise Dimension Variables
	camera_dimensions_update(resolution[resolution_slot_current][RES_W],resolution[resolution_slot_current][RES_H]);
#endregion

#region Zoom
	#macro CAMERA_ZOOM_ENABLE true
	zoom_control_enable = true;
	zoom_control_enable_window_scroll = true;
	
	zoom_control_clamp_enable = true;
	zoom_control_clamp_min = 0.1;
	zoom_control_clamp_max = 2;
	
	zoom_control_pinch_active = false;
	zoom_control_pinch_start_value = 0;
	zoom_control_pinch_start_distance = 0;

	zoom_anchor = new TransValue(1);
	zoom_relative = new TransValue(1);

	zoom_resultant = zoom_anchor.current * zoom_relative.current;
	
	zoom_updated = false;
	
	//Whether or not the zoom uses timescale
	//true is for anything that should obey slow/fast motion
	zoom_time_scale_enable = true;
	
	#macro CAMERA_ZOOM_RECOIL_TIME 0.5*SECOND
	#macro CAMERA_ZOOM_RECOIL_CURVE ease_back_out
	
	#macro CAMERA_ZOOM_ANCHOR_PLAY_REST 0.9
	#macro CAMERA_ZOOM_ANCHOR_MENU_REST 1
	
	#macro CAMERA_ZOOM_ANCHOR_PLAY_MULTI_FOLLOW_TARGET_DISTANCE_MIN 500
	#macro CAMERA_ZOOM_ANCHOR_PLAY_MULTI_FOLLOW_TARGET_DISTANCE_MAX 2000
#endregion

#region Position
	x = width_half;
	y = height_half;

	//Update Camera Position
	camera_view_pos_update();
	
	#region Clamp
		position_clamp_enable_x = true;
		position_clamp_enable_y = true;
		position_clamp_max = new Vector2(1000,1000);
		position_clamp_min = new Vector2(0,0);
	#endregion
#endregion

//Create Transform System
transform_system_create();
transform_system_relative_enable();

#region Movement
	//Movement System
	movement_system_create();
	move_collision_object = noone;
	move_trapped_check = false;
	move_grounded_check = false;
		
	movement_velocity_retention_and_acceleration_max_set(0.8,10);
	movement_input_move_acceleration_default_set(acceleration_max);
	
	//Drag & Pan
	movement_drag_pan_enable();
	pan_edge_scroll_min.Set(0,0);
	pan_edge_scroll_max.Set(width_ini,height_ini);
	
	//Mouse Wheel Direction
	mouse_wheel_direction_y = -1;
	mouse_wheel_direction_x = 0;
#endregion

#region Shake System
	// Initialize the generalized shake system
	shake_system_create();
	
	// Configure for transform application
	shake_use_transform = true;
	shake_target_transform = TransformType.relative;
	shake_target_transform_reference = transform[TransformType.relative];
	
	// Legacy compatibility
	shake_magnitude_factor = 1;
#endregion

#region Object Following
	follow_target_id = noone;
	follow_target_user_needs_to_be_alive = true;
	follow_target_user_aim_offset_enable = false;
	
	follow_target = new Vector2(x,y);
	follow_target_difference = new Vector2(0,0);
	follow_offset = new Vector2(0,0);
	follow_offset_target = new Vector2(0,-250);
	
	#macro CAMERA_FOLLOW_OFFSET_LERP_FACTOR_X 0.1
	#macro CAMERA_FOLLOW_OFFSET_LERP_FACTOR_Y 0.1
	
	enum CameraFollowMethod{
			lerp_to_targ,
			curve_to_targ,
			
			new_room_snap,
			
			SIZE
	}
	
	follow_method = CameraFollowMethod.lerp_to_targ;
	follow_method_previous = follow_method;
	
	#macro CAMERA_FOLLOW_TARG_CURVE_TIME_MAX_X SECOND
	#macro CAMERA_FOLLOW_TARG_CURVE_TIME_MAX_Y SECOND
	#macro CAMERA_FOLLOW_TARG_CURVE_TIME_CURRENT_X 2
	#macro CAMERA_FOLLOW_TARG_CURVE_TIME_CURRENT_Y 2
	#macro CAMERA_FOLLOW_TARG_CURVE_X ease_back_out
	#macro CAMERA_FOLLOW_TARG_CURVE_Y ease_back_out
	
	#macro CAMERA_FOLLOW_TARG_LERP_FACTOR_X 0.1
	#macro CAMERA_FOLLOW_TARG_LERP_FACTOR_Y 0.1
	
	// Jump Dampening System - prevents camera from following player up during jumps
	follow_jump_dampening_enable = true;			// Toggle this system on/off
	follow_jump_dampening_factor = 1.0;				// Current dampening multiplier (0 = no follow, 1 = full follow)
	follow_jump_dampening_lerp_speed = 0.015;		// How fast the dampening factor lerps back to 1.0
#endregion

#region Stationary
	stationary_target = new Vector2(x,y);

	#macro CAMERA_STATIONARY_LERP_FACTOR_X 0.1
	#macro CAMERA_STATIONARY_LERP_FACTOR_Y 0.1
#endregion

#region Recording
	//GUI Surface
	gui_surface = noone;

	#region Screenshots
		screenshot_num = 0;
		screenshot_record = false;
	#endregion

	#region GIFs
		gif_record = false;
		gif_num = 0;
		gif = noone;
	
		#macro GIF_SCALE 0.5
		
		gif_surface = noone;
	
		gif_width = 0;
		gif_height = 0;
	#endregion
#endregion

#region VFX
	#region Lighting
		//Enums
		enum LightingColour{
			red,
			green,
			blue,
			
			SIZE
		}
		
		enum LightingImage{
			contrast,
			saturation,
			brightness,
			pop_strength,
			pop_threshold,
			gamma,
			
			SIZE
		}
		
		enum LightType{
			spotlight,
			rotating,
			sine,
			torch,
			tracking,
			
			SIZE
		}
		
		//Enable
		lighting_enable = false;
		
		//Surface
		lighting_lights_surface				= -1;
		lighting_lights_surface_texture		= -1;
		lighting_darkness_surface			= -1;
		lighting_darkness_surface_texture	= -1;
		
		//Lights
		lighting_light_intensity = 0.9;
		lighting_light_intensity_target = lighting_light_intensity;
		lighting_light_intensity_lerpval = 0.2;
		
		//Darkness
		lighting_darkness_intensity = 0.9;
		lighting_darkness_intensity_target = lighting_darkness_intensity;
		lighting_darkness_intensity_lerpval = 0.2;
		
		//Shader
		lighting_shader_uniform_col				= shader_get_uniform(sh_lighting, "col");
		lighting_shader_uniform_con_sat_brt		= shader_get_uniform(sh_lighting, "con_sat_brt");
		lighting_shader_sampler_index_lights	= shader_get_sampler_index(sh_lighting, "lights");
		lighting_shader_sampler_index_darkness	= shader_get_sampler_index(sh_lighting, "darkness");
		lighting_shader_update = true;
		
		//Colour
		lighting_colour_mix		= -1;
	
		//Image
		lighting_image_mix	= -1;
		
		//Colour
		for(var _i=0;_i<LightingColour.SIZE;_i++){
			lighting_colour_current[_i]	= 100/255;
			lighting_colour_target[_i]	= lighting_colour_current[_i];
			lighting_colour_lerpval[_i]	= 0.2;
		}
		lighting_colour_set_current_target(255, 255, 255);
				
					  
		//Image
		for(var _i=0;_i<LightingImage.SIZE;_i++){
			lighting_image_current[_i]	= 1;
			lighting_image_target[_i]	= lighting_image_current[_i];
			lighting_image_lerpval[_i]	= 0.2;
		}
		
		lighting_image_set_current_target(0.70,0.90,-0.15,0.05,0.65,2);
	
		#region Key Times
			//Key Times
			lighting_key_previous	= -1;
			lighting_key_next		= -1;
			
			// arguments:	R	G	 B		con	 sat		   brt	popS	 popT
			//lighting_key_time_add(002, 075, 150,		0.70,	 0.90,	 -0.10,	 0.05,	 0.65);
			//lighting_key_time_add(113, 113, 113,		0.92,	 1.3,	 0.055,	 0.0,	 0.65);  //NORMAL
		#endregion

		#region Bloom
			//Surface
			lighting_bloom_surface = -1;
			
			//Enable
			lighting_bloom_enabled = false;
	
			//Shader uniforms
			lighting_bloom_intensity = 0.01;
			lighting_bloom_shader_uniform_intensity = shader_get_uniform(sh_bloom, "intensity");
			
			lighting_bloom_blur_size = 0.001;
			lighting_bloom_shader_uniform_blur_size = shader_get_uniform(sh_bloom, "blurSize");
		#endregion
		
		//Blinder Distance
		blinder_distance = infinity;
	#endregion
	
	#region Noise & Vignette
		//Enable
		vignette_noise_enable = false;
		
		//Enums
		enum VignetteNoiseColour{
			red,
			green,
			blue,
			
			SIZE
		}
		enum VignetteNoiseSetting{
			inner_circle_size,
			outter_circle_size,
			noise_strength,
			
			SIZE
		}
		
		//Colour
		for(var _i=0;_i<VignetteNoiseColour.SIZE;_i++){
			vignette_noise_colour_current[_i]	= 255;
			vignette_noise_colour_target[_i]	= vignette_noise_colour_current[_i];
			vignette_noise_colour_lerpval[_i]	= 0.2;
		}
		vignette_noise_colour_set_current_target(255,255,255);
		
		//Settings
		for(var _i=0;_i<VignetteNoiseSetting.SIZE;_i++){
			vignette_noise_setting_setting_current[_i]	= 0;
			vignette_noise_setting_setting_target[_i]	= vignette_noise_setting_setting_current[_i];
			vignette_noise_setting_setting_lerpval[_i]	= 0.2;
		}
		vignette_noise_setting_set_current_target(2,1,0);
		
		//Shader Uniforms
		vignette_noise_shader_uniform_settings				= shader_get_uniform(sh_vignette_noise, "u_settings");
		vignette_noise_shader_uniform_vignette_colour		= shader_get_uniform(sh_vignette_noise, "u_vignette_colour");
		vignette_noise_shader_uniform_vignette_random_seed	= shader_get_uniform(sh_vignette_noise, "u_vignette_random_seed");
		vignette_noise_shader_update = true;
	#endregion

	#region Glitch Shader
		//Enable
		glitch_enable = true;
		if(glitch_enable){
			bktglitch_init();
		}
		
		//Magnitude Transform Value
		glitch_magnitude = new TransValue(0);
		glitch_magnitude.recoil_time = 0.1*SECOND;
		//transform_value_set(glitch_magnitude,0,false);
		
		//Surface
		glitch_surface = noone;
		
		//Shader Update
		glitch_shader_update = true;
		
		//Enum
		enum GlitchSetting{
		    line_speed,
		    line_shift,
		    line_resolution,
		    line_vertical_shift,
		    line_drift,
		    jumble_speed,
		    jumble_shift,
		    jumble_resolution,
		    jumbleness,
		    channel_dispersion,
		    channel_shift,
		    noise_level, 
		    shakiness,
		    rng_seed,
		    intensity,
		    time,
		    resolution,
			noise_texture,
			random_values,
			
			SIZE
		}
		
		//Setting
		for(var _i=0;_i<GlitchSetting.SIZE;_i++){
			glitch_setting_current[_i]	= 0;
			glitch_setting_target[_i]	= glitch_setting_current[_i];
			glitch_setting_lerpval[_i]	= 0.2;
		}
	#endregion
	
	#region Schemes
		#region Default
			vfx_scheme_default = new VFXScheme();
			with(vfx_scheme_default){
				#region Lighting
					//Light Intensity
					lighting_light_intensity = 0.5;
	
					//Colour
					lighting_colour[LightingColour.red]		= 0.5 * 255;
					lighting_colour[LightingColour.green]	= 0.5 * 255;
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
					vignette_noise_enable = false;
					
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
		
		//Scheme Variables
		vfx_scheme_active = vfx_scheme_default;
		vfx_scheme_debug_override = false;
		
		//Apply Default Scheme
		vfx_scheme_set_active(vfx_scheme_default);
	#endregion
	
	//Disable Automatic Drawing of Application Surface
	application_surface_draw_enable(false);
#endregion

#region Save & Load
	#macro SAVE_FILE_CAMERA "camera.save"
	//save_map = ds_map_secure_load(SAVE_FILE_CAMERA);
	save_map = load_json(SAVE_FILE_CAMERA);
	epoch_update();
	
	bad_load = false;
	bad_load_string = "Camera BAD LOAD: ";
	
	if(save_map == -1 || SAVE_REFRESH || SAVE_REFRESH_SETTINGS){
		save_map = ds_map_create();
		camera_save();
	}
	else{
		camera_load();
	}
#endregion

//Apply VSync & Anti Aliasing
if(!IS_BROWSER)
	display_reset(anti_aliasing,vsync);

//Apply Resolution
alarm[CameraAlarm.apply_resolution_current] = 1;	//Set Alarm for applying current resolution

//Remove Sprite
sprite_index = noone;

#region Debug Overlay
	if(DEBUG_OVERLAY_ENABLE){
		var _reference;
	
		//View
		dbg_view("Camera",false);
	
		#region Settings
			dbg_section("Settings",false);		
			
			//Image Title
			dbg_text("Image Settings");
			
			//Image
			_reference = ref_create(self,"filter_setting",0);
			dbg_slider(_reference,filter_setting_min[CameraFilter.contrast],filter_setting_max[CameraFilter.contrast],"Contrast - Setting");
			_reference = ref_create(self,"filter_setting",1);
			dbg_slider(_reference,filter_setting_min[CameraFilter.saturation],filter_setting_max[CameraFilter.saturation],"Saturation - Setting");
			_reference = ref_create(self,"filter_setting",2);
			dbg_slider(_reference,filter_setting_min[CameraFilter.brightness],filter_setting_max[CameraFilter.brightness],"Brightness - Setting");
			_reference = ref_create(self,"filter_setting",3);
			dbg_slider(_reference,filter_setting_min[CameraFilter.gamma],filter_setting_max[CameraFilter.gamma],"Gamma - Setting");
			_reference = ref_create(self,"filter_setting",4);
			dbg_slider(_reference,filter_setting_min[CameraFilter.bloom],filter_setting_max[CameraFilter.bloom],"Bloom - Setting");
			_reference = ref_create(self,"filter_setting",5);
			dbg_slider(_reference,filter_setting_min[CameraFilter.noise_intensity],filter_setting_max[CameraFilter.noise_intensity],"Noise Intensity - Setting");
			_reference = ref_create(self,"filter_setting",6);
			dbg_slider(_reference,filter_setting_min[CameraFilter.noise_additional],filter_setting_max[CameraFilter.noise_additional],"Additional Noise - Setting");
			_reference = ref_create(self,"filter_setting",7);
			dbg_slider(_reference,filter_setting_min[CameraFilter.vignette],filter_setting_max[CameraFilter.vignette],"Vignette - Setting");
		#endregion
	
		#region Zoom
			dbg_section("Zoom",false);
		#endregion
	
		#region Camera Shake
			dbg_section("Camera Shake",false);
		
			_reference = ref_create(self,"shake_magnitude_factor");
			dbg_slider(_reference,0,1,"Camera Shake");
		#endregion
	
		#region Lighting
			//Section
			dbg_section("Lighting",false);
		
			_reference = ref_create(self,"lighting_enable");
			dbg_checkbox(_reference,"Enable Lighting");
		
			_reference = ref_create(self,"vfx_scheme_debug_override");
			dbg_checkbox(_reference,"VFX Scheme Debug Override");
		
			_reference = ref_create(self,"lighting_light_intensity_target");
			dbg_slider(_reference,0,1,"Light Intensity");
		
			//Colour Title
			dbg_text("Colour");
		
			//RGB
			_reference = ref_create(self,"lighting_colour_target",0);
			dbg_slider(_reference,0,1,"Red");
			_reference = ref_create(self,"lighting_colour_target",1);
			dbg_slider(_reference,0,1,"Green");
			_reference = ref_create(self,"lighting_colour_target",2);
			dbg_slider(_reference,0,1,"Blue");
		
			//Line Break
			dbg_text(" ");
		
			//Image Title
			dbg_text("Image");
		
			//Image
			_reference = ref_create(self,"lighting_image_target",0);
			dbg_slider(_reference,-1,1,"Contrast");
			_reference = ref_create(self,"lighting_image_target",1);
			dbg_slider(_reference,-1,1,"Saturation");
			_reference = ref_create(self,"lighting_image_target",2);
			dbg_slider(_reference,-0.2,0.1,"Brightness");
			_reference = ref_create(self,"lighting_image_target",3);
			dbg_slider(_reference,-1,1,"Pop Strength");
			_reference = ref_create(self,"lighting_image_target",4);
			dbg_slider(_reference,-1,1,"Pop Threshold");
			_reference = ref_create(self,"lighting_image_target",5);
			dbg_slider(_reference,0,2.5,"Gamma");
		
			//Line Break
			dbg_text(" ");
		
			//Bloom Title
			dbg_text("Bloom");
		
			//Bloom
			_reference = ref_create(self,"lighting_bloom_enabled");
			dbg_checkbox(_reference,"Enable Bloom");
			_reference = ref_create(self,"lighting_bloom_intensity");
			dbg_slider(_reference,0,1,"Bloom Intensity");
			_reference = ref_create(self,"lighting_bloom_blur_size");
			dbg_slider(_reference,0,0.02,"Bloom Blur Size");
		
			debug_function_lighting_reset = function(){
												if(global.game_state == GameState.play){
													//Get VFX Scheme from Envrionment
													var _vfx_scheme;
													_vfx_scheme = vfx_scheme_active;
												
													//Apply Environment Scheme
													vfx_scheme_set_active(_vfx_scheme);
												}
												else{
													//Apply Default Scheme
													vfx_scheme_set_active(vfx_scheme_default);
												}
											}
			_reference = ref_create(self,"debug_function_lighting_reset");
			dbg_button("RESET",_reference,200,200);
		#endregion
	
		#region Noise & Vignette
			dbg_section("Noise & Vignette",false);
		
			//Vignette Title
			dbg_text("Vignette");
		
			_reference = ref_create(self,"vfx_scheme_debug_override");
			dbg_checkbox(_reference,"VFX Scheme Debug Override");
		
			_reference = ref_create(self,"vignette_noise_enable");
			dbg_checkbox(_reference,"Vignette Enable");
		
			//RGB
			_reference = ref_create(self,"vignette_noise_colour_target",0);
			dbg_slider_int(_reference,0,255,"Vignette Red");
			_reference = ref_create(self,"vignette_noise_colour_target",1);
			dbg_slider_int(_reference,0,255,"Vignette Green");
			_reference = ref_create(self,"vignette_noise_colour_target",2);
			dbg_slider_int(_reference,0,255,"Vignette Blue");
		
			//Line Break
			dbg_text(" ");
		
			//Circles
			_reference = ref_create(self,"vignette_noise_setting_setting_target",0);
			dbg_slider(_reference,0,10,"Vignette Inner Circle");
			_reference = ref_create(self,"vignette_noise_setting_setting_target",1);
			dbg_slider(_reference,0,10,"Vignette Outer Circle");
		
			//Line Break
			dbg_text(" ");
		
			//Noise Title
			dbg_text("Noise");
		
			//Circles
			_reference = ref_create(self,"vignette_noise_setting_setting_target",2);
			dbg_slider(_reference,0,1,"Noise Strength");
		#endregion
	
		#region Glitch
			dbg_section("Glitch",false);
		
			_reference = ref_create(self,"glitch_enable");
			dbg_checkbox(_reference,"Enable Glitch");
		
			_reference = ref_create(self,"vfx_scheme_debug_override");
			dbg_checkbox(_reference,"VFX Scheme Debug Override");
		
			_reference = ref_create(glitch_magnitude,"current");
			dbg_slider(_reference,0,1,"Glitch Magnitude");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.line_speed);
			dbg_slider(_reference,0,1,"Line Speed");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.line_shift);
			dbg_slider(_reference,0,1,"Line Shift");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.line_resolution);
			dbg_slider(_reference,0,1,"Line Resolution");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.line_vertical_shift);
			dbg_slider(_reference,0,1,"Line Vertical Shift");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.line_drift);
			dbg_slider(_reference,0,1,"Line Drift");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.jumble_speed);
			dbg_slider(_reference,0,1,"Jumble Speed");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.jumble_shift);
			dbg_slider(_reference,0,1,"Jumble Shift");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.jumble_resolution);
			dbg_slider(_reference,0,1,"Jumble Resolution");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.jumbleness);
			dbg_slider(_reference,0,1,"Jumbleness");

			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.channel_dispersion);
			dbg_slider(_reference,0,1,"Channel Dispersion");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.channel_shift);
			dbg_slider(_reference,0,1,"Channel Shift");

			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.noise_level);
			dbg_slider(_reference,0,1,"Noise Level");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.shakiness);
			dbg_slider(_reference,0,1,"Shakiness");

			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.rng_seed);
			dbg_slider(_reference,0,1,"RNG Seed");
		
			_reference = ref_create(self,"glitch_setting_target",GlitchSetting.intensity);
			dbg_slider(_reference,0,1,"Intensity");
		#endregion
	}
#endregion