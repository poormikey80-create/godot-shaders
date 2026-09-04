shader_type canvas_item;

// Palette-swap shader — replaces up to 4 source colours with destination colours
// at runtime without touching the original sprite. Good for character variants,
// power-up states, or seasonal skins.
//
// Set src_color_N to the colours in your original sprite.
// Set dst_color_N to the replacement colours.
// threshold controls match tolerance — 0.05 is tight, 0.15 is forgiving.
uniform vec4 src_color_0 : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 src_color_1 : source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 src_color_2 : source_color = vec4(0.0, 0.0, 1.0, 1.0);
uniform vec4 src_color_3 : source_color = vec4(1.0, 1.0, 0.0, 1.0);

uniform vec4 dst_color_0 : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform vec4 dst_color_1 : source_color = vec4(0.0, 0.5, 1.0, 1.0);
uniform vec4 dst_color_2 : source_color = vec4(0.5, 0.0, 1.0, 1.0);
uniform vec4 dst_color_3 : source_color = vec4(0.5, 1.0, 0.0, 1.0);

uniform float threshold : hint_range(0.0, 0.5) = 0.05;

void fragment() {
    vec4 col = texture(TEXTURE, UV);
    vec3 diff;

    diff = abs(col.rgb - src_color_0.rgb);
    if (all(lessThan(diff, vec3(threshold)))) {
        COLOR = vec4(dst_color_0.rgb, col.a);
        return;
    }

    diff = abs(col.rgb - src_color_1.rgb);
    if (all(lessThan(diff, vec3(threshold)))) {
        COLOR = vec4(dst_color_1.rgb, col.a);
        return;
    }

    diff = abs(col.rgb - src_color_2.rgb);
    if (all(lessThan(diff, vec3(threshold)))) {
        COLOR = vec4(dst_color_2.rgb, col.a);
        return;
    }

    diff = abs(col.rgb - src_color_3.rgb);
    if (all(lessThan(diff, vec3(threshold)))) {
        COLOR = vec4(dst_color_3.rgb, col.a);
        return;
    }

    COLOR = col;
}
