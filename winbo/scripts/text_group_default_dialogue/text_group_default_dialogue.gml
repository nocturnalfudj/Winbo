/// @function text_group_default_dialogue
/// @summary Construct a default dialogue list for testing.
/// @returns {ds_list} Populated dialogue ds_list.
function text_group_default_dialogue() {
	var _default;
	_default = ds_list_create();

	//0 - 99 Grid Details
	_default[| TextRow.language] = "default";
	_default[| TextRow.author] = "Author : Callum Lory";
	_default[| TextRow.version] = "Version : 2.0.0";
	_default[| TextRow.date] = "Date : 30/04/2020";
	_default[| TextRow.name] = "Dialogue Text Sheet - Default";

	#region 100
		_default[| 100] = "100";
	#endregion

	return _default;
}
