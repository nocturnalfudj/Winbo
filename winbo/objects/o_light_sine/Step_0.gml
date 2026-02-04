//Inherit
event_inherited();

//Sine
var shift = sin(sine_timer*sine_value)*amplitude;
sine_timer+=sine_timer_step;

image_alpha = shift;