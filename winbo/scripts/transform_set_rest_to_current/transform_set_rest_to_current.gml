function transform_set_rest_to_current(_transform,_transform_value) {
	with(_transform){
		with(value[_transform_value]){
			rest = current;
		}
	}
}