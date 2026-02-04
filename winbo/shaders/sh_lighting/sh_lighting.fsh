/*-----------------------------------------------------------------------------
Day and Night Shader: Tint, Contrast, Brightness, Saturation and Pop Lights
Fragment Shader: Apply effects. overlay tint. blend light surface
-----------------------------------------------------------------------------*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 col;  // Tint color
uniform float con_sat_brt[6];

uniform sampler2D lights;
uniform sampler2D darkness;

#define contrast        con_sat_brt[0]
#define saturation      con_sat_brt[1]
#define brightness      con_sat_brt[2]
#define pop_strength    con_sat_brt[3]
#define pop_threshold   con_sat_brt[4]
#define gamma_value		con_sat_brt[5]

void main()
{
    // Step 1: Apply gamma correction to input colors
    vec3 base_col = pow(texture2D(gm_BaseTexture, v_vTexcoord).rgb, vec3(gamma_value));
    
    // Step 2: Calculate luminance (greyscale value)
    float grey = dot(base_col, vec3(0.299, 0.587, 0.114));
    
    // Step 3: Overlay tint using the col uniform
    //vec3 out_col = grey > 0.5 ? 1.0 - (1.0 - 2.0 * (base_col - 0.5)) * (1.0 - col) : 2.0 * base_col * col;
	vec3 out_col = mix(base_col, col, 0.1); 
    
    // Step 4: Add saturation
    out_col = mix(vec3(grey), out_col, saturation);
    
    // Step 5: Add contrast
    out_col = (out_col - 0.5) * contrast + 0.5;
    
    // Step 6: Add pop effect for highlights (brighter areas)
    float pop_factor = smoothstep(pop_threshold - 0.1, pop_threshold + 0.1, grey);
    out_col += pop_strength * pop_factor;
    
    // Step 7: Add brightness (this might need tweaking to balance overall light)
    out_col = out_col + brightness;
    
    // Step 8: Blend lights into the final output
    vec3 lights_col = texture2D(lights, v_vTexcoord).rgb;
    grey = dot(lights_col, vec3(0.333));  // Calculate average light intensity
    out_col = mix(out_col, base_col * normalize(lights_col + 0.05) * 3.0, grey);  // Adjust light blending

    
    // Step 9: Fetch the darkness value and apply it (inverted)
    vec3 darkness_val = texture2D(darkness, v_vTexcoord).rgb;
    out_col *= (1.0 - darkness_val);  // Darken according to the darkness map
    
    // Step 10: Gamma correction for the final output
    out_col = pow(out_col, vec3(1.0 / gamma_value));
    
    // Final color output
    gl_FragColor = vec4(out_col, 1.0);
    
    // Alpha discard for transparency
    if (gl_FragColor.a == 0.0) {
        discard;
    }
}
