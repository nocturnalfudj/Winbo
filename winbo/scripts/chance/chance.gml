/// @function chance
/// @summary Return true if a random roll succeeds.
/// @param _percentage_chance Probability from 0 to 1.
/// @returns {bool} Result of the roll.
/// @description
///   Useful for simple random events, e.g. `if(chance(0.25))` to trigger a drop.
function chance(_percentage_chance){
        if(_percentage_chance > random(1))
                return true;
        else
                return false;
}