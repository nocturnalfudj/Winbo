varying vec2 var_texcoord;
varying vec4 v_vColour;

uniform vec4 u_settings; // vignette inner circle size, vignette outer circle size, noise strength, noise enabled
uniform vec3 u_vignette_colour; // R, G, B
uniform float u_vignette_random_seed;

float rand(vec2 co)
{
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main()
{
    vec4 base = texture2D(gm_BaseTexture, var_texcoord);

    float vignette = distance(vec2(0.5, 0.5), var_texcoord);
    vignette = u_settings.x - vignette * u_settings.y;
    vec3 vignette_colour = (u_vignette_colour / 255.0) * vignette;

    // Calculate the blend factor based on vignette; ensure it's in [0, 1] range.
    float blendFactor = 1.0 - clamp(vignette, 0.0, 1.0);
    vec3 blendedColor = mix(base.rgb, base.rgb * u_vignette_colour / 255.0, blendFactor);

    // Noise calculation
    if (u_settings.w == 1.0)
    {
        float noise_strength = u_settings.z;
        float noise = noise_strength * (rand(var_texcoord * u_vignette_random_seed) - 0.5);
        blendedColor += noise;
    }

    gl_FragColor = v_vColour * vec4(blendedColor, base.a);
}