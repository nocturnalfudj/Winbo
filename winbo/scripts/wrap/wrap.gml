/// @function wrap
/// @summary Wrap a number so it stays within a range.
/// @param value    Value to wrap.
/// @param min      Minimum bound of the range.
/// @param max      Maximum bound of the range.
/// @returns Wrapped value constrained between `min` and `max`.
/// @description
///   Useful when wrapping angles or counters. Works with integer and
///   floating point values.
// Returns the value wrapped, values over or under will be wrapped around
function wrap(_value, _min, _max) {
    // Check if the value is an integer (whole number)
	if (_value mod 1 == 0) {
        // Loop until the value is within the range of min and max (inclusive)
		while (_value > _max || _value < _min) {
            // If the value is greater than the max, wrap it around to the minimum
			if (_value > _max) {
				_value += _min - _max - 1;
			}
            // If the value is less than the min, wrap it around to the maximum
			else if (_value < _min) {
				_value += _max - _min + 1;
			}
		}

        // Return the wrapped value
		return _value;
	}
    // If the value is not an integer (has decimal places)
	else {
        // Create a variable to store the old value for comparison
		var vOld = _value + 1;
        
        // Loop until the value becomes equal to its previous value (no change)
		while (_value != vOld) {
			vOld = _value;
            
            // If the value is less than the minimum, wrap it around to the maximum
			if (_value < _min) {
				_value = _max - (_min - _value);
			}
            // If the value is greater than the maximum, wrap it around to the minimum
			else if (_value > _max) {
				_value = _min + (_value - _max);
			}
		}

        // Return the wrapped value
		return _value;
	}
}
