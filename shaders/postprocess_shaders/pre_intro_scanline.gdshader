shader_type canvas_item;
render_mode unshaded;
uniform sampler2D meme_foreground: source_color;
uniform sampler2D meme_background: source_color;
uniform float speed = 2;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy/iResolution.xy;
    float time = TIME*speed;
    float f = 1.-floor(time)*4.+(1.-uv.y)*300.0;
    f = clamp (f,0.,1.);
    vec4 color_background = texture(meme_background, uv);
	vec4 color_foreground = texture(meme_foreground,uv);
    float f2 = (fract(time)<uv.x)?1.:0.;
    vec4 rowColor = mix(vec4(0.), color_background, f2);
    COLOR = mix(color_foreground, rowColor, f);

    f = 1.-floor(time+1.)*4.+(1.-uv.y)*300.0;
    f = clamp (f,0.,1.);
    COLOR = mix(color_foreground, color_background, f);
}
