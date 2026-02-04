/// @desc Sets the pitch of an audio sound relative to its current value
/// @param _sound The sound ID playing
/// @param _pitch Desired absolute pitch value
function audio_sound_pitch_set(_sound,_pitch){
	//Get the Current Pitch
	var _pitch_current;
	_pitch_current = audio_sound_get_pitch(_sound);
	
	//Calculate What the Target Pitch is as a Factor of Current Pitch
	_pitch = _pitch/_pitch_current;
	
	//Set the Pitch
	audio_sound_pitch(_sound,_pitch);
}