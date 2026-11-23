
============[ RELEASE NOTES ]============

>>> v1.3 <<<

- [ADDED] Noise Blur shader (tested successfully on: Windows, Android, HTML5 and OperaGX)
- [ADDED] Baked Blur shader (tested successfully on: Windows, Android, HTML5 and OperaGX)
- [ADDED] New blur_sprite_create() reworked from scratch

- [FIXED] In HTML5, blur was rendered incorrectly if moving camera
- [FIXED] Some performance improvements in the gaussian blur shader
- [FIXED] blur_area_draw() was not working in normal Draw Event when drawing in room
- [FIXED] Reduced library size

- [REMOVED] blur_area_draw(); Now everything has been merged into just one function, making it more practical
- [REMOVED] non_zero() function, since it is no longer used



>>> v1.2 <<<

- [ADDED] New example: Blurred sprite
- [ADDED] blur_sprite_create() now has a subimg parameter
- [ADDED] Small menu animation

- [FIXED] Blur amount parameter values
- [FIXED] Now, blur_area_draw uses radius instead of downamount
- [FIXED] Small optimization on surfaces
- [FIXED] Pause menu blur (now, animation goes from 0)

- [CHANGED] Renamed all functions to blur_area_* instead of blur_realtime_*
- [CHANGED] Now it's blur_sprite_create() instead of blur_static_create()

- [REMOVED] Two redundant lines from draw_blur_realtime_ext()



>>> v1.1 <<<

- [ADDED] Extra info about cameras and views
- [FIXED] Small positioning bug

- [REMOVED] Two redundant lines from draw_blur_realtime_ext()



>>> v1.0 (Launched) <<<

- [NEW] "Foxey Blur Area" launched!
