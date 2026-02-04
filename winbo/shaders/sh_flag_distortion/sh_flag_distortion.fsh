/*-----------------------------------------------------------------------------
Flag Distortion Shader: Distorts a flag sprite
Vertex Shader: Pass-through
Fragment Shader: Distort & Specular
-------------------------------------------------------------------------------
_______________________________________________________________________________
INFO:
-------------------------------------------------------------------------------
This shader distorts a flag sprite so it looks like it's waving in the wind.
It's nto a cloth simulation though. Thus it cant really fold the flag. It can
however mimmick the effect quite well with the fragment shader alone.

The shader needs the flag to be on its own 2^n texture page. And it needs a 
distortion mask on it's n^2 texture page as well.

- The distortion masks red and green channel are used to distort in two different
  patterns. Those two patterns can be mixed by any percentage.
  No red/green means no distortion.
  Full red/green means full distortion.
- A distortion strength uniform is multiplied with the channels to get dynamic
  control over the effect.
- The distortion size uniform is used to stretch or squash the x and y axis of
  the red and green channel to give some more control ofer the distortion.
- The time uniform shifts the red/green sample taken on the mask and so creates
  the ave effect.
  
- The distortion masks blue channel is multipied with the red/green channel and
  is unaffected by the time uniform. It's used to reduce the duistortion towards
  the flag pole.
  
- The specularity uniform is used to add some highlights nd darken some areas
  on the flag to add some more depth.

_______________________________________________________________________________
UNIFORMS:
-------------------------------------------------------------------------------
uniform float		time;			real | 0 <= time <= 1
									shifts the coordinates on the red and green channel
									and thus advances the wave
uniform float		strength;		real | 0 <= strength <= 1
									distortion multiplier
									0.5 usually looks good
uniform vec4		size;			real | 0 <= size <= 1
									[red x-axis, red y-axis, green x-axis, green y-axis]
									scales the red and green channel
									0.5 on x-axis and 0.15 on y-axis usually looks good
uniform float		R_or_G;			real | 0 <= R_or_G <= 1
									sets how much of the red or green channel should be
									applied. Change this dynamically to keep the wave interesting.
									0: only red | 1: only green | 0-1: a mix
uniform float		spec;			real | 0 <= spec <= 4
									Adds highlights and shadows.
									2-3 usually looks good.
uniform float		show_result;	0 <= show_result <= 1
									debug only: shows either the flag colour or the distortion

uniform sampler2D	distort_tex;	
	
_______________________________________________________________________________
EXAMPLE:
-------------------------------------------------------------------------------

Create event:
---------------------------------------
	sprite			= spr_flag_01;
	distort_sprite	= spr_distort_mask_flag_01;
	distort_tex		= sprite_get_texture(distort_sprite, 0);

	shader			= shd_flag_distortion;
	u_distort_tex	= shader_get_sampler_index(shader, "distort_tex");
	u_time			= shader_get_uniform(shader, "time");
	u_strength		= shader_get_uniform(shader, "strength");
	u_size			= shader_get_uniform(shader, "size");
	u_R_or_G		= shader_get_uniform(shader, "R_or_G");
	u_spec			= shader_get_uniform(shader, "spec");
	u_show_result	= shader_get_uniform(shader, "show_result"); // *** debug only:

	time			= random(1);

	
Draw event:
---------------------------------------
	gpu_set_tex_filter(true);

	shader_set(shader);
		texture_set_stage(u_distort_tex, distort_tex);
	
		shader_set_uniform_f(u_time, time);
		shader_set_uniform_f(u_strength, strength);
		shader_set_uniform_f(u_size, size_Rx, size_Ry, size_Gx, size_Gy);
		shader_set_uniform_f(u_R_or_G, R_or_G);
		shader_set_uniform_f(u_spec, spec);
	
		shader_set_uniform_f(u_show_result, show_result); // *** debug only:
	
		// draw normal or flipped:
		draw_sprite(sprite, 0, x + 16, y);
		//draw_sprite_ext(sprite, 0, x - 16, y, -1, 1, 0, c_white, 1);
	shader_reset();

	gpu_set_tex_filter(false);
*/

varying vec2		v_vTexcoord;
varying vec4		v_vColour;

uniform float		time;			// time advances the wave
uniform float		strength;		// strength multiplies the distortion
uniform vec4		size;			// size scales the distortion pattern
uniform float		R_or_G;			// R_or_G mixes the distortion channels
uniform float		spec;
uniform float		show_result; // *** debug only:

uniform sampler2D	distort_tex;

//#define size vec4(0.33, 0.15, 0.40, 0.15)
//#define spec 10.0



void main() {
	// Distortion: by red and green channel of the distortion mask
	float distort;
	distort			=  texture2D(distort_tex, fract(v_vTexcoord * size.xy + vec2(-time, time))).r * (1.0-R_or_G);
	distort			+= texture2D(distort_tex, fract(v_vTexcoord * size.zw + vec2(-time, time))).g * R_or_G;
	
	
	// Fixture: to lower the distortion towards the flag pole
    //float fixture	= texture2D(distort_tex, v_vTexcoord).b;
	float fixture = 1.0;
	
	
	// Get UV Offset based on red/green/blue channels times strength
	vec2 uvOffset	= distort * vec2(strength, -strength) * fixture;
	
	
	// Get final colour:
	vec4 final_col	= v_vColour * texture2D(gm_BaseTexture, v_vTexcoord + uvOffset);
	
	
	// Add specularity to final colour:	
	final_col.rgb	+= max(distort - 0.45, -0.2) * fixture * strength * spec * texture2D(distort_tex, v_vTexcoord + uvOffset).a;
	
	
	// Show debug for distortion: can be removed
	//final_col.rgb = mix(vec3(distort * fixture), final_col.rgb, show_result);
	
	// Output:
	gl_FragColor	= final_col;
}