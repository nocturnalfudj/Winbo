varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    float authored_alpha = texture2D(gm_BaseTexture, v_vTexcoord).a;
    gl_FragColor = vec4(v_vColour.rgb, min(1.0, authored_alpha * 3.0) * v_vColour.a);
}
