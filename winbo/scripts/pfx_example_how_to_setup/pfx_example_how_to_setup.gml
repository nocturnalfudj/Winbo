/// @function pfx_example_how_to_setup
/// @summary Example script describing how to use the PFX system.
/// @returns {void}
function pfx_example_how_to_setup() {
	/*
	Example of how to setup and use the PFX system within an object.
	Uses the example pfx
	*/

	#region STEP 1 Create the PFX System
		//Place this script within the object's Create Event
		pfx_system_create();
	#endregion

	#region STEP 2 Clean up the PFX System
		//Place this script in the object's Clean Up Event
		pfx_system_clean_up();
	#endregion

	#region STEP 3 Create each PFX
		//Get Everything Needed from Visual Object
		var _system,_type,_gui,_emitter_x,_emitter_y,_emitter_height_half,_emitter_width_half,_emitter_shape,_emitter_distribution,_emitter_reg_scr,_burst_num,_burst_script;
		var _ps_background,_ps_foreground;
		var _part_type_example;
	
		with(o_pfx){
			_ps_background = part_system_background;
			_ps_foreground = part_system_foreground;
		
			_part_type_example = pfx_type_example;
			_emitter_width_half = pfx_example_emitter_width_half
		}
	
		//Create Emitters for Necessary Systems
		pfx_emitter_background = part_emitter_create(_ps_background);
		pfx_emitter_foreground = part_emitter_create(_ps_foreground);
	
		//Create a PFX
		_system = _ps_background;
		_gui = false;
		_emitter_x = 0;
		_emitter_y = 0;
		_emitter_width_half = _emitter_width_half;
		_emitter_height_half = _emitter_width_half;
		_emitter_shape = ps_shape_ellipse;
		_emitter_distribution = ps_distr_gaussian;
		_type = _part_type_example;
		_emitter_reg_scr = pfx_emitter_region;
		_burst_script = pfx_burst;
		_burst_num = 1;			
		pfx_create(PFXExample.example,
							_system,
							_type,
							_gui,
							pfx_emitter_foreground,
							_emitter_x,
							_emitter_y,
							_emitter_height_half,
							_emitter_width_half,
							_emitter_shape,
							_emitter_distribution,
							_emitter_reg_scr,
							_burst_num,
							_burst_script);
	#endregion

	#region STEP 4 Trigger PFX
		//Execute this script to trigger a PFX
		pfx_trigger(PFXExample.example);
	#endregion

	#region STEP 5 Run the PFX System Execute Script
		//Place this in the step event
		pfx_system_execute();
	#endregion
}