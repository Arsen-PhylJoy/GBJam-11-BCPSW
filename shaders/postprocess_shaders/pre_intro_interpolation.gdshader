shader_type canvas_item;
render_mode unshaded;
uniform sampler2D screen : hint_screen_texture, repeat_enable, filter_nearest_mipmap;
uniform sampler2D meme_foreground: source_color;
uniform sampler2D meme_background: source_color;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy/iResolution.xy;
    float time = TIME;
    vec4 color_background = texture(meme_background, uv);
	vec4 color_foreground = texture(meme_foreground, uv);
	COLOR = mix(color_background,color_foreground,time);
	}
	