# godot-shaders

A small collection of 2D shaders for Godot 4 that I use in every jam entry.
Copy them into your project, assign to a `Sprite2D`'s ShaderMaterial, and tweak
the uniforms in the inspector. No external dependencies, no addons, no fuss.

## Shaders

### outline.gdshader

Adds a coloured outline around a sprite's alpha mask using 8-neighbour
sampling. Good for selection indicators, making the player readable against
same-colour backgrounds, or cheap glow on power-up pickups.

**Uniforms**

| Uniform | Type | Default | Range |
|---------|------|---------|-------|
| `outline_color` | vec4 | white | — |
| `outline_width` | float | 2.0 | 0.0–10.0 |

### palette_swap.gdshader

Replaces up to 4 source colours with destination colours at runtime, without
touching the original sprite. This is how I do character variants — same sprite,
4 different colour schemes, zero duplicate textures. The threshold uniform
controls how forgiving the colour match is.

**Uniforms**

| Uniform | Type | Default |
|---------|------|---------|
| `src_color_0`–`src_color_3` | vec4 | red, green, blue, yellow |
| `dst_color_0`–`dst_color_3` | vec4 | orange, cyan, purple, lime |
| `threshold` | float | 0.05 |

### dissolve.gdshader

Progressive dissolve using hash-based noise. No external texture needed — the
noise is generated in-shader. Good for death animations, teleport effects, and
transition wipes. The `edge_color` uniform gives a glow band at the dissolve
frontier, which I think looks nice but you can set `edge_width` to 0 if you
disagree.

**Uniforms**

| Uniform | Type | Default | Range |
|---------|------|---------|-------|
| `progress` | float | 0.0 | 0.0–1.0 |
| `edge_color` | vec4 | orange | — |
| `edge_width` | float | 0.05 | 0.0–0.5 |

## Usage

1. Copy `shaders/*.gdshader` into your Godot 4 project (I put them in
   `addons/shaders/` but anywhere works).
2. Select a `Sprite2D` or `TextureRect`.
3. In the inspector, add a `ShaderMaterial` and load the shader file.
4. Adjust uniforms. For palette-swap, eyedrop the source colours from your
   sprite in Aseprite first — makes matching a lot less guesswork.

## Why

I re-typed the outline shader three times across two jams before I accepted
that I should just put it in a repo. The palette-swap one came from a game
where I needed the player to wear four team colours and I refused to export
four sprites for it. The dissolve shader was a Tuesday afternoon that went
too far.

## License

MIT. Use it in your commercial game, no credit needed.
