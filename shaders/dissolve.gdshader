shader_type canvas_item;

// Dissolve shader — progressive dissolve using hash-based noise.
// No external texture needed; noise is generated in-shader.
// Good for death animations, teleport effects, and transition wipes.
//
// progress: 0.0 = fully visible, 1.0 = fully dissolved
uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform vec4 edge_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float edge_width : hint_range(0.0, 0.5) = 0.05;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

void fragment() {
    vec4 base = texture(TEXTURE, UV);
    float n = hash(UV * 80.0);

    if (n > progress) {
        // Pixel is still visible
        COLOR = base;
    } else if (n > progress - edge_width) {
        // Pixel is at the dissolve edge — show glow
        float edge_t = (n - (progress - edge_width)) / edge_width;
        COLOR = vec4(mix(edge_color.rgb, base.rgb, edge_t), base.a);
    } else {
        // Pixel has dissolved
        COLOR = vec4(0.0);
    }
}
