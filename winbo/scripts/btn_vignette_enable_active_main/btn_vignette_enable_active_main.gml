/// @desc Toggles the vignette post-processing effect
function btn_vignette_enable_active_main() {
	var _toggle;
	_toggle = toggle;
	with(o_camera){
		vignette_noise_enable = _toggle;
		
		camera_save();
	}
}