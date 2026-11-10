//
// Converts a YUV video frame (luma in the base texture, chroma in v_chroma) to RGB.
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D v_chroma;

const float x = 1.164383;
const float y = 1.138393;
const float z = 1.138393;
const vec3 src_bias = vec3(16.0 / 255.0, 128.0 / 255.0, 128.0 / 255.0);
const mat3 src_xform = mat3(1.00000000 * x,  0.00000000 * y,  1.57480000 * z,
                            1.00000000 * x, -0.18732427 * y, -0.46812427 * z,
                            1.00000000 * x,  1.85560000 * y,  0.00000000 * z);

void main()
{
    float luma = texture2D(gm_BaseTexture, v_vTexcoord).r;
    vec2 chroma = texture2D(v_chroma, v_vTexcoord).rg;
    vec3 yuv = vec3(luma, chroma) - src_bias;
    gl_FragColor = vec4(yuv * src_xform, 1.0) * v_vColour;
}
