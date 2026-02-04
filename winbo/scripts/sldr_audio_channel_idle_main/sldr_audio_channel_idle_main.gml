/// @function sldr_audio_channel_idle_main
/// @summary Update the slider from the channel's current volume.
function sldr_audio_channel_idle_main() {
	value_current = o_audio.channel[channel,AudioChannelProperty.volume];
}