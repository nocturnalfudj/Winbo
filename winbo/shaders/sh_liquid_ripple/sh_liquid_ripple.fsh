varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_time;
uniform vec2 u_texel;
uniform float u_strength;

void main() {
    vec2 wave = vec2(
        sin(v_vTexcoord.y * 42.0 + u_time * 2.4),
        cos(v_vTexcoord.x * 35.0 - u_time * 1.8) * 0.45
    );
    vec2 uv = clamp(v_vTexcoord + wave * u_texel * u_strength,
                    u_texel * 0.5, vec2(1.0) - u_texel * 0.5);
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv);
}
