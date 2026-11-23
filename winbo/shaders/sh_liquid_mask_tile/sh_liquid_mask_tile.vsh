attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vMask;

// xy: room position of the wave mask's top-left; zw: room units to mask UV.
uniform vec4 u_mask_frame;

void main()
{
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_vMask = ((gm_Matrices[MATRIX_WORLD] * object_space_pos).xy - u_mask_frame.xy) * u_mask_frame.zw;
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
