varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_time;
uniform vec2 u_texel;
uniform float u_strength;
uniform vec2 u_fade_top;
uniform vec2 u_reflection_depth;

void main() {
    vec2 wave = vec2(
        sin(v_vTexcoord.y * 42.0 + u_time * 2.4),
        cos(v_vTexcoord.x * 35.0 - u_time * 1.8) * 0.45
    );
    vec2 uv = clamp(v_vTexcoord + wave * u_texel * u_strength,
                    u_texel * 0.5, vec2(1.0) - u_texel * 0.5);
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv);
    if (u_reflection_depth.y > 0.0) {
        float depth = max(0.0, u_reflection_depth.x - v_vTexcoord.y);
        gl_FragColor.a *= 1.0 - smoothstep(0.0, u_reflection_depth.y, depth);
    }
    if (u_fade_top.y > 0.0) {
        gl_FragColor.a *= smoothstep(u_fade_top.x, u_fade_top.x + u_fade_top.y, uv.y);
    }
}
