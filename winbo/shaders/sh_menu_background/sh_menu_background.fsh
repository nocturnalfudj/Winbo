//
// Fluid gradient metaball background shader for main menu
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform vec3 u_gradient_start;
uniform vec3 u_gradient_mid;
uniform vec3 u_gradient_end;
uniform vec3 u_accent_primary;
uniform vec3 u_accent_secondary;

// Soft blob function - creates smooth color contribution based on distance
float blob(vec2 uv, vec2 center, float radius) {
    float d = length(uv - center);
    return smoothstep(radius, 0.0, d);
}

void main() {
    vec2 uv = v_vTexcoord;
    float t = u_time * 1.2;
    
    // Animated blob positions using organic sine/cosine movement
    vec2 b1 = vec2(0.3 + sin(t * 0.7) * 0.2, 0.3 + cos(t * 0.5) * 0.2);
    vec2 b2 = vec2(0.7 + cos(t * 0.6) * 0.15, 0.6 + sin(t * 0.8) * 0.2);
    vec2 b3 = vec2(0.5 + sin(t * 0.4 + 1.0) * 0.25, 0.75 + cos(t * 0.3) * 0.15);
    vec2 b4 = vec2(0.2 + cos(t * 0.5 + 2.0) * 0.2, 0.85 + sin(t * 0.6) * 0.1);
    vec2 b5 = vec2(0.8 + sin(t * 0.35 + 0.5) * 0.15, 0.25 + cos(t * 0.45) * 0.2);
    
    // Dynamic blob sizes - smoothly animate between min and max radius
    float r1 = 0.45 + sin(t * 0.9 + 0.0) * 0.15;
    float r2 = 0.40 + sin(t * 0.7 + 1.0) * 0.15;
    float r3 = 0.42 + sin(t * 0.8 + 2.0) * 0.15;
    float r4 = 0.38 + sin(t * 0.6 + 3.0) * 0.12;
    float r5 = 0.35 + sin(t * 0.5 + 4.0) * 0.12;
    
    // Base diagonal gradient (start top-left to end bottom-right)
    vec3 col = mix(u_gradient_start, u_gradient_mid, uv.x * 0.4 + uv.y * 0.3);
    col = mix(col, u_gradient_end, uv.x * 0.5 + uv.y * 0.4);
    
    // Blend in animated blob colors with dynamic sizes
    col = mix(col, u_gradient_start, blob(uv, b1, r1) * 0.65);
    col = mix(col, u_gradient_end, blob(uv, b2, r2) * 0.7);
    col = mix(col, u_accent_secondary, blob(uv, b3, r3) * 0.55);
    col = mix(col, u_gradient_mid, blob(uv, b4, r4) * 0.5);
    col = mix(col, u_accent_primary, blob(uv, b5, r5) * 0.6);
    
    gl_FragColor = vec4(col, 1.0);
}
