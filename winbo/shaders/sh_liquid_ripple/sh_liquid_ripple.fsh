varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_time;
uniform vec2 u_texel;
uniform float u_strength;
uniform vec2 u_fade_top;
uniform vec2 u_reflection_depth;
uniform vec4 u_body_frame;
// The wave mask shares the capture's size, so both use the same coordinates.
uniform sampler2D u_mask;
// x + y * v is the mask row under this fragment's destination (0, 1 in place;
// mirror row, -1 for a reflection). z = 1 drops capture pixels the mask covers.
uniform vec3 u_mask_mode;

void main() {
    // The surface covers only a window of the body; ripple in whole-body space.
    vec2 body_uv = u_body_frame.xy + v_vTexcoord * u_body_frame.zw;
    vec2 wave = vec2(
        sin(body_uv.y * 42.0 + u_time * 2.4),
        cos(body_uv.x * 35.0 - u_time * 1.8) * 0.45
    );
    vec2 uv = clamp(v_vTexcoord + wave * u_texel * u_strength,
                    u_texel * 0.5, vec2(1.0) - u_texel * 0.5);
    vec4 colour = texture2D(gm_BaseTexture, uv);
    vec2 destination = vec2(v_vTexcoord.x, u_mask_mode.x + u_mask_mode.y * v_vTexcoord.y);
    colour.a *= texture2D(u_mask, destination).a
        * (1.0 - u_mask_mode.z * texture2D(u_mask, uv).a);
    gl_FragColor = v_vColour * colour;
    if (u_reflection_depth.y > 0.0) {
        float depth = max(0.0, u_reflection_depth.x - v_vTexcoord.y);
        gl_FragColor.a *= 1.0 - smoothstep(0.0, u_reflection_depth.y, depth);
    }
    if (u_fade_top.y > 0.0) {
        gl_FragColor.a *= smoothstep(u_fade_top.x, u_fade_top.x + u_fade_top.y, uv.y);
    }
}
