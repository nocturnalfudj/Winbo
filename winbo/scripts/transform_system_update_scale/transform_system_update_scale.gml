/// @function transform_system_update_scale
/// @summary Apply all transformation scale values to image_xscale and image_yscale.
/// @returns {void}
function transform_system_update_scale() {
	var _xscale,_yscale;
	_xscale = 1;
	_yscale = 1;
        // Combine all local transform scale modifiers
        for(var _i=0;_i<TransformType.SIZE;_i++){
                with(transform[_i]){
                        _xscale *= value[TransformValue.xscale].current
                        _yscale *= value[TransformValue.yscale].current
                }
        }
	
	with(transform_parent){
		_xscale *= value[TransformValue.xscale];
		_yscale *= value[TransformValue.yscale];
	}
	
	image_xscale = _xscale;
	image_yscale = _yscale;
}