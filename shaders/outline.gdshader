shader_type canvas_item;

// Outline shader — adds a coloured outline around a sprite's alpha mask.
// Usage: assign to a Sprite2D's ShaderMaterial, tweak outline_color and outline_width.
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 2.0;

void fragment() {
    vec4 base = texture(TEXTURE, UV);
    vec2 px = outline_width / vec2(textureSize(TEXTURE, 0));

    // Sample 8 neighbours and take the max alpha
    float outline_a = 0.0;
    outline_a = max(outline_a, texture(TEXTURE, UV + vec2(-px.x, 0.0)).a);
    outline_a = max(outline_a, texture(TEXTURE, UV + vec2(px.x, 0.0)).a);
    outline_a = max(outline_a, texture(TEXTURE, UV + vec2(0.0, -px.y)).a);
    outline_a = max(outline_a, texture(TEXTURE, UV + vec2(0.0, px.y)).a);
    outline_a = max(outline_a, texture(TEXTURE, UV + vec2(-px.x, -px.y)).a);
    outline_a = max(outline_a, texture(TEXTURE, UV + vec2(px.x, -px.y)).a);
    outline_a = max(outline_a, texture(TEXTURE, UV + vec2(-px.x, px.y)).a);
    outline_a = max(outline_a, texture(TEXTURE, UV + vec2(px.x, px.y)).a);

    // Show outline where the sprite is transparent but neighbours are not
    float final_a = max(base.a, outline_a);
    vec3 final_rgb = mix(outline_color.rgb, base.rgb, base.a);
    COLOR = vec4(final_rgb, final_a);
}
