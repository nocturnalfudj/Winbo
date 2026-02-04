function transform_value_set_rest(_transform_value,_value,_add_to_rest) {
	with(_transform_value){
		if(_add_to_rest){
			rest = rest + _value;
		}
		else{
			rest = _value;
		}
	}
}