/// @function scroll_slider_idle_main
/// @summary Update the slider value from its anchor transform.
function scroll_slider_idle_main(){
	var _transform,_transform_value;
	_transform = scroll.transform[TransformType.anchor];
	_transform_value = (vertical)? _transform.value[TransformValue.y] : _transform.value[TransformValue.x];
	value_current = _transform_value.current;
}