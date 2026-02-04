// Inherit the parent event
event_inherited();

//Camera Visible Check
if(!camera_visible)
	exit;

// Wavy-top fill (replace sprite fill)
var _left,_top,_right,_bottom,_width,_height;
_left = bbox_left;
_top = bbox_top;
_right = bbox_right;
_bottom = bbox_bottom;
_width = _right - _left;
_height = _bottom - _top;

var _segs,_dx,_k;
_segs = wave_segments;
_dx = wave_dx;
_k = (2*pi) / wave_len_px;


//Calculate Position On Camera
var _camera_zoom,_camera_zoom_inverse;
_camera_zoom = o_camera.zoom_resultant;
_camera_zoom_inverse = (1/o_camera.zoom_resultant);
	
//Dynamic Width and Height
var _reflection_width,_reflection_height;
_reflection_width = reflection_surface_width;// * _camera_zoom_inverse;
_reflection_height = reflection_surface_height;// * _camera_zoom_inverse;
	
var _height_buffer;
_height_buffer = max(500, _height);  // Ensure buffer is at least as tall as the volume
	
var _reflection_height_buffer_adjusted;
_reflection_height_buffer_adjusted = _reflection_height + _height_buffer;
	
var _x_on_camera,_y_on_camera;

// Application-space scale (window pixels per world pixel on screen)
var _scale_to_app;
_scale_to_app = o_ui.gui_scale * _camera_zoom_inverse;

// Destination surface dimensions in application-space
var _surf_w,_surf_h;
_surf_w = max(1, floor(_reflection_width * _scale_to_app));
_surf_h = max(1, floor(_reflection_height_buffer_adjusted * _scale_to_app));

var _cam,_view_x,_view_y;
_cam = view_camera[0];
_view_x = camera_get_view_x(_cam);
_view_y = camera_get_view_y(_cam);

_x_on_camera = (x - _view_x) * _scale_to_app;
_y_on_camera = ((y - _height_buffer) - _view_y) * _scale_to_app;
	
// Only create/resize surfaces if dimensions changed (optimization)
if (cached_surf_w != _surf_w || cached_surf_h != _surf_h) {
	if(!surface_exists(underwater_background_surface)){
		underwater_background_surface = surface_create(_surf_w,_surf_h);
	} else {
		surface_resize(underwater_background_surface,_surf_w,_surf_h);
	}
	
	if(!surface_exists(water_mask_surface)){
		water_mask_surface = surface_create(_surf_w,_surf_h);
	} else {
		surface_resize(water_mask_surface,_surf_w,_surf_h);
	}
	
	// Update cache
	cached_surf_w = _surf_w;
	cached_surf_h = _surf_h;
}
// Ensure surfaces exist even if dimensions didn't change
else {
	if(!surface_exists(underwater_background_surface)) underwater_background_surface = surface_create(_surf_w,_surf_h);
	if(!surface_exists(water_mask_surface)) water_mask_surface = surface_create(_surf_w,_surf_h);
}

	//Mask
	surface_set_target(water_mask_surface);
	draw_clear_alpha(c_black,0);
	draw_primitive_begin(pr_trianglestrip);
	for (var _i1 = 0; _i1 <= _segs; _i1++) {
		var _vx1 = _i1 * _dx;
		var _u1 = _i1 / _segs;
		var _t1 = power(sin(pi * _u1), wave_edge_power);
		var _b1 = sin(_k * (_vx1) + wave_phase) * wave_amp_px * _t1;
		var _d1 = wave_sim_enable ? wave_y[_i1] : 0;
		var _yt1 = 0 + _b1 + _d1;
		var _vx_px = _vx1 * _scale_to_app;
		var _yt_px = (_yt1 + _height_buffer - 0) * _scale_to_app;
		draw_vertex(_vx_px, _yt_px);
		draw_vertex(_vx_px, _surf_h);
	}
	draw_primitive_end();
	surface_reset_target();
#endregion

#region Underwater
	//Copy Region of Volume on Application Surface
	var _surface_copy_width,_surface_copy_height;
	_surface_copy_width = _surf_w;
	_surface_copy_height = _surf_h;
	
	#region Underwater Background
		surface_set_target(underwater_background_surface);
		draw_clear_alpha(c_black,0);
	
		gpu_set_colorwriteenable(false,false,false,true);
		draw_surface(water_mask_surface,0,0);
	
		gpu_set_colorwriteenable(true,true,true,true);
		gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
		draw_sprite_tiled_ext(sprite_index, 0, texture_x, texture_y, 1, 1, c_white, 1);

		gpu_set_blendmode(bm_normal);		
		surface_reset_target();

		// Draw composite
		draw_surface_ext(underwater_background_surface,x,y - _height_buffer,1 * o_ui.gui_scale_inverse * _camera_zoom,1 * o_ui.gui_scale_inverse * _camera_zoom,0,c_white,1);
	#endregion
#endregion
	
	
if(o_master.dev_mode){
	draw_bounding_box(true);
}