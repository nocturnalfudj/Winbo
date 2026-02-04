/// @function number_decimal_digits
/// @summary Truncate a value to a specific number of decimal places.
/// @param _value Number to truncate.
/// @param _decimal_digits Digits to preserve.
/// @returns {real} Truncated result.
function number_decimal_digits(_value,_decimal_digits) {
	if(_decimal_digits == 0){
		return floor(_value);
	}
	else{
		return _value - (_value mod (power(10,-_decimal_digits)));
	}
}