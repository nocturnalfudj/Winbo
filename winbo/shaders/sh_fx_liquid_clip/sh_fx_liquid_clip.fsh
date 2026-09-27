varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vWorld;
uniform vec4 u_liquid_bounds;

void main()
{
    if (v_vWorld.x < u_liquid_bounds.x || v_vWorld.y < u_liquid_bounds.y ||
        v_vWorld.x > u_liquid_bounds.z || v_vWorld.y > u_liquid_bounds.w) discard;
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
}
