/// @function Text
/// @summary Lookup and store a translated string id.
/// @param {real} _text_group Text grid group index.
/// @param {real} _text_id    Row ID within the group.
/// @returns {struct} Text lookup struct.
/// @description
///   Stores a reference to a text grid entry so it can update when languages change.
function Text(_text_group,_text_id) constructor{
	text_group = _text_group;
	text_id = _text_id;
	value = text_grid_string_get(_text_group,_text_id);
	
	with(o_text){
		var _list;
		_list = text_list[_text_group];
		ds_list_add(_list,other);
	}
}