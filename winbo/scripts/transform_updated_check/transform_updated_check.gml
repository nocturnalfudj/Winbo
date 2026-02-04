/// @function transform_updated_check
/// @summary Determine if this instance or its children are animating.
function transform_updated_check(){
	var _transform_updated;
	_transform_updated = false;
		
	//If any of the object's own transforms are animating
	for(var _i=0;_i<TransformType.SIZE;_i++){
		with(transform[_i]){
			if(animating){
				_transform_updated = true;
			}
		}
	}
		
	//If any of the object's children relationships are animating
	for(var _i=0;_i<transform_child_count;_i++){
		with(transform_child[_i]){
			with(anchor_child_scale){
				if(animating){
					_transform_updated = true;
				}
			}
		}
	}
		
	//If parent has been updated
	with(transform_parent){
		if(update)
			_transform_updated = true;
	}
	
	//Set whether or not Transform has been Updated
	transform_updated = _transform_updated;
	
	return _transform_updated;
}