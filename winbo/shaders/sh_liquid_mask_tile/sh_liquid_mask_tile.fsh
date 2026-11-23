varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vMask;

uniform sampler2D u_mask;

void main()
{
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor.a *= texture2D(u_mask, v_vMask).a;
}
