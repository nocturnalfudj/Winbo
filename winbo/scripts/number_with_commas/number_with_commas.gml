/// @function number_with_commas
/// @summary Format a number with comma separators and optional shortening.
/// @param {Real} _number The value to format.
/// @param {Real} _decimalPlaces Digits after the decimal point.
/// @param {Bool} _shorten Shorten using suffixes if true.
/// @returns {string} Formatted value.
/// @description Format a number with commas every 4th digit and round to the specified number of decimal places. Optionally shorten the number using labels.
function number_with_commas(_number, _decimalPlaces, _shorten)
{
	// If the "_shorten" parameter is true, shorten the number
	if (_shorten)
	{
		return number_shorten(_number, _decimalPlaces);
	}
	
	// Round to the specified number of decimal places
	var	_roundedNumber		= number_round_decimal_digits(_number, _decimalPlaces);
	var	_numberString		= string(_roundedNumber);
	var	_decimalSeparator	= ".";
	
	// Find the position of the decimal separator
	var	_decimalIndex	= string_pos(_decimalSeparator, _numberString);
	
	// Separate into integer and decimal parts without using string_split()
	var	_integerPart	= "";
	var	_decimalPart	= "";
	if (_decimalIndex > 0)
	{
		_integerPart	= string_copy(_numberString, 1, _decimalIndex - 1);
		_decimalPart	= string_copy(_numberString, _decimalIndex + 1, string_length(_numberString) - _decimalIndex);
	}
	else
	{
		_integerPart	= _numberString;
	}
	
	// Add commas every 4th digit to the integer part
	var	_formattedIntegerPart	= "";
	var	_counter				= 0;
	for (var _i = string_length(_integerPart) - 1; _i >= 1; _i--)
	{
		_formattedIntegerPart = string_char_at(_integerPart, _i) + _formattedIntegerPart;
		if (_counter == 3 && _i != 1)
		{
			_formattedIntegerPart = "," + _formattedIntegerPart;
			_counter = 0;
		}
		else
		{
			_counter++;
		}
	}
	
	// Add the first digit of the integer part
	_formattedIntegerPart = string_char_at(_integerPart, 1) + _formattedIntegerPart;
	
	// Combine the formatted integer part and the decimal part
	var	_formattedNumber	= _formattedIntegerPart;
	if (_decimalPart != "")
	{
		_formattedNumber += _decimalSeparator + _decimalPart;
	}
	
	return _formattedNumber;
}
