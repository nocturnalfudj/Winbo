/// @function seconds_to_time_format
/// @summary Convert seconds to a "M:SS" formatted string.
/// @param _value Seconds to convert
function seconds_to_time_format(_value){
	//Round Value
	_value = round(_value);

	//Split Value into Minutes & Seconds
	var _minutes,_seconds;
	_minutes = _value div 60;
	_seconds = _value mod 60;

	//Build Minute & Second Strings
	_minutes = string_format(_minutes,2,0);
	_minutes = string_replace_all(_minutes," ","0");
	_seconds = string_format(_seconds,2,0);
	_seconds = string_replace_all(_seconds," ","0");


	return _minutes + " : " + _seconds;
}