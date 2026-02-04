/// Waves a value back and forth between two limits over a specified duration.
/// 
/// @param _from The lower limit of the wave.
/// @param _to The upper limit of the wave.
/// @param _duration The duration of one complete wave cycle (in seconds).
/// @param _offset An offset to start the wave at a different phase.
/// @returns The current value of the wave at the given time.

function wave(_from, _to, _duration, _offset) {
    // Calculate the amplitude of the wave.
    var amplitude = (_to - _from) * 0.5;
    
    // Calculate the time value for the current time in seconds (using current_time in milliseconds).
    var timeInSeconds = current_time * 0.001;
    
    // Apply the offset to start the wave at a different phase.
    var offsetTime = timeInSeconds + _duration * _offset;
    
    // Calculate the sine value, which oscillates between -1 and 1.
    var sineValue = sin(offsetTime / _duration * (pi * 2));
    
    // Scale the sine value to fit the amplitude and add it to the starting value.
    var currentValue = _from + amplitude + sineValue * amplitude;
    
    return currentValue;
}
