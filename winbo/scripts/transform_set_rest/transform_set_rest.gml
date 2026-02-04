function transform_set_rest(_transform,_transform_value,_value,_add_to_rest) {
	with(_transform){
		with(value[_transform_value]){
			if(_add_to_rest){
				rest = rest + _value;
			}
			else{
				rest = _value;
			}
		}
	}
}