/// @function audio_channel_set_vol
/// @summary Apply volume to all sounds in the given channel.
/// @param audio_channel Channel ID to modify.
/// @param volume        New volume in range [0, 1].
/// @param time          Optional fade time in seconds.
/// @description
///   Sets the volume for every sound associated with the channel and
///   updates the audio data structure.
function audio_channel_set_vol(_channel,_vol,_t) {
	var _snd_lst,_snd_lst_sz,_snd_id;

	with(o_audio){
		channel[@ _channel][AudioChannelProperty.volume] = _vol;
		_vol = _vol * volume_master;
		_snd_lst = channel[_channel][AudioChannelProperty.sound_list];
		_snd_lst_sz = ds_list_size(_snd_lst);
	}

	for(var _i=0;_i<_snd_lst_sz;_i++){
		_snd_id = _snd_lst[| _i];
		audio_sound_gain(_snd_id,_vol,_t);
	}
}