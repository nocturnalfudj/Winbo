/// @function roundToDecimalPlaces(number, decimalPlaces)
/// @param {Real} number - The number to be rounded.
/// @param {Real} decimalPlaces - The number of decimal places to round the number to.
/// @description Round a number to the specified number of decimal places.
function number_round_decimal_digits(number, decimalPlaces){
    var multiplier = power(10, decimalPlaces);
    return round(number * multiplier) / multiplier;
}

