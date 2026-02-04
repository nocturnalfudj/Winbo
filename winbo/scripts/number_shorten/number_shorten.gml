/// @function number_shorten(_number, _decimal_places)
/// @param {Real} _number            – The number to be shortened (can be negative).
/// @param {Real} _decimal_places    – How many decimal places to keep.
/// @returns {string} Shortened, labelled string.
function number_shorten(_number, _decimal_places)
{
	var _scale_base        = 1000;
	var _label_index       = 0;
	var _is_negative       = (_number < 0);
	var _absolute_number   = abs(_number);

	// Scale down until below base or out of labels
	while ((_absolute_number >= _scale_base) && (_label_index < NumberShortenLabel.SIZE - 1))
	{
		_absolute_number /= _scale_base;
		_label_index++;
	}

	// Round and format
	var _formatted_number = string_format(number_round_decimal_digits(_absolute_number, _decimal_places), 0, _decimal_places);
	var _suffix           = "";

	// Select suffix based on scale
	switch (_label_index)
	{
		case NumberShortenLabel.k: _suffix = "K"; break;
		case NumberShortenLabel.m: _suffix = "M"; break;
		case NumberShortenLabel.b: _suffix = "B"; break;
		case NumberShortenLabel.t: _suffix = "T"; break;
		case NumberShortenLabel.p: _suffix = "P"; break;
		case NumberShortenLabel.e: _suffix = "E"; break;
		case NumberShortenLabel.z: _suffix = "Z"; break;
		case NumberShortenLabel.y: _suffix = "Y"; break;
		case NumberShortenLabel.d: _suffix = "D"; break;
	}

	// Trim trailing zeros and possible trailing dot
	var _formatted_length = string_length(_formatted_number);
	while ((_formatted_length > 0) && (string_copy(_formatted_number, _formatted_length, 1) == "0"))
	{
		_formatted_number = string_copy(_formatted_number, 1, _formatted_length - 1);
		_formatted_length--;
	}
	if ((_formatted_length > 0) && (string_copy(_formatted_number, _formatted_length, 1) == "."))
	{
		_formatted_number = string_copy(_formatted_number, 1, _formatted_length - 1);
	}

	// Reapply sign if negative
	if (_is_negative)
	{
		_formatted_number = "-" + _formatted_number;
	}

	return _formatted_number + _suffix;
}

enum NumberShortenLabel {
	no_label,
	k,
	m,
	b,
	t,
	p,
	e,
	z,
	y,
	d,
	
	SIZE
}