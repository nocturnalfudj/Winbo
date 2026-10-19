event_inherited();
if (!camera_visible) exit;

liquid_scene_capture();

surface_set_target(underwater_composite_surface);
draw_clear_alpha(c_black, 0);
gpu_set_colorwriteenable(false, false, false, true);
draw_surface(water_mask_surface, 0, 0);
gpu_set_colorwriteenable(true, true, true, true);
gpu_set_blendmode_ext(bm_dest_alpha, bm_zero);
shader_set(sh_liquid_ripple);
shader_set_uniform_f(submerged_ripple_uniform_time, submerged_ripple_time);
shader_set_uniform_f(submerged_ripple_uniform_texel, 1 / cached_surf_w, 1 / cached_surf_h);
shader_set_uniform_f(submerged_ripple_uniform_strength, submerged_ripple_strength);
shader_set_uniform_f(submerged_ripple_uniform_fade_top, 0, 0);
draw_surface(underwater_surface, 0, 0);
shader_reset();
gpu_set_blendmode(bm_normal);
surface_reset_target();

var _left = bbox_left;
var _top = bbox_top - render_height_buffer;
var _scale = 1 / render_scale;
draw_surface_ext(underwater_composite_surface, _left, _top, _scale, _scale, 0, c_white, 1);
draw_surface_ext(underwater_background_surface, _left, _top, _scale, _scale, 0, c_white, 0.3);

if (reflection_enable) {
	// Reuse the original scene capture so reflections never recapture the tint
	// or the water composite that was just drawn.
	surface_copy(reflection_surface, 0, 0, underwater_surface);
	surface_set_target(reflection_surface);
	gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
	draw_surface(water_mask_surface, 0, 0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();

	surface_set_target(reflection_composite_surface);
	draw_clear_alpha(c_black, 0);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	shader_set(sh_liquid_ripple);
	shader_set_uniform_f(submerged_ripple_uniform_time, submerged_ripple_time);
	shader_set_uniform_f(submerged_ripple_uniform_texel, 1 / cached_surf_w, 1 / cached_surf_h);
	shader_set_uniform_f(submerged_ripple_uniform_strength, submerged_ripple_strength);
	// Fade the available reflection near the capture edge instead of exposing
	// a hard horizontal seam when the camera cannot see farther above the water.
	shader_set_uniform_f(submerged_ripple_uniform_fade_top,
		render_capture_top, 64 * render_scale / cached_surf_h);
	draw_surface_ext(reflection_surface, 0, render_height_buffer * render_scale * 2,
		1, -1, 0, c_white, 1);
	shader_reset();
	// Clip the mirrored image to the current wave contour. Apply reflection
	// opacity only once, when compositing, without redrawing the submerged scene.
	gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
	draw_surface(water_mask_surface, 0, 0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	draw_surface_ext(reflection_composite_surface, _left, _top, _scale, _scale, 0, c_white, reflection_alpha);
}

if (o_master.dev_mode) draw_bounding_box(true);
